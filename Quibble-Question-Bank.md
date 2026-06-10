# Quibble — Question Bank

**Quibble** is a fast, playful trivia duel app. Tagline: *"7 questions. Endless battles."*
A match is 7 multiple-choice questions, 4 options each, 10 seconds per question,
played against a bot opponent.

## How a question works
- Each question has exactly **4 options** and **one correct answer**.
- Players get **10 seconds** to answer.
- **Scoring:** correct = 100 pts, plus a speed bonus up to +50 (more time left = more
  bonus), plus a +25 streak bonus once you have 3 correct in a row. Wrong or timeout = 0.

## Data shape (per question)
```
{ topic, question, options: [4 strings], correctIndex: 0–3 }
```
The correct option is marked with ✅ below.

**Total questions: 100** (10 topics × 10 each)

## Topics (10)
- **Cricket** — Howzat?! Bats, balls and big finishes.
- **Bollywood** — Drama, dance numbers and dialogue.
- **Tech** — Chips, code and the people behind them.
- **Geography** — Rivers, capitals and curious borders.
- **Food** — Snacks, spices and street eats.
- **History** — Old stuff. Surprisingly spicy.
- **Music** — Beats, bands and bangers.
- **Fitness** — Reps, sets and sweat trivia.
- **Science** — Atoms, planets and lab magic.
- **Movies** — Blockbusters, quotes and classics.

---

## Cricket (10 questions)

**1. How many players does a cricket team have on the field?**
- A. 9
- B. 10
- C. 11  ✅
- D. 12

**2. Who is known as the “God of Cricket”?**
- A. Virat Kohli
- B. Sachin Tendulkar  ✅
- C. MS Dhoni
- D. Kapil Dev

**3. How many balls are bowled in one over?**
- A. 4
- B. 5
- C. 6  ✅
- D. 8

**4. Which team won the very first Cricket World Cup in 1975?**
- A. Australia
- B. England
- C. India
- D. West Indies  ✅

**5. What does LBW stand for?**
- A. Long Ball Wide
- B. Leg Before Wicket  ✅
- C. Last Batter Walks
- D. Low Bounce Warning

**6. Who captained India to the 2011 World Cup title?**
- A. MS Dhoni  ✅
- B. Sourav Ganguly
- C. Rohit Sharma
- D. Rahul Dravid

**7. What is a batter’s score of zero called?**
- A. A blank
- B. A duck  ✅
- C. A goose
- D. A zero hero

**8. Which is the shortest international format?**
- A. Test
- B. ODI
- C. T20  ✅
- D. First-class

**9. How many runs is a hit over the boundary on the full?**
- A. 2
- B. 4
- C. 6  ✅
- D. 8

**10. Which country hosts the IPL?**
- A. Australia
- B. England
- C. South Africa
- D. India  ✅


## Bollywood (10 questions)

**1. Who is called the “King of Bollywood”?**
- A. Salman Khan
- B. Shah Rukh Khan  ✅
- C. Aamir Khan
- D. Hrithik Roshan

**2. “Mogambo khush hua” is a famous line from which film?**
- A. Sholay
- B. Don
- C. Mr. India  ✅
- D. Deewaar

**3. Which film features the iconic villain Gabbar Singh?**
- A. Sholay  ✅
- B. Zanjeer
- C. Karan Arjun
- D. Baazigar

**4. Which Bollywood film ran in Mumbai theatres for over 20 years?**
- A. Lagaan
- B. Dilwale Dulhania Le Jayenge  ✅
- C. Kabhi Khushi Kabhie Gham
- D. Hum Aapke Hain Koun

**5. Which actor is nicknamed “Mr. Perfectionist”?**
- A. Aamir Khan  ✅
- B. Ranbir Kapoor
- C. Akshay Kumar
- D. Ajay Devgn

**6. “Naatu Naatu”, the Oscar-winning song, is from which film?**
- A. Baahubali
- B. RRR  ✅
- C. Pushpa
- D. KGF

**7. Who played the title role in the M.S. Dhoni biopic?**
- A. Ranveer Singh
- B. Vicky Kaushal
- C. Sushant Singh Rajput  ✅
- D. Rajkummar Rao

**8. Which was the first Indian film nominated for the Best Foreign Film Oscar?**
- A. Mother India  ✅
- B. Mughal-e-Azam
- C. Lagaan
- D. Salaam Bombay!

**9. Amitabh Bachchan rose to fame as which on-screen persona?**
- A. The romantic hero
- B. The angry young man  ✅
- C. The comedy king
- D. The action star

**10. Which 2001 film about cricket and colonial taxes earned an Oscar nod?**
- A. Swades
- B. Chak De! India
- C. Lagaan  ✅
- D. Iqbal


## Tech (10 questions)

**1. What does CPU stand for?**
- A. Central Processing Unit  ✅
- B. Computer Power Unit
- C. Core Program Utility
- D. Central Program Unit

**2. Who co-founded Apple alongside Steve Jobs?**
- A. Bill Gates
- B. Steve Wozniak  ✅
- C. Jeff Bezos
- D. Larry Page

**3. What does “www” stand for?**
- A. World Wide Web  ✅
- B. Web World Wide
- C. Wide Web World
- D. World Web Window

**4. Which company makes the Pixel phone?**
- A. Samsung
- B. Apple
- C. Google  ✅
- D. OnePlus

**5. Which programming language shares its name with a snake?**
- A. Java
- B. Ruby
- C. Python  ✅
- D. Rust

**6. What does AI stand for?**
- A. Automated Input
- B. Artificial Intelligence  ✅
- C. Advanced Internet
- D. Applied Informatics

**7. Which company created the Windows operating system?**
- A. IBM
- B. Apple
- C. Intel
- D. Microsoft  ✅

**8. RAM is best described as a computer’s…**
- A. Permanent storage
- B. Short-term memory  ✅
- C. Graphics engine
- D. Power supply

**9. Who founded SpaceX?**
- A. Elon Musk  ✅
- B. Mark Zuckerberg
- C. Sundar Pichai
- D. Sam Altman

**10. What does USB stand for?**
- A. Universal Serial Bus  ✅
- B. United System Board
- C. Universal System Backup
- D. Ultra Speed Bus


## Geography (10 questions)

**1. What is the largest ocean on Earth?**
- A. Atlantic
- B. Indian
- C. Arctic
- D. Pacific  ✅

**2. What is the capital of Australia?**
- A. Sydney
- B. Canberra  ✅
- C. Melbourne
- D. Perth

**3. The Sahara desert is on which continent?**
- A. Asia
- B. South America
- C. Africa  ✅
- D. Australia

**4. Which country is shaped like a boot?**
- A. Spain
- B. Italy  ✅
- C. Portugal
- D. Greece

**5. What is the smallest country in the world?**
- A. Monaco
- B. Malta
- C. Vatican City  ✅
- D. San Marino

**6. Mount Everest sits on the border of Nepal and which country?**
- A. India
- B. Bhutan
- C. Pakistan
- D. China  ✅

**7. The Great Barrier Reef lies off the coast of which country?**
- A. Indonesia
- B. Australia  ✅
- C. Philippines
- D. Fiji

**8. Which country has the largest population?**
- A. China
- B. USA
- C. India  ✅
- D. Indonesia

**9. What is the capital of Japan?**
- A. Osaka
- B. Kyoto
- C. Tokyo  ✅
- D. Nagoya

**10. Which river flows through Egypt?**
- A. Amazon
- B. Nile  ✅
- C. Danube
- D. Ganges


## Food (10 questions)

**1. What is the main ingredient in guacamole?**
- A. Cucumber
- B. Avocado  ✅
- C. Zucchini
- D. Green peas

**2. Sushi originally comes from which country?**
- A. China
- B. Thailand
- C. Korea
- D. Japan  ✅

**3. Which spice is the most expensive by weight?**
- A. Cardamom
- B. Vanilla
- C. Saffron  ✅
- D. Clove

**4. Paneer is a type of…**
- A. Bread
- B. Cheese  ✅
- C. Lentil
- D. Yogurt

**5. The Margherita pizza’s colors honor which country’s flag?**
- A. France
- B. Mexico
- C. Italy  ✅
- D. Hungary

**6. A classic dosa batter is made from rice and…**
- A. Chickpeas
- B. Lentils  ✅
- C. Corn
- D. Wheat

**7. Which fruit is called the “king of fruits” in India?**
- A. Banana
- B. Jackfruit
- C. Mango  ✅
- D. Papaya

**8. Chocolate is made from which beans?**
- A. Coffee beans
- B. Cocoa beans  ✅
- C. Vanilla beans
- D. Soy beans

**9. Kimchi is a staple dish from which country?**
- A. Japan
- B. Vietnam
- C. Korea  ✅
- D. China

**10. Wine is traditionally made by fermenting…**
- A. Apples
- B. Grapes  ✅
- C. Barley
- D. Rice


## History (10 questions)

**1. In which year did India gain independence?**
- A. 1942
- B. 1945
- C. 1947  ✅
- D. 1950

**2. Who built the Taj Mahal?**
- A. Akbar
- B. Shah Jahan  ✅
- C. Aurangzeb
- D. Humayun

**3. Who was the first person to walk on the Moon?**
- A. Buzz Aldrin
- B. Yuri Gagarin
- C. Neil Armstrong  ✅
- D. John Glenn

**4. The Great Wall is located in which country?**
- A. Japan
- B. Mongolia
- C. India
- D. China  ✅

**5. Who is known as the “Mahatma”?**
- A. Jawaharlal Nehru
- B. Mohandas Gandhi  ✅
- C. Subhas Chandra Bose
- D. Sardar Patel

**6. In which year did World War II end?**
- A. 1943
- B. 1944
- C. 1945  ✅
- D. 1946

**7. Ancient Egyptians wrote on paper made from which plant?**
- A. Bamboo
- B. Papyrus  ✅
- C. Cotton
- D. Palm

**8. Who reached India by sea in 1498?**
- A. Columbus
- B. Magellan
- C. Vasco da Gama  ✅
- D. Marco Polo

**9. The Colosseum stands in which city?**
- A. Athens
- B. Rome  ✅
- C. Istanbul
- D. Cairo

**10. Who founded the Maurya Empire?**
- A. Ashoka
- B. Chandragupta Maurya  ✅
- C. Bindusara
- D. Harsha


## Music (10 questions)

**1. How many strings does a standard guitar have?**
- A. 4
- B. 5
- C. 6  ✅
- D. 7

**2. Which instrument has 88 keys?**
- A. Organ
- B. Accordion
- C. Piano  ✅
- D. Harpsichord

**3. A. R. Rahman won two Oscars for which film’s music?**
- A. Lagaan
- B. Slumdog Millionaire  ✅
- C. Life of Pi
- D. RRR

**4. Which K-pop group released “Dynamite”?**
- A. Blackpink
- B. EXO
- C. BTS  ✅
- D. Stray Kids

**5. Which composer kept writing music after going deaf?**
- A. Mozart
- B. Bach
- C. Beethoven  ✅
- D. Chopin

**6. The Beatles formed in which city?**
- A. London
- B. Manchester
- C. Liverpool  ✅
- D. Dublin

**7. The tabla is a pair of…**
- A. Flutes
- B. Drums  ✅
- C. Cymbals
- D. Strings

**8. Taylor Swift’s fans are known as…**
- A. Swifters
- B. Swifties  ✅
- C. Taylors
- D. TSquad

**9. Who is celebrated as the “Nightingale of India”?**
- A. Asha Bhosle
- B. Shreya Ghoshal
- C. Lata Mangeshkar  ✅
- D. Alka Yagnik

**10. Which artist is nicknamed the “Queen of Pop”?**
- A. Beyoncé
- B. Madonna  ✅
- C. Rihanna
- D. Lady Gaga


## Fitness (10 questions)

**1. A plank primarily strengthens which muscles?**
- A. Calves
- B. Core  ✅
- C. Biceps
- D. Neck

**2. Yoga originated in which country?**
- A. China
- B. Nepal
- C. India  ✅
- D. Thailand

**3. Which vitamin does your body make from sunlight?**
- A. Vitamin A
- B. Vitamin B12
- C. Vitamin C
- D. Vitamin D  ✅

**4. Squats mainly work which part of the body?**
- A. Shoulders
- B. Legs and glutes  ✅
- C. Chest
- D. Forearms

**5. “Cardio” is short for which word?**
- A. Cardiology
- B. Cardiovascular  ✅
- C. Cardiogram
- D. Cardinal

**6. How long is a full marathon?**
- A. 32.2 km
- B. 38.5 km
- C. 42.2 km  ✅
- D. 50 km

**7. Which nutrient is most important for muscle repair?**
- A. Sugar
- B. Protein  ✅
- C. Fiber
- D. Sodium

**8. Push-ups primarily target which muscle group?**
- A. Chest  ✅
- B. Hamstrings
- C. Lower back
- D. Calves

**9. What popular daily step goal became a worldwide default?**
- A. 5,000
- B. 8,000
- C. 10,000  ✅
- D. 15,000

**10. Which of these is a classic stretching-based workout?**
- A. HIIT
- B. Pilates  ✅
- C. Powerlifting
- D. Sprinting


## Science (10 questions)

**1. What is the chemical formula for water?**
- A. CO2
- B. H2O  ✅
- C. O2
- D. NaCl

**2. Which planet is known as the Red Planet?**
- A. Venus
- B. Jupiter
- C. Mars  ✅
- D. Mercury

**3. How many chromosomes do humans have?**
- A. 23
- B. 42
- C. 46  ✅
- D. 48

**4. Which gas do plants absorb from the air?**
- A. Oxygen
- B. Nitrogen
- C. Carbon dioxide  ✅
- D. Hydrogen

**5. Who described gravity after famously watching an apple fall?**
- A. Einstein
- B. Newton  ✅
- C. Galileo
- D. Darwin

**6. What is the smallest unit of life?**
- A. Atom
- B. Molecule
- C. Cell  ✅
- D. Organ

**7. What is the hardest natural substance?**
- A. Steel
- B. Quartz
- C. Diamond  ✅
- D. Granite

**8. Which organ pumps blood around the body?**
- A. Lungs
- B. Liver
- C. Brain
- D. Heart  ✅

**9. Electrons carry which electric charge?**
- A. Positive
- B. Negative  ✅
- C. Neutral
- D. Variable

**10. Roughly how fast does light travel?**
- A. 300 km/s
- B. 3,000 km/s
- C. 300,000 km/s  ✅
- D. 3 million km/s


## Movies (10 questions)

**1. Which film is the highest-grossing of all time?**
- A. Titanic
- B. Avengers: Endgame
- C. Avatar  ✅
- D. Star Wars

**2. Who directed Jurassic Park?**
- A. James Cameron
- B. Steven Spielberg  ✅
- C. George Lucas
- D. Ridley Scott

**3. “I’ll be back” is a famous line from which film?**
- A. Die Hard
- B. RoboCop
- C. The Terminator  ✅
- D. Predator

**4. Who played Iron Man in the Marvel films?**
- A. Chris Evans
- B. Robert Downey Jr.  ✅
- C. Chris Hemsworth
- D. Mark Ruffalo

**5. Simba is the hero of which animated classic?**
- A. The Jungle Book
- B. Madagascar
- C. The Lion King  ✅
- D. Zootopia

**6. Who directed both Inception and Oppenheimer?**
- A. Denis Villeneuve
- B. Christopher Nolan  ✅
- C. Martin Scorsese
- D. Quentin Tarantino

**7. Which Korean film won Best Picture at the 2020 Oscars?**
- A. Oldboy
- B. Train to Busan
- C. Parasite  ✅
- D. Burning

**8. Who directed the Baahubali films?**
- A. S. S. Rajamouli  ✅
- B. Mani Ratnam
- C. Shankar
- D. Prashanth Neel

**9. What is the wizarding school in Harry Potter called?**
- A. Durmstrang
- B. Ilvermorny
- C. Beauxbatons
- D. Hogwarts  ✅

**10. What was Pixar’s first full-length film?**
- A. A Bug’s Life
- B. Monsters, Inc.
- C. Toy Story  ✅
- D. Finding Nemo

