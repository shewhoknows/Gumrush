import Foundation

enum LiveDuelConnectionState: Equatable {
    case idle
    case connecting
    case connected
    case disconnected
    case failed(String)
}

struct LiveDuelAnswerEvent: Equatable {
    let userID: String
    let questionIndex: Int
    let questionID: String
    let points: Int
    let score: Int
    let isCorrect: Bool
}

struct LiveDuelFinishEvent: Equatable {
    let userID: String
    let score: Int
    let correctCount: Int
}

final class LiveDuelService {
    private let config: SupabaseConfig?
    private let authClient: SupabaseRESTClient?

    init(config: SupabaseConfig?, authClient: SupabaseRESTClient?) {
        self.config = config
        self.authClient = authClient
    }

    func makeClient(matchID: String) -> SupabaseRealtimeClient? {
        guard let config else { return nil }
        return SupabaseRealtimeClient(config: config,
                                      accessToken: authClient?.accessToken,
                                      topic: "realtime:live-match-\(matchID)")
    }
}

final class SupabaseRealtimeClient {
    private let config: SupabaseConfig
    private let accessToken: String?
    private let topic: String
    private let session: URLSession
    private var socket: URLSessionWebSocketTask?
    private var receiveTask: Task<Void, Never>?
    private var heartbeatTask: Task<Void, Never>?
    private var ref = 0
    private var joinRef: String?

    var onBroadcast: ((String, [String: Any]) -> Void)?
    var onStateChange: ((LiveDuelConnectionState) -> Void)?

    init(config: SupabaseConfig,
         accessToken: String?,
         topic: String,
         session: URLSession = .shared) {
        self.config = config
        self.accessToken = accessToken
        self.topic = topic
        self.session = session
    }

    deinit {
        disconnect()
    }

    func connect(userID: String) {
        guard socket == nil else { return }
        onStateChange?(.connecting)
        guard let url = config.realtimeWebSocketURL else {
            onStateChange?(.failed("Realtime is not configured."))
            return
        }

        let task = session.webSocketTask(with: url)
        socket = task
        task.resume()
        joinRef = nextRef()
        send(topic: topic, event: "phx_join", joinRef: joinRef, payload: [
            "config": [
                "broadcast": ["ack": false, "self": false],
                "presence": ["enabled": true, "key": userID],
                "postgres_changes": [],
                "private": false
            ],
            "access_token": accessToken ?? config.anonKey
        ])
        startReceiving()
        startHeartbeat()
    }

    func disconnect() {
        if let joinRef {
            send(topic: topic, event: "phx_leave", joinRef: joinRef, payload: [:])
        }
        receiveTask?.cancel()
        heartbeatTask?.cancel()
        socket?.cancel(with: .goingAway, reason: nil)
        socket = nil
        onStateChange?(.disconnected)
    }

    func broadcast(event: String, payload: [String: Any]) {
        send(topic: topic, event: "broadcast", joinRef: joinRef, payload: [
            "event": event,
            "type": "broadcast",
            "payload": payload
        ])
    }

    private func startReceiving() {
        receiveTask = Task { [weak self] in
            guard let self else { return }
            while !Task.isCancelled {
                do {
                    guard let message = try await self.socket?.receive() else { return }
                    self.handle(message)
                } catch {
                    let onStateChange = self.onStateChange
                    await MainActor.run { onStateChange?(.failed("Live room disconnected.")) }
                    return
                }
            }
        }
    }

    private func startHeartbeat() {
        heartbeatTask = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 20_000_000_000)
                guard !Task.isCancelled else { return }
                self?.send(topic: "phoenix", event: "heartbeat", joinRef: nil, payload: [:])
            }
        }
    }

    private func handle(_ message: URLSessionWebSocketTask.Message) {
        let text: String?
        switch message {
        case .string(let value):
            text = value
        case .data(let data):
            text = String(data: data, encoding: .utf8)
        @unknown default:
            text = nil
        }
        guard let text,
              let data = text.data(using: .utf8),
              let array = try? JSONSerialization.jsonObject(with: data) as? [Any],
              array.count >= 5,
              let event = array[3] as? String else { return }

        if event == "phx_reply" {
            DispatchQueue.main.async { self.onStateChange?(.connected) }
            return
        }

        guard event == "broadcast",
              let payload = array[4] as? [String: Any],
              let userEvent = payload["event"] as? String,
              let userPayload = payload["payload"] as? [String: Any] else { return }
        DispatchQueue.main.async {
            self.onBroadcast?(userEvent, userPayload)
        }
    }

    private func send(topic: String, event: String, joinRef: String?, payload: [String: Any]) {
        guard let socket else { return }
        let frame: [Any] = [
            joinRef.map { $0 as Any } ?? NSNull(),
            nextRef(),
            topic,
            event,
            payload
        ]
        guard JSONSerialization.isValidJSONObject(frame),
              let data = try? JSONSerialization.data(withJSONObject: frame),
              let text = String(data: data, encoding: .utf8) else { return }
        socket.send(.string(text)) { [weak self] error in
            if error != nil {
                DispatchQueue.main.async { self?.onStateChange?(.failed("Live room send failed.")) }
            }
        }
    }

    private func nextRef() -> String {
        ref += 1
        return "\(ref)"
    }
}

private extension SupabaseConfig {
    var realtimeWebSocketURL: URL? {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.scheme = url.scheme == "http" ? "ws" : "wss"
        components?.path = "/realtime/v1/websocket"
        components?.queryItems = [
            URLQueryItem(name: "apikey", value: anonKey),
            URLQueryItem(name: "vsn", value: "2.0.0")
        ]
        return components?.url
    }
}

@MainActor
final class LiveDuelSession: ObservableObject {
    @Published private(set) var connectionState: LiveDuelConnectionState = .idle
    @Published private(set) var opponentReady = false
    @Published private(set) var startSignal = false
    @Published private(set) var opponentFinished = false
    @Published private(set) var opponentScore = 0
    @Published private(set) var opponentCorrectCount = 0
    @Published private(set) var lastAnswer: LiveDuelAnswerEvent?
    @Published private(set) var answerEventCount = 0

    private var client: SupabaseRealtimeClient?
    private var userID: String = ""

    func connect(client: SupabaseRealtimeClient?, userID: String, displayName: String, colorName: String) {
        guard self.client == nil, let client else {
            connectionState = .failed("Live rooms need Supabase credentials.")
            return
        }
        self.client = client
        self.userID = userID
        client.onStateChange = { [weak self] state in
            Task { @MainActor in self?.connectionState = state }
        }
        client.onBroadcast = { [weak self] event, payload in
            Task { @MainActor in self?.handle(event: event, payload: payload) }
        }
        client.connect(userID: userID)
        sendReady(displayName: displayName, colorName: colorName)
    }

    func disconnect() {
        client?.broadcast(event: "player_left", payload: ["userID": userID])
        client?.disconnect()
        client = nil
    }

    func sendReady(displayName: String, colorName: String) {
        client?.broadcast(event: "player_ready", payload: [
            "userID": userID,
            "displayName": displayName,
            "colorName": colorName
        ])
    }

    func sendStart() {
        startSignal = true
        client?.broadcast(event: "match_start", payload: [
            "userID": userID,
            "sentAt": Date().timeIntervalSince1970
        ])
    }

    func sendAnswer(_ answer: AnswerRecord, questionIndex: Int, score: Int) {
        client?.broadcast(event: "answer_submitted", payload: [
            "userID": userID,
            "questionIndex": questionIndex,
            "questionID": answer.questionID,
            "points": answer.points,
            "score": score,
            "isCorrect": answer.isCorrect
        ])
    }

    func sendFinish(score: Int, correctCount: Int) {
        client?.broadcast(event: "match_finished", payload: [
            "userID": userID,
            "score": score,
            "correctCount": correctCount
        ])
    }

    private func handle(event: String, payload: [String: Any]) {
        guard (payload["userID"] as? String) != userID else { return }
        switch event {
        case "player_ready":
            opponentReady = true
        case "match_start":
            startSignal = true
        case "answer_submitted":
            guard let userID = payload["userID"] as? String,
                  let questionIndex = payload["questionIndex"] as? Int,
                  let questionID = payload["questionID"] as? String,
                  let points = payload["points"] as? Int,
                  let score = payload["score"] as? Int,
                  let isCorrect = payload["isCorrect"] as? Bool else { return }
            opponentScore = score
            lastAnswer = LiveDuelAnswerEvent(userID: userID,
                                             questionIndex: questionIndex,
                                             questionID: questionID,
                                             points: points,
                                             score: score,
                                             isCorrect: isCorrect)
            answerEventCount += 1
        case "match_finished":
            opponentFinished = true
            opponentScore = payload["score"] as? Int ?? opponentScore
            opponentCorrectCount = payload["correctCount"] as? Int ?? opponentCorrectCount
        case "player_left":
            connectionState = .disconnected
        default:
            break
        }
    }
}
