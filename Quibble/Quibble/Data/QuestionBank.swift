import Foundation

enum QuestionBank {

    // MARK: - Topics

    static let topics: [Topic] = [
        Topic(id: "cricket", name: "Cricket", symbol: "figure.cricket", colorName: "green",
              mascot: .competitive, blurb: "Howzat?! Bats, balls and big finishes."),
        Topic(id: "bollywood", name: "Bollywood", symbol: "star.fill", colorName: "pink",
              mascot: .excited, blurb: "Drama, dance numbers and dialogue."),
        Topic(id: "tech", name: "Tech", symbol: "cpu", colorName: "blue",
              mascot: .thinking, blurb: "Chips, code and the people behind them."),
        Topic(id: "geography", name: "Geography", symbol: "globe.asia.australia.fill", colorName: "softBlue",
              mascot: .surprised, blurb: "Rivers, capitals and curious borders."),
        Topic(id: "food", name: "Food", symbol: "fork.knife", colorName: "orange",
              mascot: .happy, blurb: "Snacks, spices and street eats."),
        Topic(id: "history", name: "History", symbol: "building.columns.fill", colorName: "peach",
              mascot: .sleepy, blurb: "Old stuff. Surprisingly spicy."),
        Topic(id: "music", name: "Music", symbol: "music.note", colorName: "purple",
              mascot: .proud, blurb: "Beats, bands and bangers."),
        Topic(id: "fitness", name: "Fitness", symbol: "dumbbell.fill", colorName: "red",
              mascot: .competitive, blurb: "Reps, sets and sweat trivia."),
        Topic(id: "science", name: "Science", symbol: "testtube.2", colorName: "deepGreen",
              mascot: .confused, blurb: "Atoms, planets and lab magic."),
        Topic(id: "movies", name: "Movies", symbol: "film.fill", colorName: "yellow",
              mascot: .happy, blurb: "Blockbusters, quotes and classics."),
    ]

    static func topic(_ id: String) -> Topic? {
        topics.first { $0.id == id }
    }

    // MARK: - Question sets

    static func questions(for topicID: String) -> [Question] {
        all.filter { $0.topicID == topicID }
    }

    /// Random 7-question set for a topic.
    static func matchSet(topicID: String, count: Int = 7) -> [Question] {
        Array(questions(for: topicID).shuffled().prefix(count))
    }

    /// Deterministic mixed set for the daily challenge — same all day, new every day.
    static func dailySet(dateKey: String, count: Int = 7) -> [Question] {
        var rng = SeededGenerator(seed: dateKey.stableHash)
        let shuffledTopics = topics.shuffled(using: &rng)
        var set: [Question] = []
        for topic in shuffledTopics.prefix(count) {
            let pool = questions(for: topic.id)
            if let q = pool.randomElement(using: &rng) {
                set.append(q)
            }
        }
        return set.shuffled(using: &rng)
    }

    // MARK: - The bank

    private static func q(_ id: String, _ topic: String, _ text: String,
                          _ options: [String], _ correct: Int) -> Question {
        Question(id: id, topicID: topic, text: text, options: options, correctIndex: correct)
    }

    static let all: [Question] = [

        // Cricket
        q("cr1", "cricket", "How many players does a cricket team have on the field?",
          ["9", "10", "11", "12"], 2),
        q("cr2", "cricket", "Who is known as the “God of Cricket”?",
          ["Virat Kohli", "Sachin Tendulkar", "MS Dhoni", "Kapil Dev"], 1),
        q("cr3", "cricket", "How many balls are bowled in one over?",
          ["4", "5", "6", "8"], 2),
        q("cr4", "cricket", "Which team won the very first Cricket World Cup in 1975?",
          ["Australia", "England", "India", "West Indies"], 3),
        q("cr5", "cricket", "What does LBW stand for?",
          ["Long Ball Wide", "Leg Before Wicket", "Last Batter Walks", "Low Bounce Warning"], 1),
        q("cr6", "cricket", "Who captained India to the 2011 World Cup title?",
          ["MS Dhoni", "Sourav Ganguly", "Rohit Sharma", "Rahul Dravid"], 0),
        q("cr7", "cricket", "What is a batter’s score of zero called?",
          ["A blank", "A duck", "A goose", "A zero hero"], 1),
        q("cr8", "cricket", "Which is the shortest international format?",
          ["Test", "ODI", "T20", "First-class"], 2),
        q("cr9", "cricket", "How many runs is a hit over the boundary on the full?",
          ["2", "4", "6", "8"], 2),
        q("cr10", "cricket", "Which country hosts the IPL?",
          ["Australia", "England", "South Africa", "India"], 3),

        // Bollywood
        q("bw1", "bollywood", "Who is called the “King of Bollywood”?",
          ["Salman Khan", "Shah Rukh Khan", "Aamir Khan", "Hrithik Roshan"], 1),
        q("bw2", "bollywood", "“Mogambo khush hua” is a famous line from which film?",
          ["Sholay", "Don", "Mr. India", "Deewaar"], 2),
        q("bw3", "bollywood", "Which film features the iconic villain Gabbar Singh?",
          ["Sholay", "Zanjeer", "Karan Arjun", "Baazigar"], 0),
        q("bw4", "bollywood", "Which Bollywood film ran in Mumbai theatres for over 20 years?",
          ["Lagaan", "Dilwale Dulhania Le Jayenge", "Kabhi Khushi Kabhie Gham", "Hum Aapke Hain Koun"], 1),
        q("bw5", "bollywood", "Which actor is nicknamed “Mr. Perfectionist”?",
          ["Aamir Khan", "Ranbir Kapoor", "Akshay Kumar", "Ajay Devgn"], 0),
        q("bw6", "bollywood", "“Naatu Naatu”, the Oscar-winning song, is from which film?",
          ["Baahubali", "RRR", "Pushpa", "KGF"], 1),
        q("bw7", "bollywood", "Who played the title role in the M.S. Dhoni biopic?",
          ["Ranveer Singh", "Vicky Kaushal", "Sushant Singh Rajput", "Rajkummar Rao"], 2),
        q("bw8", "bollywood", "Which was the first Indian film nominated for the Best Foreign Film Oscar?",
          ["Mother India", "Mughal-e-Azam", "Lagaan", "Salaam Bombay!"], 0),
        q("bw9", "bollywood", "Amitabh Bachchan rose to fame as which on-screen persona?",
          ["The romantic hero", "The angry young man", "The comedy king", "The action star"], 1),
        q("bw10", "bollywood", "Which 2001 film about cricket and colonial taxes earned an Oscar nod?",
          ["Swades", "Chak De! India", "Lagaan", "Iqbal"], 2),

        // Tech
        q("te1", "tech", "What does CPU stand for?",
          ["Central Processing Unit", "Computer Power Unit", "Core Program Utility", "Central Program Unit"], 0),
        q("te2", "tech", "Who co-founded Apple alongside Steve Jobs?",
          ["Bill Gates", "Steve Wozniak", "Jeff Bezos", "Larry Page"], 1),
        q("te3", "tech", "What does “www” stand for?",
          ["World Wide Web", "Web World Wide", "Wide Web World", "World Web Window"], 0),
        q("te4", "tech", "Which company makes the Pixel phone?",
          ["Samsung", "Apple", "Google", "OnePlus"], 2),
        q("te5", "tech", "Which programming language shares its name with a snake?",
          ["Java", "Ruby", "Python", "Rust"], 2),
        q("te6", "tech", "What does AI stand for?",
          ["Automated Input", "Artificial Intelligence", "Advanced Internet", "Applied Informatics"], 1),
        q("te7", "tech", "Which company created the Windows operating system?",
          ["IBM", "Apple", "Intel", "Microsoft"], 3),
        q("te8", "tech", "RAM is best described as a computer’s…",
          ["Permanent storage", "Short-term memory", "Graphics engine", "Power supply"], 1),
        q("te9", "tech", "Who founded both Tesla’s rival-beating rockets at SpaceX and the X platform?",
          ["Elon Musk", "Mark Zuckerberg", "Sundar Pichai", "Sam Altman"], 0),
        q("te10", "tech", "What does USB stand for?",
          ["Universal Serial Bus", "United System Board", "Universal System Backup", "Ultra Speed Bus"], 0),

        // Geography
        q("ge1", "geography", "What is the largest ocean on Earth?",
          ["Atlantic", "Indian", "Arctic", "Pacific"], 3),
        q("ge2", "geography", "What is the capital of Australia?",
          ["Sydney", "Canberra", "Melbourne", "Perth"], 1),
        q("ge3", "geography", "The Sahara desert is on which continent?",
          ["Asia", "South America", "Africa", "Australia"], 2),
        q("ge4", "geography", "Which country is shaped like a boot?",
          ["Spain", "Italy", "Portugal", "Greece"], 1),
        q("ge5", "geography", "What is the smallest country in the world?",
          ["Monaco", "Malta", "Vatican City", "San Marino"], 2),
        q("ge6", "geography", "Mount Everest sits on the border of Nepal and which country?",
          ["India", "Bhutan", "Pakistan", "China"], 3),
        q("ge7", "geography", "The Great Barrier Reef lies off the coast of which country?",
          ["Indonesia", "Australia", "Philippines", "Fiji"], 1),
        q("ge8", "geography", "Which country has the largest population?",
          ["China", "USA", "India", "Indonesia"], 2),
        q("ge9", "geography", "What is the capital of Japan?",
          ["Osaka", "Kyoto", "Tokyo", "Nagoya"], 2),
        q("ge10", "geography", "Which river flows through Egypt?",
          ["Amazon", "Nile", "Danube", "Ganges"], 1),

        // Food
        q("fo1", "food", "What is the main ingredient in guacamole?",
          ["Cucumber", "Avocado", "Zucchini", "Green peas"], 1),
        q("fo2", "food", "Sushi originally comes from which country?",
          ["China", "Thailand", "Korea", "Japan"], 3),
        q("fo3", "food", "Which spice is the most expensive by weight?",
          ["Cardamom", "Vanilla", "Saffron", "Clove"], 2),
        q("fo4", "food", "Paneer is a type of…",
          ["Bread", "Cheese", "Lentil", "Yogurt"], 1),
        q("fo5", "food", "The Margherita pizza’s colors honor which country’s flag?",
          ["France", "Mexico", "Italy", "Hungary"], 2),
        q("fo6", "food", "A classic dosa batter is made from rice and…",
          ["Chickpeas", "Lentils", "Corn", "Wheat"], 1),
        q("fo7", "food", "Which fruit is called the “king of fruits” in India?",
          ["Banana", "Jackfruit", "Mango", "Papaya"], 2),
        q("fo8", "food", "Chocolate is made from which beans?",
          ["Coffee beans", "Cocoa beans", "Vanilla beans", "Soy beans"], 1),
        q("fo9", "food", "Kimchi is a staple dish from which country?",
          ["Japan", "Vietnam", "Korea", "China"], 2),
        q("fo10", "food", "Wine is traditionally made by fermenting…",
          ["Apples", "Grapes", "Barley", "Rice"], 1),

        // History
        q("hi1", "history", "In which year did India gain independence?",
          ["1942", "1945", "1947", "1950"], 2),
        q("hi2", "history", "Who built the Taj Mahal?",
          ["Akbar", "Shah Jahan", "Aurangzeb", "Humayun"], 1),
        q("hi3", "history", "Who was the first person to walk on the Moon?",
          ["Buzz Aldrin", "Yuri Gagarin", "Neil Armstrong", "John Glenn"], 2),
        q("hi4", "history", "The Great Wall is located in which country?",
          ["Japan", "Mongolia", "India", "China"], 3),
        q("hi5", "history", "Who is known as the “Mahatma”?",
          ["Jawaharlal Nehru", "Mohandas Gandhi", "Subhas Chandra Bose", "Sardar Patel"], 1),
        q("hi6", "history", "In which year did World War II end?",
          ["1943", "1944", "1945", "1946"], 2),
        q("hi7", "history", "Ancient Egyptians wrote on paper made from which plant?",
          ["Bamboo", "Papyrus", "Cotton", "Palm"], 1),
        q("hi8", "history", "Who reached India by sea in 1498?",
          ["Columbus", "Magellan", "Vasco da Gama", "Marco Polo"], 2),
        q("hi9", "history", "The Colosseum stands in which city?",
          ["Athens", "Rome", "Istanbul", "Cairo"], 1),
        q("hi10", "history", "Who founded the Maurya Empire?",
          ["Ashoka", "Chandragupta Maurya", "Bindusara", "Harsha"], 1),

        // Music
        q("mu1", "music", "How many strings does a standard guitar have?",
          ["4", "5", "6", "7"], 2),
        q("mu2", "music", "Which instrument has 88 keys?",
          ["Organ", "Accordion", "Piano", "Harpsichord"], 2),
        q("mu3", "music", "A. R. Rahman won two Oscars for which film’s music?",
          ["Lagaan", "Slumdog Millionaire", "Life of Pi", "RRR"], 1),
        q("mu4", "music", "Which K-pop group released “Dynamite”?",
          ["Blackpink", "EXO", "BTS", "Stray Kids"], 2),
        q("mu5", "music", "Which composer kept writing music after going deaf?",
          ["Mozart", "Bach", "Beethoven", "Chopin"], 2),
        q("mu6", "music", "The Beatles formed in which city?",
          ["London", "Manchester", "Liverpool", "Dublin"], 2),
        q("mu7", "music", "The tabla is a pair of…",
          ["Flutes", "Drums", "Cymbals", "Strings"], 1),
        q("mu8", "music", "Taylor Swift’s fans are known as…",
          ["Swifters", "Swifties", "Taylors", "TSquad"], 1),
        q("mu9", "music", "Who is celebrated as the “Nightingale of India”?",
          ["Asha Bhosle", "Shreya Ghoshal", "Lata Mangeshkar", "Alka Yagnik"], 2),
        q("mu10", "music", "Which artist is nicknamed the “Queen of Pop”?",
          ["Beyoncé", "Madonna", "Rihanna", "Lady Gaga"], 1),

        // Fitness
        q("fi1", "fitness", "A plank primarily strengthens which muscles?",
          ["Calves", "Core", "Biceps", "Neck"], 1),
        q("fi2", "fitness", "Yoga originated in which country?",
          ["China", "Nepal", "India", "Thailand"], 2),
        q("fi3", "fitness", "Which vitamin does your body make from sunlight?",
          ["Vitamin A", "Vitamin B12", "Vitamin C", "Vitamin D"], 3),
        q("fi4", "fitness", "Squats mainly work which part of the body?",
          ["Shoulders", "Legs and glutes", "Chest", "Forearms"], 1),
        q("fi5", "fitness", "“Cardio” is short for which word?",
          ["Cardiology", "Cardiovascular", "Cardiogram", "Cardinal"], 1),
        q("fi6", "fitness", "How long is a full marathon?",
          ["32.2 km", "38.5 km", "42.2 km", "50 km"], 2),
        q("fi7", "fitness", "Which nutrient is most important for muscle repair?",
          ["Sugar", "Protein", "Fiber", "Sodium"], 1),
        q("fi8", "fitness", "Push-ups primarily target which muscle group?",
          ["Chest", "Hamstrings", "Lower back", "Calves"], 0),
        q("fi9", "fitness", "What popular daily step goal became a worldwide default?",
          ["5,000", "8,000", "10,000", "15,000"], 2),
        q("fi10", "fitness", "Which of these is a classic stretching-based workout?",
          ["HIIT", "Pilates", "Powerlifting", "Sprinting"], 1),

        // Science
        q("sc1", "science", "What is the chemical formula for water?",
          ["CO2", "H2O", "O2", "NaCl"], 1),
        q("sc2", "science", "Which planet is known as the Red Planet?",
          ["Venus", "Jupiter", "Mars", "Mercury"], 2),
        q("sc3", "science", "How many chromosomes do humans have?",
          ["23", "42", "46", "48"], 2),
        q("sc4", "science", "Which gas do plants absorb from the air?",
          ["Oxygen", "Nitrogen", "Carbon dioxide", "Hydrogen"], 2),
        q("sc5", "science", "Who described gravity after famously watching an apple fall?",
          ["Einstein", "Newton", "Galileo", "Darwin"], 1),
        q("sc6", "science", "What is the smallest unit of life?",
          ["Atom", "Molecule", "Cell", "Organ"], 2),
        q("sc7", "science", "What is the hardest natural substance?",
          ["Steel", "Quartz", "Diamond", "Granite"], 2),
        q("sc8", "science", "Which organ pumps blood around the body?",
          ["Lungs", "Liver", "Brain", "Heart"], 3),
        q("sc9", "science", "Electrons carry which electric charge?",
          ["Positive", "Negative", "Neutral", "Variable"], 1),
        q("sc10", "science", "Roughly how fast does light travel?",
          ["300 km/s", "3,000 km/s", "300,000 km/s", "3 million km/s"], 2),

        // Movies
        q("mo1", "movies", "Which film is the highest-grossing of all time?",
          ["Titanic", "Avengers: Endgame", "Avatar", "Star Wars"], 2),
        q("mo2", "movies", "Who directed Jurassic Park?",
          ["James Cameron", "Steven Spielberg", "George Lucas", "Ridley Scott"], 1),
        q("mo3", "movies", "“I’ll be back” is a famous line from which film?",
          ["Die Hard", "RoboCop", "The Terminator", "Predator"], 2),
        q("mo4", "movies", "Who played Iron Man in the Marvel films?",
          ["Chris Evans", "Robert Downey Jr.", "Chris Hemsworth", "Mark Ruffalo"], 1),
        q("mo5", "movies", "Simba is the hero of which animated classic?",
          ["The Jungle Book", "Madagascar", "The Lion King", "Zootopia"], 2),
        q("mo6", "movies", "Who directed both Inception and Oppenheimer?",
          ["Denis Villeneuve", "Christopher Nolan", "Martin Scorsese", "Quentin Tarantino"], 1),
        q("mo7", "movies", "Which Korean film won Best Picture at the 2020 Oscars?",
          ["Oldboy", "Train to Busan", "Parasite", "Burning"], 2),
        q("mo8", "movies", "Who directed the Baahubali films?",
          ["S. S. Rajamouli", "Mani Ratnam", "Shankar", "Prashanth Neel"], 0),
        q("mo9", "movies", "What is the wizarding school in Harry Potter called?",
          ["Durmstrang", "Ilvermorny", "Beauxbatons", "Hogwarts"], 3),
        q("mo10", "movies", "What was Pixar’s first full-length film?",
          ["A Bug’s Life", "Monsters, Inc.", "Toy Story", "Finding Nemo"], 2),
    ]
}
