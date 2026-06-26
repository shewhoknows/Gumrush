import Foundation

@main
struct ExportFullQuestionSeed {
    static func main() {
        print("-- Generated from Quibble/Quibble/Data/QuestionBank.swift.")
        print("-- Replaces seeded Quibble topic questions with the full local MVP question bank.")
        print("")
        print("begin;")
        print("")
        print("insert into public.topics (slug, title, subtitle, description, color_key, icon_asset_name, is_featured)")
        print("values")
        for (index, topic) in QuestionBank.topics.enumerated() {
            let featured = ["cricket", "bollywood", "tech", "food"].contains(topic.id) ? "true" : "false"
            let suffix = index == QuestionBank.topics.count - 1 ? "" : ","
            print("  ('\(sql(topic.id))', '\(sql(topic.name))', '\(sql(topic.blurb))', '\(sql(topic.blurb))', '\(sql(topic.colorName))', '\(sql(topic.symbol))', \(featured))\(suffix)")
        }
        print("on conflict (slug) do update set")
        print("  title = excluded.title,")
        print("  subtitle = excluded.subtitle,")
        print("  description = excluded.description,")
        print("  color_key = excluded.color_key,")
        print("  icon_asset_name = excluded.icon_asset_name,")
        print("  is_featured = excluded.is_featured,")
        print("  status = 'active';")
        print("")
        print("delete from public.daily_challenge_questions")
        print("where daily_challenge_id in (select id from public.daily_challenges where challenge_date = current_date);")
        print("")
        print("delete from public.questions")
        print("where topic_id in (select id from public.topics where slug in (\(QuestionBank.topics.map { "'\(sql($0.id))'" }.joined(separator: ", "))));")
        print("")
        print("insert into public.questions (topic_id, prompt, option_a, option_b, option_c, option_d, correct_option, difficulty, status)")
        print("values")
        for (index, question) in QuestionBank.all.enumerated() {
            let options = normalizedOptions(question.options)
            let correct = ["A", "B", "C", "D"][safe: question.correctIndex] ?? "A"
            let suffix = index == QuestionBank.all.count - 1 ? "" : ","
            print("  ((select id from public.topics where slug = '\(sql(question.topicID))'), '\(sql(question.text))', '\(sql(options[0]))', '\(sql(options[1]))', '\(sql(options[2]))', '\(sql(options[3]))', '\(correct)', '\(question.difficulty.rawValue.lowercased())', 'approved')\(suffix)")
        }
        print(";")
        print("")
        print("insert into public.daily_challenges (challenge_date, topic_id, title)")
        print("select current_date, t.id, 'Daily Challenge'")
        print("from public.topics t")
        print("where t.slug = 'cricket'")
        print("on conflict (challenge_date) do update set")
        print("  topic_id = excluded.topic_id,")
        print("  title = excluded.title,")
        print("  status = 'active';")
        print("")
        print("insert into public.daily_challenge_questions (daily_challenge_id, question_id, question_index)")
        print("select dc.id, q.id, row_number() over (order by q.created_at, q.id) - 1")
        print("from public.daily_challenges dc")
        print("join public.questions q on q.status = 'approved'")
        print("where dc.challenge_date = current_date")
        print("order by q.created_at, q.id")
        print("limit 7;")
        print("")
        print("commit;")
    }

    private static func normalizedOptions(_ options: [String]) -> [String] {
        var copy = Array(options.prefix(4))
        while copy.count < 4 {
            copy.append("")
        }
        return copy
    }

    private static func sql(_ value: String) -> String {
        value.replacingOccurrences(of: "'", with: "''")
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
