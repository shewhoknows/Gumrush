# Quibble — Question Bank

**Quibble** is a fast, playful trivia duel app. Tagline: *"7 questions. Endless battles."*
A match is 7 multiple-choice questions, 4 options each, 10 seconds per question,
played against a bot opponent.

## How a question works
- Each question has exactly **4 options** and **one correct answer**.
- Players get **10 seconds** to answer.
- **Difficulty tiers:** Easy / Medium / Hard (34 questions each per topic).
- **Scoring:** correct = 100 pts, plus a speed bonus up to +50 (more time left = more
  bonus), plus a +25 streak bonus once you have 3 correct in a row. Wrong or timeout = 0.

## Data shape (per question)
```
{ topic, difficulty, question, options: [4 strings], correctIndex: 0–3 }
```
The correct option is marked with ✅ below.

**Total questions: 1020** (10 topics × 102 each = 34 easy + 34 medium + 34 hard)

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

## Cricket (102 questions)

### Easy (34)

**1. How many players are on the field for one cricket team?**
- A. 9
- B. 10
- C. 11  ✅
- D. 12

**2. How many balls are bowled in a standard over?**
- A. 4
- B. 5
- C. 6  ✅
- D. 8

**3. A batter dismissed for zero is said to have scored a what?**
- A. Blank
- B. Duck  ✅
- C. Goose
- D. Nought-ton

**4. What does LBW stand for?**
- A. Long Ball Wide
- B. Leg Before Wicket  ✅
- C. Last Ball Won
- D. Low Bounce Warning

**5. How many runs is a ball hit over the boundary on the full worth?**
- A. 2
- B. 4
- C. 6  ✅
- D. 8

**6. How many runs is a ball that reaches the boundary along the ground worth?**
- A. 2
- B. 3
- C. 4  ✅
- D. 6

**7. Which country is widely regarded as the birthplace of cricket?**
- A. India
- B. Australia
- C. England  ✅
- D. South Africa

**8. What is the shortest of the three main international formats?**
- A. Test
- B. ODI
- C. T20  ✅
- D. First-class

**9. Who is popularly called the 'God of Cricket' in India?**
- A. Virat Kohli
- B. Sachin Tendulkar  ✅
- C. MS Dhoni
- D. Kapil Dev

**10. What is the wooden object the bowler aims to hit, made of stumps and bails, called?**
- A. Net
- B. Wicket  ✅
- C. Crease
- D. Boundary

**11. How many stumps make up a wicket?**
- A. 2
- B. 3  ✅
- C. 4
- D. 5

**12. Which famous T20 league is held in India?**
- A. BBL
- B. PSL
- C. IPL  ✅
- D. CPL

**13. In Test cricket, players traditionally wear what colour clothing?**
- A. Blue
- B. Red
- C. White  ✅
- D. Green

**14. What is the strip of pitch between the two sets of stumps called?**
- A. The deck  ✅
- B. The wicket pitch
- C. The crease
- D. The square

**15. How many innings does each team get in a standard Test match?**
- A. 1
- B. 2  ✅
- C. 3
- D. 4

**16. Who delivers the ball to the batter?**
- A. The keeper
- B. The bowler  ✅
- C. The umpire
- D. The fielder

**17. What protective gear do batters wear on their legs?**
- A. Shin guards
- B. Pads  ✅
- C. Braces
- D. Sleeves

**18. The fielder positioned directly behind the stumps to catch the ball is the what?**
- A. Slip
- B. Gully
- C. Wicketkeeper  ✅
- D. Point

**19. How many days is a standard men's Test match scheduled to last?**
- A. 3
- B. 4
- C. 5  ✅
- D. 7

**20. In which country did the very first Test match take place, against England?**
- A. India
- B. Australia  ✅
- C. South Africa
- D. West Indies

**21. What signal does an umpire give by raising one index finger?**
- A. Six
- B. Out  ✅
- C. Wide
- D. No-ball

**22. What is it called when a bowler takes three wickets with three consecutive balls?**
- A. Triple
- B. Hat-trick  ✅
- C. Treble
- D. Trifecta

**23. Which piece of equipment does the batter hold to hit the ball?**
- A. Racquet
- B. Bat  ✅
- C. Paddle
- D. Club

**24. How many runs are awarded for a 'wide' ball?**
- A. 0
- B. 1  ✅
- C. 2
- D. 4

**25. What is the name of the official who makes decisions on the field?**
- A. Referee
- B. Umpire  ✅
- C. Judge
- D. Marshal

**26. A score of 100 runs by a single batter is called a what?**
- A. Half-century
- B. Century  ✅
- C. Ton-up
- D. Maximum

**27. Which country does the cricketer Sir Don Bradman come from?**
- A. England
- B. India
- C. Australia  ✅
- D. South Africa

**28. How many overs does each side face in a standard One Day International?**
- A. 20
- B. 40
- C. 50  ✅
- D. 60

**29. What colour ball is typically used in day-night Test cricket?**
- A. Red
- B. White
- C. Pink  ✅
- D. Yellow

**30. Which trophy is contested between England and Australia?**
- A. The Ashes  ✅
- B. The Urn Cup
- C. The Border Trophy
- D. The Frank Worrell Trophy

**31. What is the act of running between the wickets to add to the score called?**
- A. A dash
- B. A run  ✅
- C. A sprint
- D. A lap

**32. Who decides field placements and bowling changes for a team?**
- A. The coach
- B. The captain  ✅
- C. The keeper
- D. The umpire

**33. What is the term for a delivery that is too high or wide and is not legal?**
- A. Bouncer
- B. Beamer
- C. No-ball or wide  ✅
- D. Yorker

**34. Which body governs international cricket worldwide?**
- A. FIFA
- B. ICC  ✅
- C. BCCI
- D. MCC


### Medium (34)

**35. Which team won the very first Cricket World Cup, held in 1975?**
- A. Australia
- B. England
- C. India
- D. West Indies  ✅

**36. Who captained India to victory in the 2011 ODI World Cup?**
- A. Sourav Ganguly
- B. MS Dhoni  ✅
- C. Rohit Sharma
- D. Rahul Dravid

**37. Who holds the record for the most runs in Test cricket?**
- A. Ricky Ponting
- B. Jacques Kallis
- C. Sachin Tendulkar  ✅
- D. Brian Lara

**38. Which bowler has taken the most wickets in Test cricket?**
- A. Shane Warne
- B. Muttiah Muralitharan  ✅
- C. Anil Kumble
- D. James Anderson

**39. Who scored the highest individual innings in men's ODI cricket, making 264?**
- A. Virender Sehwag
- B. Rohit Sharma  ✅
- C. Martin Guptill
- D. Chris Gayle

**40. Which delivery is aimed at the batter's toes or the base of the stumps, full and fast?**
- A. Bouncer
- B. Yorker  ✅
- C. Googly
- D. Doosra

**41. A leg-spinner's delivery that turns the 'wrong way' is known as a what?**
- A. Flipper
- B. Googly  ✅
- C. Carrom ball
- D. Arm ball

**42. Which country won the inaugural men's ICC T20 World Cup in 2007?**
- A. Pakistan
- B. India  ✅
- C. Australia
- D. Sri Lanka

**43. Who hit the winning six in the 2011 World Cup final for India?**
- A. Yuvraj Singh
- B. Gautam Gambhir
- C. MS Dhoni  ✅
- D. Virat Kohli

**44. What is the maximum number of overs a single bowler may bowl in a 50-over ODI innings?**
- A. 8
- B. 10  ✅
- C. 12
- D. 15

**45. Who is the only batter to have scored 400 not out in a Test innings?**
- A. Matthew Hayden
- B. Brian Lara  ✅
- C. Sachin Tendulkar
- D. Don Bradman

**46. Which Indian all-rounder lifted the 1983 World Cup as captain?**
- A. Sunil Gavaskar
- B. Kapil Dev  ✅
- C. Mohinder Amarnath
- D. Ravi Shastri

**47. What is the fielding position roughly square of the wicket on the off side, close in, called?**
- A. Mid-on
- B. Point  ✅
- C. Fine leg
- D. Long-off

**48. Sir Don Bradman finished his Test career with a batting average closest to which figure?**
- A. 75
- B. 88
- C. 99.94  ✅
- D. 110

**49. Which ground in London is known as the 'Home of Cricket'?**
- A. The Oval
- B. Lord's  ✅
- C. Edgbaston
- D. Headingley

**50. In which year did India win its first Cricket World Cup?**
- A. 1979
- B. 1983  ✅
- C. 1987
- D. 1992

**51. What is the term for dismissing a batter by hitting the stumps while they are out of their crease, done by the keeper?**
- A. Run out
- B. Stumping  ✅
- C. Caught behind
- D. Hit wicket

**52. Which Australian leg-spinner bowled the famous 'Ball of the Century' to Mike Gatting in 1993?**
- A. Stuart MacGill
- B. Shane Warne  ✅
- C. Brad Hogg
- D. Richie Benaud

**53. Who was the first batter to score 200 (a double century) in a men's ODI innings?**
- A. Sachin Tendulkar  ✅
- B. Virender Sehwag
- C. Rohit Sharma
- D. Chris Gayle

**54. Which country shares hosting and trophy rivalry with India over the Border–Gavaskar Trophy?**
- A. England
- B. Australia  ✅
- C. South Africa
- D. Pakistan

**55. How many runs short of a century is a 'nervous nineties' batter who is on 91?**
- A. 3
- B. 6
- C. 9  ✅
- D. 11

**56. Which wicketkeeper-batter holds the record for most dismissals in men's ODIs?**
- A. Adam Gilchrist
- B. MS Dhoni
- C. Kumar Sangakkara  ✅
- D. Mark Boucher

**57. What is a 'maiden over'?**
- A. An over with a wicket
- B. An over with no runs conceded  ✅
- C. A bowler's first over
- D. An over with six byes

**58. Which team won the 2019 ODI World Cup final on a boundary countback after a tied Super Over?**
- A. New Zealand
- B. England  ✅
- C. Australia
- D. India

**59. Who was the first player to score a double century in Test cricket for England, an early legend of the game?**
- A. W. G. Grace  ✅
- B. Jack Hobbs
- C. Wally Hammond
- D. Len Hutton

**60. What is the name of the very fast, short-pitched delivery aimed at the batter's head or chest?**
- A. Yorker
- B. Bouncer  ✅
- C. Half-volley
- D. Full toss

**61. Which Sri Lankan batter is famous for the 'helicopter'... no — which Indian batter popularised the 'helicopter shot'?**
- A. Suresh Raina
- B. MS Dhoni  ✅
- C. Yuvraj Singh
- D. Virender Sehwag

**62. Which country hosted and won the 1996 World Cup along with co-hosts, captained by Arjuna Ranatunga?**
- A. India
- B. Pakistan
- C. Sri Lanka  ✅
- D. Australia

**63. What is the term for a batter dismissed when the ball is bowled and dislodges the bails directly?**
- A. Caught
- B. Bowled  ✅
- C. Stumped
- D. Run out

**64. Who holds the record for the fastest century in Test cricket (off 54 balls), set in 2014?**
- A. AB de Villiers
- B. Brendon McCullum
- C. Misbah-ul-Haq  ✅
- D. Adam Gilchrist

**65. In cricket scoring, what does a bowler's 'economy rate' measure?**
- A. Runs per wicket
- B. Runs conceded per over  ✅
- C. Wickets per match
- D. Balls per wicket

**66. Which Indian opener scored a triple century in a Test against South Africa in 2008?**
- A. Rahul Dravid
- B. Virender Sehwag  ✅
- C. Gautam Gambhir
- D. Murali Vijay

**67. What is the fielding position behind the wicketkeeper on the off side, used to catch edges, called?**
- A. Gully
- B. Slip  ✅
- C. Cover
- D. Mid-wicket

**68. Which trophy do India and Pakistan and other Asian nations contest in a continental tournament?**
- A. Asia Cup  ✅
- B. Champions Trophy
- C. Nidahas Trophy
- D. Tri-Series Cup


### Hard (34)

**69. Which team posted the highest total in Test history, 952 for 6 declared, in 1997?**
- A. Australia
- B. Sri Lanka  ✅
- C. England
- D. India

**70. Who holds the record for the highest individual score in first-class cricket, 501 not out?**
- A. Brian Lara  ✅
- B. Hanif Mohammad
- C. Don Bradman
- D. Bill Ponsford

**71. Jim Laker famously took how many wickets in a single Test match against Australia in 1956?**
- A. 15
- B. 17
- C. 19  ✅
- D. 21

**72. Which bowler took all 10 wickets in a Test innings for India against Pakistan in 1999?**
- A. Harbhajan Singh
- B. Anil Kumble  ✅
- C. Javagal Srinath
- D. Bishan Bedi

**73. Who is the only cricketer to be knighted while still playing Test cricket, doing so in 1949?**
- A. Don Bradman  ✅
- B. Jack Hobbs
- C. Frank Worrell
- D. Len Hutton

**74. Who scored 172, long the highest individual innings in a men's T20 international, against Ireland in 2019?**
- A. Glenn Maxwell
- B. Hazratullah Zazai  ✅
- C. Aaron Finch
- D. Rohit Sharma

**75. What was the margin, in runs, of the largest Test victory ever — an innings and 579 runs by England in 1938?**
- A. An innings and 332
- B. An innings and 579  ✅
- C. 675 runs
- D. An innings and 851

**76. Who made 281 to help India famously defeat Australia after following on in the 2001 Kolkata Test?**
- A. Rahul Dravid
- B. VVS Laxman  ✅
- C. Sourav Ganguly
- D. Sachin Tendulkar

**77. Which spinner bowled the 'doosra' into prominence, an off-spinner's delivery that turns away from the right-hander?**
- A. Harbhajan Singh
- B. Saqlain Mushtaq  ✅
- C. Muttiah Muralitharan
- D. Graeme Swann

**78. Anil Kumble took how many Test wickets in his career, the third-highest tally?**
- A. 519
- B. 563
- C. 619  ✅
- D. 708

**79. Which English ground hosted the famous 1981 'Botham's Ashes' Test where England won after following on?**
- A. Lord's
- B. Headingley  ✅
- C. The Oval
- D. Old Trafford

**80. Who holds the record for the most catches by a non-wicketkeeper in Test cricket?**
- A. Rahul Dravid  ✅
- B. Jacques Kallis
- C. Mahela Jayawardene
- D. Ricky Ponting

**81. What is the highest successful fourth-innings run chase in Test history (418), achieved by the West Indies in 2003?**
- A. West Indies  ✅
- B. Australia
- C. South Africa
- D. India

**82. Which Pakistani pair of fast bowlers were nicknamed the 'Two Ws' in the 1990s?**
- A. Wasim Akram and Waqar Younis  ✅
- B. Wasim Bari and Waqar Hassan
- C. Waqar Younis and Wahab Riaz
- D. Wasim Akram and Wahab Riaz

**83. Who was the first bowler to reach 800 Test wickets?**
- A. Shane Warne
- B. Anil Kumble
- C. Muttiah Muralitharan  ✅
- D. Glenn McGrath

**84. Which batsman compiled 365 not out in 1958, a Test record that stood for over 35 years?**
- A. Garfield Sobers  ✅
- B. Brian Lara
- C. Len Hutton
- D. Wally Hammond

**85. In which year was the first ever ODI played, between Australia and England in Melbourne?**
- A. 1963
- B. 1971  ✅
- C. 1975
- D. 1979

**86. Which Indian captain led the team to the inaugural World Test Championship final in 2021?**
- A. MS Dhoni
- B. Virat Kohli  ✅
- C. Rohit Sharma
- D. Ajinkya Rahane

**87. Who scored 175 not out against Zimbabwe in the 1983 World Cup, rescuing India from 17 for 5?**
- A. Sunil Gavaskar
- B. Kapil Dev  ✅
- C. Mohinder Amarnath
- D. Krishnamachari Srikkanth

**88. Which wicketkeeper holds the record for most dismissals in Test cricket?**
- A. Adam Gilchrist
- B. Mark Boucher  ✅
- C. MS Dhoni
- D. Ian Healy

**89. What is the name of the delivery, popularised by Ajantha Mendis, flicked out with a bent middle finger?**
- A. Doosra
- B. Carrom ball  ✅
- C. Teesra
- D. Slider

**90. Which batter holds the record for the most runs in a single World Cup (men's, 673 in 2003)?**
- A. Ricky Ponting
- B. Sachin Tendulkar  ✅
- C. Matthew Hayden
- D. Adam Gilchrist

**91. Who took a hat-trick on Test debut, a feat shared by very few, doing it for Australia in 1994–95?**
- A. Damien Fleming  ✅
- B. Shane Warne
- C. Glenn McGrath
- D. Jason Gillespie

**92. The 'Bodyline' tactic of the 1932–33 Ashes was devised by which England captain?**
- A. Walter Hammond
- B. Douglas Jardine  ✅
- C. Gubby Allen
- D. Percy Chapman

**93. Which South African scored the fastest ODI century (off 31 balls) in 2015?**
- A. Faf du Plessis
- B. AB de Villiers  ✅
- C. Hashim Amla
- D. Quinton de Kock

**94. Who is the only player to have scored a century and taken a hat-trick in the same Test match? (England all-rounder)**
- A. Ian Botham  ✅
- B. Andrew Flintoff
- C. Wilfred Rhodes
- D. Tony Greig

**95. Which Indian spin quartet of the 1960s–70s included Bedi, Chandrasekhar, Prasanna and which fourth bowler?**
- A. Erapalli Prasanna
- B. Srinivas Venkataraghavan  ✅
- C. Dilip Doshi
- D. Bhagwath Chandrasekhar

**96. What is the highest team total in a men's ODI innings (498), set by England in 2022?**
- A. England  ✅
- B. South Africa
- C. India
- D. Australia

**97. Which Pakistani batter scored 337 over more than 16 hours against the West Indies in 1958?**
- A. Hanif Mohammad  ✅
- B. Saeed Anwar
- C. Javed Miandad
- D. Zaheer Abbas

**98. Which captain led the West Indies' dominant side through the late 1970s and 1980s, retiring undefeated in Test series as skipper?**
- A. Viv Richards
- B. Clive Lloyd  ✅
- C. Gordon Greenidge
- D. Malcolm Marshall

**99. In Duckworth–Lewis–Stern method, what is being recalculated when rain interrupts a limited-overs match?**
- A. Run rate only
- B. A revised target  ✅
- C. Bowling quotas
- D. Powerplay overs

**100. Who holds the record for the most sixes in international cricket across all formats?**
- A. Shahid Afridi
- B. Chris Gayle
- C. Rohit Sharma  ✅
- D. MS Dhoni

**101. Which bowler dismissed Don Bradman for a duck in his final Test innings, denying him a career average of 100?**
- A. Alec Bedser
- B. Eric Hollies  ✅
- C. Doug Wright
- D. Jim Laker

**102. What is the term for an over in which a bowler concedes 36 runs (six sixes), first done in first-class cricket by Garfield Sobers off Malcolm Nash?**
- A. Perfect over
- B. Six sixes in an over  ✅
- C. Maximum over
- D. Sobers over

---

## Bollywood (102 questions)

### Easy (34)

**1. Which actor is popularly called the 'King of Bollywood'?**
- A. Salman Khan
- B. Shah Rukh Khan  ✅
- C. Aamir Khan
- D. Hrithik Roshan

**2. 'Mogambo khush hua' is an iconic villain line from which film?**
- A. Sholay
- B. Don
- C. Mr. India  ✅
- D. Deewaar

**3. Which 1975 film features the dacoit villain Gabbar Singh?**
- A. Sholay  ✅
- B. Zanjeer
- C. Karan Arjun
- D. Baazigar

**4. Which Bollywood actor is nicknamed 'Mr. Perfectionist'?**
- A. Salman Khan
- B. Aamir Khan  ✅
- C. Akshay Kumar
- D. Ajay Devgn

**5. Hindi cinema is centred in which Indian city?**
- A. Delhi
- B. Chennai
- C. Mumbai  ✅
- D. Kolkata

**6. Which actress starred opposite Shah Rukh Khan in 'Dilwale Dulhania Le Jayenge'?**
- A. Madhuri Dixit
- B. Kajol  ✅
- C. Juhi Chawla
- D. Karisma Kapoor

**7. The classic film 'Mughal-e-Azam' is set in the court of which emperor?**
- A. Babur
- B. Akbar  ✅
- C. Shah Jahan
- D. Aurangzeb

**8. Which dance form is most associated with Bollywood song-and-dance numbers?**
- A. Ballet
- B. Filmi/Bollywood dance  ✅
- C. Flamenco
- D. Tap

**9. 'Kuch Kuch Hota Hai' starred Shah Rukh Khan, Kajol and which other actress?**
- A. Rani Mukerji  ✅
- B. Preity Zinta
- C. Aishwarya Rai
- D. Kareena Kapoor

**10. Which actor is known as the 'Bhaijaan' of Bollywood and led the 'Dabangg' films?**
- A. Aamir Khan
- B. Salman Khan  ✅
- C. Saif Ali Khan
- D. Shah Rukh Khan

**11. Which veteran actor is famously called the 'Shahenshah' of Bollywood?**
- A. Dilip Kumar
- B. Amitabh Bachchan  ✅
- C. Dharmendra
- D. Rajesh Khanna

**12. 'Lagaan' revolves around villagers playing which sport against the British?**
- A. Hockey
- B. Football
- C. Cricket  ✅
- D. Polo

**13. Which colour festival is celebrated in countless Bollywood songs, including 'Rang Barse'?**
- A. Diwali
- B. Holi  ✅
- C. Eid
- D. Onam

**14. Which actress is often called the 'Dhak Dhak girl' of Bollywood?**
- A. Sridevi
- B. Madhuri Dixit  ✅
- C. Juhi Chawla
- D. Raveena Tandon

**15. The phrase 'Picture abhi baaki hai mere dost' is associated with which film?**
- A. Don
- B. Om Shanti Om  ✅
- C. Dabangg
- D. Krrish

**16. Which superstar of the 1970s was known as the original 'Angry Young Man'?**
- A. Rajesh Khanna
- B. Amitabh Bachchan  ✅
- C. Vinod Khanna
- D. Shashi Kapoor

**17. Which film studio family is often called the 'first family' of Bollywood?**
- A. The Khans
- B. The Kapoors  ✅
- C. The Roshans
- D. The Deols

**18. Which actress won hearts as 'Geet' in the film 'Jab We Met'?**
- A. Kareena Kapoor  ✅
- B. Katrina Kaif
- C. Deepika Padukone
- D. Anushka Sharma

**19. Which Khan is known for both acting and the reality/quiz show hosting style — wait, which Khan hosted 'Bigg Boss' for many seasons?**
- A. Aamir Khan
- B. Salman Khan  ✅
- C. Shah Rukh Khan
- D. Saif Ali Khan

**20. 'Chaiyya Chaiyya' is a famous song filmed on top of a moving what?**
- A. Bus
- B. Train  ✅
- C. Boat
- D. Plane

**21. Which actor is nicknamed the 'Greek God' of Bollywood for his looks?**
- A. Hrithik Roshan  ✅
- B. John Abraham
- C. Ranbir Kapoor
- D. Shahid Kapoor

**22. Which 2001 family drama is fondly abbreviated as 'K3G'?**
- A. Kal Ho Naa Ho
- B. Kabhi Khushi Kabhie Gham  ✅
- C. Kuch Kuch Hota Hai
- D. Kabhi Alvida Naa Kehna

**23. Which actress made her debut in 'Student of the Year' alongside Varun Dhawan and Sidharth Malhotra?**
- A. Shraddha Kapoor
- B. Alia Bhatt  ✅
- C. Parineeti Chopra
- D. Kriti Sanon

**24. Which playback singer is known as the 'Nightingale of India'?**
- A. Asha Bhosle
- B. Lata Mangeshkar  ✅
- C. Shreya Ghoshal
- D. Alka Yagnik

**25. 'Sholay' features two friends named Jai and what?**
- A. Veeru  ✅
- B. Vijay
- C. Raju
- D. Anand

**26. Which actor played the title role in the superhero film 'Krrish'?**
- A. Shah Rukh Khan
- B. Hrithik Roshan  ✅
- C. Tiger Shroff
- D. Ranveer Singh

**27. Which Bollywood couple are famously known for the on-screen pairing in 'Hum Aapke Hain Koun..!'?**
- A. Salman Khan and Madhuri Dixit  ✅
- B. Aamir Khan and Juhi Chawla
- C. Shah Rukh Khan and Kajol
- D. Govinda and Karisma

**28. Which actor is associated with the comedic 'Hera Pheri' character Raju?**
- A. Paresh Rawal
- B. Akshay Kumar  ✅
- C. Sunil Shetty
- D. Johnny Lever

**29. Which festival of lights features in many Bollywood films with fireworks and diyas?**
- A. Holi
- B. Diwali  ✅
- C. Navratri
- D. Pongal

**30. Which actress is known as 'Bebo' and starred in 'Jab We Met'?**
- A. Kareena Kapoor  ✅
- B. Karisma Kapoor
- C. Bipasha Basu
- D. Rani Mukerji

**31. Which 1990s romance made the pair Shah Rukh Khan and Kajol household names with the song 'Tujhe Dekha To'?**
- A. Dil To Pagal Hai
- B. Dilwale Dulhania Le Jayenge  ✅
- C. Karan Arjun
- D. Baazigar

**32. Which composer-duo and singer revolutionised Bollywood music in the 1990s with 'Tum To Thehre Pardesi'? Which music director won Oscars for 'Slumdog Millionaire'?**
- A. Pritam
- B. A. R. Rahman  ✅
- C. Anu Malik
- D. Shankar–Ehsaan–Loy

**33. Which actor leads the 'Singham' cop franchise?**
- A. Akshay Kumar
- B. Ajay Devgn  ✅
- C. Ranveer Singh
- D. Salman Khan

**34. Which item-dance number from 'Tees Maar Khan' features Katrina Kaif and is titled 'Sheila Ki ...'?**
- A. Jawani  ✅
- B. Adaa
- C. Chunari
- D. Nazaqat


### Medium (34)

**35. Which film won India's first Academy Award nomination for Best Foreign Language Film in 1957?**
- A. Do Bigha Zamin
- B. Mother India  ✅
- C. Awaara
- D. Pyaasa

**36. Who directed the acclaimed 'Apu Trilogy' (though Bengali cinema), a towering figure of Indian film?**
- A. Bimal Roy
- B. Satyajit Ray  ✅
- C. Guru Dutt
- D. Hrishikesh Mukherjee

**37. Which 2009 film, set in an engineering college, popularised the phrase 'All is well'?**
- A. Munna Bhai MBBS
- B. 3 Idiots  ✅
- C. Taare Zameen Par
- D. PK

**38. Which actor played the autistic NRI lead in the film 'My Name Is Khan'?**
- A. Aamir Khan
- B. Shah Rukh Khan  ✅
- C. Hrithik Roshan
- D. Ranbir Kapoor

**39. Which director is known for grand romances and films like 'Devdas' (2002) and 'Bajirao Mastani'?**
- A. Karan Johar
- B. Sanjay Leela Bhansali  ✅
- C. Yash Chopra
- D. Rajkumar Hirani

**40. Which actress won the Miss World 1994 title before becoming a Bollywood star?**
- A. Sushmita Sen
- B. Aishwarya Rai  ✅
- C. Priyanka Chopra
- D. Lara Dutta

**41. Which 1998 film about friendship gave us the song 'Koi Mil Gaya' (the romantic one) and launched Rani Mukerji into stardom alongside SRK and Kajol?**
- A. Kabhi Khushi Kabhie Gham
- B. Kuch Kuch Hota Hai  ✅
- C. Mohabbatein
- D. Dil To Pagal Hai

**42. The film 'Gangs of Wasseypur' was directed by which acclaimed filmmaker?**
- A. Anurag Kashyap  ✅
- B. Vishal Bhardwaj
- C. Dibakar Banerjee
- D. Imtiaz Ali

**43. Which actor delivered the iconic 'Don' dialogue and reprised the role in the 2006 remake?**
- A. Amitabh Bachchan
- B. Shah Rukh Khan
- C. Both played Don in different versions  ✅
- D. Sanjay Dutt

**44. Which biographical film starred Farhan Akhtar as athlete Milkha Singh?**
- A. Mary Kom
- B. Bhaag Milkha Bhaag  ✅
- C. Dangal
- D. M.S. Dhoni

**45. Which 2016 sports film featured Aamir Khan as a wrestler-father training his daughters?**
- A. Sultan
- B. Dangal  ✅
- C. Mary Kom
- D. Chak De! India

**46. Which veteran music director composed for 'Sholay', part of a famous duo?**
- A. Laxmikant–Pyarelal
- B. R. D. Burman  ✅
- C. Kalyanji–Anandji
- D. Shankar–Jaikishan

**47. Which actress is known as the 'first female superstar' of Bollywood and starred in 'Chaalbaaz' and 'Mr. India'?**
- A. Madhuri Dixit
- B. Sridevi  ✅
- C. Hema Malini
- D. Rekha

**48. Which 2014 satire by Rajkumar Hirani starred Aamir Khan as an alien questioning religion?**
- A. 3 Idiots
- B. PK  ✅
- C. Munna Bhai
- D. Lagaan

**49. Which director helmed 'Dilwale Dulhania Le Jayenge', his debut film?**
- A. Yash Chopra
- B. Aditya Chopra  ✅
- C. Karan Johar
- D. Sooraj Barjatya

**50. Which actor and former 'chocolate boy' starred in 'Rockstar' and 'Barfi!'?**
- A. Ranveer Singh
- B. Ranbir Kapoor  ✅
- C. Shahid Kapoor
- D. Imran Khan

**51. Which 2001 period drama directed by Ashutosh Gowariker earned an Oscar nomination?**
- A. Devdas
- B. Lagaan  ✅
- C. Swades
- D. Jodhaa Akbar

**52. Which playback singer, daughter of a famous family, sang 'Agar Tum Saath Ho' and rose in the 2000s?**
- A. Sunidhi Chauhan
- B. Shreya Ghoshal  ✅
- C. Alka Yagnik
- D. Kavita Krishnamurthy

**53. Which film features the character 'Munna Bhai' practising 'Gandhigiri'?**
- A. Munna Bhai MBBS
- B. Lage Raho Munna Bhai  ✅
- C. 3 Idiots
- D. PK

**54. Which actress made a powerful debut in 'Masaan' (2015) and went on to 'Stree' and 'Bareilly Ki Barfi'?**
- A. Bhumi Pednekar  ✅
- B. Shraddha Kapoor
- C. Kriti Sanon
- D. Yami Gautam

**55. Which 1957 Guru Dutt film about a struggling poet is considered a classic of Indian cinema?**
- A. Kaagaz Ke Phool
- B. Pyaasa  ✅
- C. Sahib Bibi Aur Ghulam
- D. Mr. & Mrs. 55

**56. Which actor known for intense roles starred in 'Gangs of Wasseypur' and the show 'Sacred Games'?**
- A. Pankaj Tripathi
- B. Nawazuddin Siddiqui  ✅
- C. Manoj Bajpayee
- D. Irrfan Khan

**57. Which late actor was acclaimed for 'The Lunchbox', 'Paan Singh Tomar' and Hollywood films?**
- A. Om Puri
- B. Irrfan Khan  ✅
- C. Naseeruddin Shah
- D. Kay Kay Menon

**58. Which 2018 horror-comedy set in Chanderi starred Rajkummar Rao and Shraddha Kapoor?**
- A. Bhool Bhulaiyaa
- B. Stree  ✅
- C. Go Goa Gone
- D. Roohi

**59. Which director is known for the 'Munna Bhai' and 'Dhamaal'... actually who directed '3 Idiots', 'PK' and 'Sanju'?**
- A. Anurag Kashyap
- B. Rajkumar Hirani  ✅
- C. Imtiaz Ali
- D. Zoya Akhtar

**60. Which actress won a National Film Award for 'Tabu'-led... — which actress is acclaimed for 'Maqbool', 'Haider' and 'Andhadhun'?**
- A. Tabu  ✅
- B. Konkona Sen Sharma
- C. Vidya Balan
- D. Kangana Ranaut

**61. Which 2012 film by Sujoy Ghosh starred Vidya Balan as a pregnant woman searching Kolkata for her husband?**
- A. Kahaani  ✅
- B. No One Killed Jessica
- C. The Dirty Picture
- D. Ishqiya

**62. Which composer trio scored 'Dil Chahta Hai' and 'Kal Ho Naa Ho'?**
- A. Vishal–Shekhar
- B. Shankar–Ehsaan–Loy  ✅
- C. Salim–Sulaiman
- D. Sajid–Wajid

**63. Which 2001 coming-of-age film by Farhan Akhtar about three friends is a cult favourite?**
- A. Zindagi Na Milegi Dobara
- B. Dil Chahta Hai  ✅
- C. Rock On!!
- D. Wake Up Sid

**64. Which actress, a former Miss India, broke out with 'Aitraaz' and 'Fashion' and later went global?**
- A. Lara Dutta
- B. Priyanka Chopra  ✅
- C. Bipasha Basu
- D. Celina Jaitly

**65. Which film popularised the dialogue 'Kitne aadmi the?' spoken by Gabbar Singh?**
- A. Deewaar
- B. Sholay  ✅
- C. Zanjeer
- D. Don

**66. Which director's 'Black' (2005) starred Amitabh Bachchan and Rani Mukerji as a teacher and a deaf-blind student?**
- A. Karan Johar
- B. Sanjay Leela Bhansali  ✅
- C. Mani Ratnam
- D. Yash Chopra

**67. Which 2019 Zoya Akhtar film about a Mumbai street rapper starred Ranveer Singh and Alia Bhatt?**
- A. Gully Boy  ✅
- B. Udta Punjab
- C. Sonchiriya
- D. Mukkabaaz

**68. Which actress delivered acclaimed performances in 'The Dirty Picture' and 'Kahaani', winning a National Award?**
- A. Kangana Ranaut
- B. Vidya Balan  ✅
- C. Rani Mukerji
- D. Tabu


### Hard (34)

**69. Which 1913 film by Dadasaheb Phalke is regarded as India's first full-length feature film?**
- A. Alam Ara
- B. Raja Harishchandra  ✅
- C. Pundalik
- D. Shree Pundalik

**70. 'Alam Ara' (1931) holds what distinction in Indian cinema?**
- A. First colour film
- B. First talkie (sound film)  ✅
- C. First 70mm film
- D. First animated film

**71. Which director made the 1957 classic 'Mother India', earning an Oscar nomination?**
- A. Bimal Roy
- B. Mehboob Khan  ✅
- C. Raj Kapoor
- D. K. Asif

**72. Which filmmaker spent over a decade making 'Mughal-e-Azam' (1960)?**
- A. Bimal Roy
- B. K. Asif  ✅
- C. Guru Dutt
- D. Mehboob Khan

**73. Which composer, known as 'Pancham', scored 'Hare Rama Hare Krishna' and 'Sholay'?**
- A. Madan Mohan
- B. R. D. Burman  ✅
- C. Naushad
- D. S. D. Burman

**74. Which actress made her debut as a child and became a leading star known as the 'tragedy queen' of the 1950s–60s?**
- A. Nargis
- B. Meena Kumari  ✅
- C. Madhubala
- D. Waheeda Rehman

**75. Who composed the music for 'Mughal-e-Azam', including 'Pyar Kiya To Darna Kya'?**
- A. Naushad  ✅
- B. Shankar–Jaikishan
- C. C. Ramchandra
- D. Roshan

**76. Which 1975 film, alongside 'Sholay', helped define Amitabh Bachchan's 'angry young man' and was written by Salim–Javed?**
- A. Deewaar  ✅
- B. Trishul
- C. Zanjeer
- D. Kala Patthar

**77. Which director's 'Garm Hava' (1973) is a landmark film about Partition's effect on a Muslim family?**
- A. M. S. Sathyu  ✅
- B. Shyam Benegal
- C. Govind Nihalani
- D. Mrinal Sen

**78. Which actor-director made 'Awaara' and 'Shree 420', wearing a Chaplinesque tramp persona?**
- A. Dev Anand
- B. Raj Kapoor  ✅
- C. Dilip Kumar
- D. Guru Dutt

**79. Which parallel-cinema filmmaker directed 'Ankur' (1974), launching Shabana Azmi?**
- A. Shyam Benegal  ✅
- B. Satyajit Ray
- C. Mani Kaul
- D. Kumar Shahani

**80. Which singer recorded the song 'Aage Bhi Jaane Na Tu' from 'Waqt' (1965)?**
- A. Lata Mangeshkar
- B. Asha Bhosle  ✅
- C. Geeta Dutt
- D. Suman Kalyanpur

**81. Which 1957 Guru Dutt-produced film, a box-office failure on release, is now considered a masterpiece about a film director's decline?**
- A. Pyaasa
- B. Kaagaz Ke Phool  ✅
- C. Chaudhvin Ka Chand
- D. Sahib Bibi Aur Ghulam

**82. Which lyricist, also a poet, penned 'Waqt Ne Kiya Kya Haseen Sitam' and won acclaim for 'Pyaasa'?**
- A. Sahir Ludhianvi
- B. Shailendra
- C. Majrooh Sultanpuri  ✅
- D. Kaifi Azmi

**83. Which actress's only film as a leading lady opposite Raj Kapoor created the iconic 'Awaara' imagery, and she later became a Rajya Sabha member?**
- A. Madhubala
- B. Nargis  ✅
- C. Nimmi
- D. Vyjayanthimala

**84. Which director made the experimental 'Uski Roti' (1969), a key film of the Indian New Wave?**
- A. Mani Kaul  ✅
- B. Kumar Shahani
- C. Mrinal Sen
- D. Adoor Gopalakrishnan

**85. Which 1983 film by Kundan Shah is a cult black comedy starring Naseeruddin Shah and Ravi Baswani?**
- A. Jaane Bhi Do Yaaro  ✅
- B. Mandi
- C. Albert Pinto Ko Gussa Kyon Aata Hai
- D. Bhumika

**86. Which composer introduced A. R. Rahman to Hindi cinema via the dubbed 'Roja' (1992 originally Tamil)?**
- A. Ilaiyaraaja
- B. A. R. Rahman himself  ✅
- C. Bappi Lahiri
- D. Anu Malik

**87. Which actor's debut film was 'Deewana' (1992) before he became the 'King of Bollywood'?**
- A. Salman Khan
- B. Shah Rukh Khan  ✅
- C. Aamir Khan
- D. Akshay Kumar

**88. Which 1994 Sooraj Barjatya film became one of the highest-grossing Indian films of its time?**
- A. Maine Pyar Kiya
- B. Hum Aapke Hain Koun..!  ✅
- C. Hum Saath-Saath Hain
- D. Vivah

**89. Which director's 'Bombay' (1995) and 'Roja' formed part of a 'terrorism trilogy'?**
- A. Mani Ratnam  ✅
- B. Ram Gopal Varma
- C. Priyadarshan
- D. J. P. Dutta

**90. Which 1998 Ram Gopal Varma film is regarded as a landmark of the Mumbai-underworld genre?**
- A. Company
- B. Satya  ✅
- C. Sarkar
- D. D

**91. Which lyricist won an Academy Award (with A. R. Rahman) for the song 'Jai Ho' from 'Slumdog Millionaire'?**
- A. Javed Akhtar
- B. Gulzar  ✅
- C. Prasoon Joshi
- D. Irshad Kamil

**92. Which actress won the National Film Award for Best Actress for 'Tabu'... — which actress won it for both 'Maachis' and later 'Chandni Bar'?**
- A. Tabu  ✅
- B. Shabana Azmi
- C. Smita Patil
- D. Nandita Das

**93. Which director made 'Maqbool' (2003) and 'Omkara' (2006), adapting Shakespeare into Indian settings?**
- A. Vishal Bhardwaj  ✅
- B. Anurag Kashyap
- C. Sudhir Mishra
- D. Tigmanshu Dhulia

**94. Which 1981 Muzaffar Ali film starring Rekha as a courtesan is a celebrated period drama?**
- A. Pakeezah
- B. Umrao Jaan  ✅
- C. Mughal-e-Azam
- D. Mere Mehboob

**95. Which actress starred in the 1972 classic 'Pakeezah', which took 14 years to complete?**
- A. Madhubala
- B. Meena Kumari  ✅
- C. Waheeda Rehman
- D. Nutan

**96. Which filmmaker is regarded as the pioneer of the 'middle cinema' with gentle comedies like 'Gol Maal' and 'Chupke Chupke'?**
- A. Basu Chatterjee
- B. Hrishikesh Mukherjee  ✅
- C. Gulzar
- D. Sai Paranjpye

**97. Which 1970 film cemented Rajesh Khanna's superstardom with the song 'Mere Sapno Ki Rani'?**
- A. Anand
- B. Aradhana  ✅
- C. Kati Patang
- D. Amar Prem

**98. Which director's 'Salaam Bombay!' (1988) was nominated for an Academy Award?**
- A. Mira Nair  ✅
- B. Deepa Mehta
- C. Aparna Sen
- D. Kalpana Lajmi

**99. Which playback singer, known for ghazals, also acted and sang 'Chingari Koi Bhadke' for 'Amar Prem'?**
- A. Mohammed Rafi
- B. Kishore Kumar  ✅
- C. Mukesh
- D. Manna Dey

**100. Which 2007 Anurag Kashyap film was initially banned and dealt with the aftermath of riots and a serial-killer subplot?**
- A. Black Friday
- B. No Smoking  ✅
- C. Gulaal
- D. Dev.D

**101. Which choreographer-turned-director is credited with iconic dance numbers and films like 'Tezaab's' 'Ek Do Teen'?**
- A. Saroj Khan  ✅
- B. Farah Khan
- C. Remo D'Souza
- D. Prabhu Deva

**102. Which 1953 Bimal Roy film about a poor farmer is considered an early masterpiece of Indian neorealism?**
- A. Do Bigha Zamin  ✅
- B. Devdas
- C. Madhumati
- D. Sujata

---

## Tech (102 questions)

### Easy (34)

**1. What does 'WWW' stand for?**
- A. World Wide Web  ✅
- B. Wide Wireless Web
- C. World Wireless Web
- D. Web Wide World

**2. Which company makes the iPhone?**
- A. Samsung
- B. Google
- C. Apple  ✅
- D. Microsoft

**3. What does 'CPU' stand for?**
- A. Central Processing Unit  ✅
- B. Core Power Unit
- C. Computer Processing Unit
- D. Central Power Unit

**4. What language do browsers read to display web pages?**
- A. Python
- B. HTML  ✅
- C. Java
- D. C++

**5. Which company owns the Android operating system?**
- A. Apple
- B. Microsoft
- C. Google  ✅
- D. Samsung

**6. What does 'USB' stand for?**
- A. Universal Serial Bus  ✅
- B. United System Board
- C. Universal Signal Bridge
- D. Unified Serial Byte

**7. Which social network uses a blue bird as its historic symbol?**
- A. Facebook
- B. Instagram
- C. Twitter/X  ✅
- D. Snapchat

**8. What does 'RAM' stand for?**
- A. Random Access Memory  ✅
- B. Read And Modify
- C. Rapid Access Module
- D. Read Access Memory

**9. How many bits are in one byte?**
- A. 4
- B. 8  ✅
- C. 16
- D. 32

**10. Which company makes the Windows operating system?**
- A. Apple
- B. Google
- C. IBM
- D. Microsoft  ✅

**11. What does 'AI' stand for in technology?**
- A. Automatic Interface
- B. Artificial Intelligence  ✅
- C. Advanced Integration
- D. Algorithmic Input

**12. What is the name of Apple's voice assistant?**
- A. Alexa
- B. Google
- C. Cortana
- D. Siri  ✅

**13. What does 'URL' stand for?**
- A. Uniform Resource Locator  ✅
- B. Universal Resource Link
- C. Unique Reference Locator
- D. Unified Resource Layer

**14. Which company developed the search engine Google?**
- A. Microsoft
- B. Yahoo
- C. Larry Page and Sergey Brin  ✅
- D. IBM

**15. What does 'Wi-Fi' primarily allow devices to do?**
- A. Charge wirelessly
- B. Connect to the internet without cables  ✅
- C. Print documents remotely
- D. Store files in the cloud

**16. What is the term for malicious software designed to damage or disrupt a computer?**
- A. Firmware
- B. Malware  ✅
- C. Freeware
- D. Spyware

**17. Which company makes the Galaxy smartphone series?**
- A. Apple
- B. OnePlus
- C. Huawei
- D. Samsung  ✅

**18. What does 'GPS' stand for?**
- A. General Positioning System
- B. Global Positioning System  ✅
- C. Geo-Precision Satellite
- D. Ground Proximity Sensor

**19. Which social platform is owned by Meta and focuses on photo sharing?**
- A. TikTok
- B. Pinterest
- C. Instagram  ✅
- D. Snapchat

**20. What is the shortcut key to copy selected text on most computers?**
- A. Ctrl+X
- B. Ctrl+V
- C. Ctrl+C  ✅
- D. Ctrl+Z

**21. What do you call a program that lets you browse the internet?**
- A. Compiler
- B. Browser  ✅
- C. Server
- D. Router

**22. What does 'PDF' stand for?**
- A. Portable Document Format  ✅
- B. Printed Data File
- C. Public Display Format
- D. Page Definition File

**23. Which device converts digital signals to analogue for an internet connection?**
- A. Router
- B. Switch
- C. Modem  ✅
- D. Hub

**24. What is the cloud in 'cloud computing'?**
- A. A weather app
- B. Remote servers accessed via the internet  ✅
- C. A type of RAM
- D. Wireless Bluetooth storage

**25. Which key on a keyboard deletes text to the left of the cursor?**
- A. Delete
- B. Backspace  ✅
- C. Escape
- D. Shift

**26. What does 'HD' stand for in video resolution?**
- A. High Definition  ✅
- B. Hard Drive
- C. High Density
- D. Hyper Display

**27. Which language is most associated with building websites' visual style (colours, fonts)?**
- A. JavaScript
- B. PHP
- C. CSS  ✅
- D. SQL

**28. What does an operating system do?**
- A. Designs hardware circuits
- B. Manages hardware and software resources  ✅
- C. Connects to the internet
- D. Runs only apps

**29. What is the name of Amazon's smart speaker assistant?**
- A. Siri
- B. Cortana
- C. Alexa  ✅
- D. Bixby

**30. Which company makes the PlayStation gaming console?**
- A. Microsoft
- B. Nintendo
- C. Sony  ✅
- D. Sega

**31. What does 'SSD' stand for?**
- A. Super Speed Drive
- B. Solid State Drive  ✅
- C. System Storage Device
- D. Static Storage Disk

**32. Which programming language is named after a type of coffee?**
- A. Python
- B. Ruby
- C. Java  ✅
- D. Swift

**33. What colour is the Twitter/X bird logo historically associated with?**
- A. Red
- B. Green
- C. Blue  ✅
- D. Black

**34. What does 'VPN' stand for?**
- A. Virtual Private Network  ✅
- B. Verified Protocol Node
- C. Visual Processing Network
- D. Variable Port Node


### Medium (34)

**35. Who co-founded Apple with Steve Jobs and Ronald Wayne?**
- A. Bill Gates
- B. Steve Wozniak  ✅
- C. Jony Ive
- D. Tim Cook

**36. Which programming language is most commonly used for data science and machine learning?**
- A. Java
- B. C++
- C. Python  ✅
- D. Go

**37. What does 'HTTP' stand for?**
- A. HyperText Transfer Protocol  ✅
- B. High Traffic Transfer Process
- C. Host Transfer Text Protocol
- D. Hyperlink Transport Technology

**38. What is the binary number system's base?**
- A. 8
- B. 10
- C. 16
- D. 2  ✅

**39. Which company created the Java programming language?**
- A. Microsoft
- B. IBM
- C. Sun Microsystems  ✅
- D. Apple

**40. What does 'API' stand for in software development?**
- A. Application Programming Interface  ✅
- B. Automated Process Integration
- C. Advanced Protocol Index
- D. Application Protocol Input

**41. What is 'open source' software?**
- A. Software that is free to use commercially only
- B. Software whose source code is publicly available and modifiable  ✅
- C. Software developed by governments
- D. Software without a user interface

**42. What is the purpose of a firewall in a computer network?**
- A. Speed up internet connection
- B. Monitor and control incoming/outgoing traffic for security  ✅
- C. Compress files for storage
- D. Boost Wi-Fi signal

**43. Which tech giant runs AWS (Amazon Web Services)?**
- A. Microsoft
- B. Google
- C. Amazon  ✅
- D. IBM

**44. What is 'machine learning'?**
- A. Programming robots to move
- B. Systems that learn from data to improve at tasks without being explicitly programmed  ✅
- C. Manual data entry automation
- D. A type of computer hardware

**45. Which programming language was created by Brendan Eich and runs in browsers?**
- A. TypeScript
- B. Ruby
- C. JavaScript  ✅
- D. Dart

**46. What does SQL stand for?**
- A. System Query Level
- B. Structured Query Language  ✅
- C. Sequential Query Logic
- D. Standard Query Layer

**47. What is a 'commit' in Git version control?**
- A. Deleting a branch
- B. Saving a snapshot of your code changes  ✅
- C. Merging two branches
- D. Publishing code to a server

**48. Which company developed the TypeScript language as a superset of JavaScript?**
- A. Google
- B. Facebook
- C. Microsoft  ✅
- D. JetBrains

**49. What is Moore's Law?**
- A. Internet speed doubles every year
- B. The number of transistors on a chip roughly doubles every two years  ✅
- C. Storage costs halve every 18 months
- D. Software complexity triples each decade

**50. What does 'DNS' stand for?**
- A. Dynamic Network Service
- B. Domain Name System  ✅
- C. Data Node Switch
- D. Direct Navigation Server

**51. What is 'containerisation' in software (e.g. Docker)?**
- A. Encrypting files for transport
- B. Packaging an app and its dependencies into an isolated unit  ✅
- C. Building mobile apps
- D. Compressing video streams

**52. Who founded Tesla and also runs SpaceX?**
- A. Jeff Bezos
- B. Larry Page
- C. Elon Musk  ✅
- D. Sundar Pichai

**53. What does 'blockchain' technology primarily provide?**
- A. Faster internet connections
- B. A distributed, tamper-resistant ledger of transactions  ✅
- C. A type of virus protection
- D. Wireless mesh networking

**54. Which search algorithm visits the nearest nodes first by distance?**
- A. Depth-First Search
- B. Dijkstra's Algorithm  ✅
- C. Binary Search
- D. Bubble Sort

**55. What is 'latency' in networking?**
- A. Bandwidth in megabits per second
- B. Time delay for data to travel from source to destination  ✅
- C. Number of connected devices
- D. Packet size in bytes

**56. What does an IDE (Integrated Development Environment) provide?**
- A. Internet access only
- B. A suite of tools for writing, testing and debugging code  ✅
- C. Only a code text editor
- D. Hardware-level system access

**57. What is the purpose of a CDN (Content Delivery Network)?**
- A. Store passwords securely
- B. Deliver content from servers geographically close to users  ✅
- C. Encrypt emails
- D. Run serverless functions

**58. Which company created the Kotlin programming language?**
- A. Google
- B. JetBrains  ✅
- C. Oracle
- D. Apple

**59. What is 'two-factor authentication'?**
- A. Using two passwords
- B. A second verification step beyond a password, such as a code sent to your phone  ✅
- C. Logging in from two devices
- D. Double-encrypting your data

**60. What data structure operates on a 'last in, first out' principle?**
- A. Queue
- B. Stack  ✅
- C. Linked list
- D. Tree

**61. What does 'IPv6' improve over IPv4?**
- A. Faster Wi-Fi speeds
- B. A vastly larger address space for internet-connected devices  ✅
- C. Better video compression
- D. Lower battery consumption

**62. Which company created the Swift programming language for iOS development?**
- A. Google
- B. Microsoft
- C. Facebook
- D. Apple  ✅

**63. What is 'phishing'?**
- A. A malware type that encrypts files
- B. A cyberattack that tricks users into revealing credentials via fake communications  ✅
- C. Overloading a server with traffic
- D. Exploiting a zero-day vulnerability

**64. What does 'REST' stand for in web APIs?**
- A. Rapid Endpoint Server Technology
- B. Representational State Transfer  ✅
- C. Remote Execution Service Tool
- D. Relational Entity Schema Transfer

**65. What is the purpose of hashing in security?**
- A. Speeding up file transfer
- B. Converting data into a fixed-length value to verify integrity or store passwords safely  ✅
- C. Encrypting communications end-to-end
- D. Compressing images

**66. What does 'OAuth' primarily handle?**
- A. Database queries
- B. Secure authorisation for third-party application access  ✅
- C. Domain name registration
- D. SSL certificate management

**67. What is a 'race condition' in programming?**
- A. A speed benchmark between frameworks
- B. A bug where system behaviour depends on unpredictable timing of concurrent operations  ✅
- C. A performance bottleneck in a loop
- D. A deadlock in database transactions

**68. Which sorting algorithm has an average time complexity of O(n log n)?**
- A. Bubble sort
- B. Insertion sort
- C. Merge sort  ✅
- D. Selection sort


### Hard (34)

**69. What does 'ACID' stand for in database transactions?**
- A. Atomicity, Consistency, Isolation, Durability  ✅
- B. Access, Control, Integrity, Data
- C. Atomic, Complete, Indexed, Distributed
- D. Authorised, Consistent, Isolated, Durable

**70. Which scientist is credited with proposing the concept of the 'stored-program computer'?**
- A. Alan Turing
- B. John von Neumann  ✅
- C. Claude Shannon
- D. Alonzo Church

**71. What is a Turing machine?**
- A. An early mechanical calculator
- B. A theoretical model of computation that defines the limits of what can be computed  ✅
- C. An AI training framework
- D. A quantum computing architecture

**72. What does the CAP theorem state about distributed systems?**
- A. You can optimise for CPU, Availability and Performance simultaneously
- B. A system can guarantee only two of: Consistency, Availability, Partition tolerance  ✅
- C. All distributed systems must be eventually consistent
- D. Cache, Application and Persistence must be decoupled

**73. What is 'memoisation' in computer science?**
- A. Logging all function calls
- B. Caching results of expensive function calls to avoid recomputation  ✅
- C. Memory allocation at compile time
- D. A garbage-collection technique

**74. What is a 'Byzantine fault' in distributed systems?**
- A. A hardware failure caused by power surge
- B. A failure where a node sends conflicting or incorrect information to different parts of the system  ✅
- C. A network partition lasting more than 30 seconds
- D. A clock synchronisation error

**75. What does 'P vs NP' refer to in computer science?**
- A. Performance versus non-performance metrics
- B. Whether every problem whose solution can be quickly verified can also be quickly solved  ✅
- C. Parallel versus non-parallel computing
- D. Public versus private key encryption

**76. Which cryptographic protocol underpins HTTPS security using asymmetric key exchange?**
- A. MD5
- B. AES
- C. TLS/SSL with RSA or ECDH  ✅
- D. SHA-256

**77. What is a 'zero-day vulnerability'?**
- A. A bug introduced in the first version of software
- B. A security flaw that is exploited before the vendor knows about or patches it  ✅
- C. A vulnerability in day-zero bootstrapping code
- D. An exploit that takes less than a day to execute

**78. What is the halting problem?**
- A. Determining if a loop will terminate within a time limit
- B. The undecidable problem of whether a given program will finish or run forever on a given input  ✅
- C. Stopping a runaway process in an OS
- D. A deadlock detection algorithm

**79. In Big-O notation, what does O(1) mean?**
- A. One operation total
- B. Constant time, regardless of input size  ✅
- C. One pass through the data
- D. Linear time

**80. What is 'garbage collection' in programming languages?**
- A. Deleting log files
- B. Automatic memory management that reclaims memory occupied by objects no longer in use  ✅
- C. Compressing unused code
- D. A static analysis technique

**81. Which Nobel-equivalent prize recognised the work behind the internet's packet-switching theory?**
- A. Turing Award
- B. Fields Medal
- C. Draper Prize  ✅
- D. Von Neumann Medal

**82. What does 'kernel' refer to in an operating system?**
- A. The user interface layer
- B. The core component managing hardware resources and system calls  ✅
- C. The application runtime environment
- D. The file system driver

**83. What is a 'buffer overflow' attack?**
- A. Flooding a server with requests
- B. Writing more data to a buffer than it can hold, overwriting adjacent memory to hijack execution  ✅
- C. Intercepting unencrypted network traffic
- D. Brute-forcing a login form

**84. Which algorithm is used in asymmetric encryption and is based on the difficulty of factoring large primes?**
- A. AES
- B. RSA  ✅
- C. SHA-256
- D. Diffie-Hellman

**85. What is 'eventual consistency' in distributed databases?**
- A. All nodes are always consistent
- B. Nodes may temporarily diverge but will converge to the same state given enough time with no new updates  ✅
- C. Data is consistent only at query time
- D. Transactions are rolled back unless all nodes agree

**86. What is the main difference between a process and a thread?**
- A. Threads are faster CPUs; processes are slower
- B. A process has its own memory space; threads within a process share the same memory space  ✅
- C. Processes run in parallel; threads run sequentially
- D. Threads are kernel-level; processes are user-level only

**87. What does 'idempotent' mean for an HTTP method or API?**
- A. The call returns a different result each time
- B. Making the same request multiple times produces the same result as making it once  ✅
- C. The call cannot be retried
- D. The call modifies state on every execution

**88. What is 'tail recursion optimisation'?**
- A. Removing the last function in a call stack
- B. Reusing the current stack frame for a recursive call that is the last operation in a function, preventing stack overflow  ✅
- C. Optimising the deepest loop in a program
- D. Converting recursion to an iterative loop manually

**89. What is the difference between symmetric and asymmetric encryption?**
- A. Symmetric is newer; asymmetric is older
- B. Symmetric uses the same key for encryption and decryption; asymmetric uses a public/private key pair  ✅
- C. Symmetric is hardware-based; asymmetric is software-based
- D. Symmetric encrypts images; asymmetric encrypts text

**90. What is a 'merkle tree' used for in computing?**
- A. Sorting large datasets efficiently
- B. Efficiently verifying the integrity of large data structures, used in blockchains and version control  ✅
- C. Building neural network architectures
- D. Indexing relational databases

**91. What does 'sharding' mean in databases?**
- A. Encrypting database columns
- B. Horizontally partitioning data across multiple database instances  ✅
- C. Compressing indexes to save disk space
- D. Replicating a database synchronously

**92. What is 'register renaming' in modern CPUs?**
- A. Naming CPU registers at boot
- B. A technique to eliminate false dependencies between instructions by dynamically assigning physical registers  ✅
- C. Storing variable names in hardware
- D. Renaming memory addresses for virtual machines

**93. What is the significance of Gödel's incompleteness theorems for computing?**
- A. They prove all algorithms can be optimised
- B. They show any sufficiently powerful formal system contains true statements that cannot be proved within it, influencing computability theory  ✅
- C. They define the upper bound of algorithmic complexity
- D. They prove P≠NP

**94. Which data structure provides O(1) average-case lookup but may degrade due to collisions?**
- A. Binary search tree
- B. Hash table  ✅
- C. Red-black tree
- D. B-tree

**95. What is 'speculative execution' in CPU design?**
- A. Pre-loading RAM modules
- B. The CPU predicts and executes future instructions before knowing if they are needed, to improve throughput  ✅
- C. Executing code in a sandbox before committing changes
- D. Deferring GPU operations until needed

**96. What does the 'thundering herd problem' describe?**
- A. CPU overheating under load
- B. Many processes or threads simultaneously woken up to handle one event, causing resource contention  ✅
- C. A DDoS attack pattern
- D. Cascading failures across microservices

**97. In machine learning, what is 'gradient descent'?**
- A. A neural network architecture
- B. An optimisation algorithm that iteratively adjusts parameters to minimise a loss function  ✅
- C. A data normalisation technique
- D. A method for pruning decision trees

**98. What is the purpose of a 'consensus algorithm' like Raft or Paxos?**
- A. Encrypting communication between nodes
- B. Ensuring distributed nodes agree on a single source of truth even when some nodes fail  ✅
- C. Balancing load across server clusters
- D. Scheduling jobs in a cloud pipeline

**99. What does 'SIMD' stand for and what does it enable?**
- A. Single Instruction, Multiple Data — running one instruction on multiple data points simultaneously  ✅
- B. Sequential Instruction, Memory Dispatch — pipelining memory reads
- C. Shared Interrupt, Multiple Dispatch — parallelising I/O
- D. Symmetric Instruction, Multi-Directional — bidirectional data flow

**100. What is 'branch misprediction' and why does it cost performance?**
- A. An error in if-else logic written by the programmer
- B. When the CPU's branch predictor guesses wrong and must flush the instruction pipeline, wasting cycles  ✅
- C. A compiler error in conditional code
- D. A memory fault caused by unaligned data access

**101. What is the primary purpose of the Linux kernel's scheduler?**
- A. Managing file permissions
- B. Deciding which process or thread runs on each CPU core and for how long  ✅
- C. Routing network packets
- D. Allocating virtual memory pages

**102. Which theorem proves that no lossless compression scheme can compress all possible inputs?**
- A. Shannon's source coding theorem
- B. The pigeonhole principle applied to compression  ✅
- C. Kolmogorov complexity theorem
- D. The data processing inequality

---

## Geography (102 questions)

### Easy (34)

**1. What is the largest continent by area?**
- A. Africa
- B. Asia  ✅
- C. North America
- D. Europe

**2. What is the capital of France?**
- A. Berlin
- B. Madrid
- C. Paris  ✅
- D. Rome

**3. Which is the longest river in the world?**
- A. Amazon
- B. Yangtze
- C. Mississippi
- D. Nile  ✅

**4. What is the smallest country in the world by area?**
- A. Monaco
- B. San Marino
- C. Vatican City  ✅
- D. Liechtenstein

**5. On which continent is the Sahara Desert located?**
- A. Asia
- B. Australia
- C. South America
- D. Africa  ✅

**6. What is the capital of Japan?**
- A. Beijing
- B. Seoul
- C. Tokyo  ✅
- D. Shanghai

**7. Which ocean is the largest?**
- A. Atlantic
- B. Indian
- C. Arctic
- D. Pacific  ✅

**8. What is the capital of Australia?**
- A. Sydney
- B. Melbourne
- C. Canberra  ✅
- D. Brisbane

**9. Which country has the most natural lakes in the world?**
- A. Russia
- B. Canada  ✅
- C. USA
- D. Finland

**10. What is the tallest mountain on Earth?**
- A. K2
- B. Kangchenjunga
- C. Mount Everest  ✅
- D. Lhotse

**11. Which river flows through Egypt and empties into the Mediterranean?**
- A. Congo
- B. Niger
- C. Nile  ✅
- D. Zambezi

**12. What is the capital of Brazil?**
- A. Rio de Janeiro
- B. São Paulo
- C. Brasília  ✅
- D. Salvador

**13. Which country is both a continent and a country?**
- A. New Zealand
- B. Greenland
- C. Australia  ✅
- D. Iceland

**14. How many continents are there on Earth?**
- A. 5
- B. 6
- C. 7  ✅
- D. 8

**15. What is the capital of Canada?**
- A. Toronto
- B. Vancouver
- C. Montreal
- D. Ottawa  ✅

**16. Which is the largest desert in the world (by area, including cold deserts)?**
- A. Sahara
- B. Arabian
- C. Gobi
- D. Antarctic  ✅

**17. Which country has the longest coastline in the world?**
- A. Russia
- B. Canada  ✅
- C. Australia
- D. Norway

**18. What is the capital of India?**
- A. Mumbai
- B. Kolkata
- C. New Delhi  ✅
- D. Chennai

**19. Which ocean lies between Africa and Australia?**
- A. Pacific
- B. Atlantic
- C. Arctic
- D. Indian  ✅

**20. What is the capital of Germany?**
- A. Munich
- B. Hamburg
- C. Frankfurt
- D. Berlin  ✅

**21. Which South American country is home to the Amazon rainforest?**
- A. Colombia
- B. Peru
- C. Venezuela
- D. Brazil  ✅

**22. What is the name of the strait separating Europe from Africa at the western end of the Mediterranean?**
- A. Strait of Hormuz
- B. Strait of Gibraltar  ✅
- C. Bosphorus Strait
- D. Dover Strait

**23. Which country is home to the Great Barrier Reef?**
- A. Indonesia
- B. Philippines
- C. Australia  ✅
- D. Papua New Guinea

**24. What is the capital of the United States?**
- A. New York City
- B. Los Angeles
- C. Chicago
- D. Washington D.C.  ✅

**25. What is the name of the imaginary line that divides Earth into northern and southern hemispheres?**
- A. Tropic of Cancer
- B. Prime Meridian
- C. Equator  ✅
- D. Arctic Circle

**26. Which mountain range separates Europe from Asia?**
- A. Alps
- B. Caucasus
- C. Ural Mountains  ✅
- D. Pyrenees

**27. Which country is home to the Eiffel Tower?**
- A. Italy
- B. Spain
- C. France  ✅
- D. Germany

**28. What is the capital of China?**
- A. Shanghai
- B. Hong Kong
- C. Beijing  ✅
- D. Chengdu

**29. Which is the largest country in the world by land area?**
- A. Canada
- B. USA
- C. China
- D. Russia  ✅

**30. What body of water separates England from continental Europe at its narrowest point?**
- A. North Sea
- B. Irish Sea
- C. English Channel  ✅
- D. Bay of Biscay

**31. What is the capital of South Africa's seat of government (executive)?**
- A. Cape Town
- B. Johannesburg
- C. Pretoria  ✅
- D. Durban

**32. Which continent has the most countries?**
- A. Asia
- B. Europe
- C. Africa  ✅
- D. South America

**33. What is the deepest lake in the world?**
- A. Lake Superior
- B. Lake Baikal  ✅
- C. Caspian Sea
- D. Lake Tanganyika

**34. Which country is known as the Land of the Rising Sun?**
- A. China
- B. South Korea
- C. Japan  ✅
- D. Thailand


### Medium (34)

**35. What is the capital of Pakistan?**
- A. Lahore
- B. Karachi
- C. Islamabad  ✅
- D. Rawalpindi

**36. Which African country has the most pyramids?**
- A. Egypt
- B. Sudan  ✅
- C. Ethiopia
- D. Libya

**37. What is the name of the deepest ocean trench in the world?**
- A. Java Trench
- B. Puerto Rico Trench
- C. Mariana Trench  ✅
- D. Tonga Trench

**38. Which country contains the most time zones?**
- A. Russia
- B. USA
- C. China
- D. France  ✅

**39. What is the longest mountain range in the world?**
- A. Rocky Mountains
- B. Himalayas
- C. Andes  ✅
- D. Alps

**40. Which two countries share the longest land border in the world?**
- A. USA and Mexico
- B. Russia and Kazakhstan
- C. Canada and USA  ✅
- D. China and Russia

**41. What is the capital of Argentina?**
- A. Santiago
- B. Lima
- C. Buenos Aires  ✅
- D. Montevideo

**42. Which sea is the world's saltiest major body of water?**
- A. Red Sea
- B. Dead Sea  ✅
- C. Caspian Sea
- D. Aral Sea

**43. How many countries share a land border with China?**
- A. 10
- B. 14  ✅
- C. 16
- D. 12

**44. What is the capital of Nigeria, Africa's most populous country?**
- A. Lagos
- B. Kano
- C. Abuja  ✅
- D. Ibadan

**45. Through how many countries does the River Danube flow?**
- A. 6
- B. 8
- C. 10  ✅
- D. 12

**46. Which country owns Easter Island (Rapa Nui)?**
- A. Peru
- B. New Zealand
- C. Chile  ✅
- D. Ecuador

**47. What is the name of the narrow isthmus connecting North and South America?**
- A. Suez Isthmus
- B. Panama Isthmus  ✅
- C. Malay Peninsula
- D. Strait of Magellan

**48. Which European country is divided into regions called cantons?**
- A. Germany
- B. Austria
- C. Belgium
- D. Switzerland  ✅

**49. What is the capital of Iran?**
- A. Baghdad
- B. Riyadh
- C. Tehran  ✅
- D. Kabul

**50. Which landlocked country is entirely surrounded by Italy?**
- A. Monaco
- B. Andorra
- C. Vatican City
- D. San Marino  ✅

**51. Which river forms much of the border between the USA and Mexico?**
- A. Colorado River
- B. Rio Grande  ✅
- C. Pecos River
- D. Gila River

**52. What is the most populous city in Africa?**
- A. Cairo
- B. Kinshasa
- C. Lagos  ✅
- D. Johannesburg

**53. Which island is the world's largest by area?**
- A. New Guinea
- B. Borneo
- C. Greenland  ✅
- D. Madagascar

**54. What is the capital of Indonesia?**
- A. Surabaya
- B. Bali
- C. Jakarta  ✅
- D. Bandung

**55. Which country has the most UNESCO World Heritage Sites?**
- A. France
- B. China
- C. Italy  ✅
- D. Spain

**56. What is the name of the volcanic archipelago that includes the Galápagos Islands, belonging to Ecuador?**
- A. Galapagos Islands only  ✅
- B. Canary Islands
- C. Azores
- D. Fernando de Noronha

**57. Which mountain range contains all 14 peaks above 8,000 metres?**
- A. Rockies and Andes
- B. Hindu Kush and Karakoram
- C. Himalayas and Karakoram  ✅
- D. Himalayas and Hindu Kush alone

**58. What is the capital of Turkey?**
- A. Istanbul
- B. Ankara  ✅
- C. Izmir
- D. Bursa

**59. Which country has borders with the most other countries (14)?**
- A. China
- B. Russia  ✅
- C. Brazil
- D. Germany

**60. What is the name of the body of water between Australia and New Zealand?**
- A. Coral Sea
- B. Tasman Sea  ✅
- C. Timor Sea
- D. Bass Strait

**61. Which African country is home to Mount Kilimanjaro?**
- A. Kenya
- B. Uganda
- C. Tanzania  ✅
- D. Ethiopia

**62. What is the capital of South Korea?**
- A. Busan
- B. Incheon
- C. Seoul  ✅
- D. Pyongyang

**63. Which country has the world's largest population?**
- A. India  ✅
- B. China
- C. USA
- D. Indonesia

**64. What is the name of the narrow sea channel separating the islands of North and South Island in New Zealand?**
- A. Bass Strait
- B. Cook Strait  ✅
- C. Foveaux Strait
- D. Hauraki Gulf

**65. Which European micro-state sits on the French Riviera and is famous for its casino?**
- A. Monaco  ✅
- B. Liechtenstein
- C. Andorra
- D. San Marino

**66. What is the name of the plateau that covers much of Tibet and is known as the 'Roof of the World'?**
- A. Deccan Plateau
- B. Tibetan Plateau  ✅
- C. Mongolian Plateau
- D. Iranian Plateau

**67. Which country contains both the highest and lowest points in South America?**
- A. Peru
- B. Chile
- C. Argentina  ✅
- D. Bolivia

**68. Which river is the longest in Asia?**
- A. Ganges
- B. Yangtze  ✅
- C. Mekong
- D. Yellow River


### Hard (34)

**69. What is the capital of Myanmar (Burma)?**
- A. Rangoon/Yangon
- B. Mandalay
- C. Naypyidaw  ✅
- D. Bagan

**70. Which country is home to the Chocolate Hills geological formation?**
- A. Thailand
- B. Philippines  ✅
- C. Indonesia
- D. Malaysia

**71. What is the name of the geographic phenomenon where two ocean currents converge off the coast of Newfoundland, creating thick fog?**
- A. Grand Banks
- B. El Niño convergence
- C. Labrador–Gulf Stream meeting  ✅
- D. North Atlantic gyre

**72. Which country owns the Faroe Islands?**
- A. Norway
- B. Iceland
- C. Denmark  ✅
- D. Sweden

**73. What is the Karman line, relevant to geography and aerospace?**
- A. The boundary between troposphere and stratosphere at 12 km
- B. The internationally recognised boundary of space at 100 km altitude  ✅
- C. The latitude of the polar vortex
- D. The deep ocean threshold at 6,000 m

**74. Which African country is home to the Omo River Valley, one of the oldest sites of human fossils?**
- A. Kenya
- B. Tanzania
- C. Ethiopia  ✅
- D. Sudan

**75. What is the name of the submerged continent largely under New Zealand?**
- A. Kerguelen Plateau
- B. Zealandia  ✅
- C. Sahul Shelf
- D. Melanesian Basin

**76. Which country contains the Rub' al Khali, the world's largest continuous sand desert?**
- A. Libya
- B. Saudi Arabia  ✅
- C. Algeria
- D. Chad

**77. What is the name of the narrow land bridge that once connected Asia and North America, now submerged?**
- A. Doggerland
- B. Beringia  ✅
- C. Sundaland
- D. Laurasia Bridge

**78. Which river has the highest discharge volume, emptying more freshwater into the ocean than any other?**
- A. Nile
- B. Congo
- C. Yangtze
- D. Amazon  ✅

**79. What is 'isostasy' in physical geography?**
- A. The study of ice sheet movement
- B. The equilibrium between Earth's crust and the mantle, where crust 'floats' at a level determined by its density  ✅
- C. The process of soil erosion by water
- D. The mapping of ocean floor topography

**80. Which African Great Lake is the deepest?**
- A. Lake Malawi
- B. Lake Tanganyika  ✅
- C. Lake Victoria
- D. Lake Kivu

**81. What is the name of the geological hotspot responsible for the Hawaiian island chain?**
- A. Pacific Ring of Fire plume
- B. Hawaiian hotspot  ✅
- C. Yellowstone mantle plume
- D. Iceland rift

**82. Which country has the most glaciers outside the polar regions?**
- A. Norway
- B. Iceland
- C. Pakistan  ✅
- D. Chile

**83. What is the name of the divide separating rivers flowing into the Atlantic from those flowing into the Pacific in the Americas?**
- A. The Eastern Divide
- B. The Continental Divide  ✅
- C. The Cordilleran Split
- D. The Watershed Ridge

**84. Which sea is entirely enclosed within Russia?**
- A. Black Sea
- B. Caspian Sea
- C. Sea of Azov  ✅
- D. Aral Sea

**85. What is the geographic term for a narrow strip of land connecting two larger landmasses?**
- A. Peninsula
- B. Isthmus  ✅
- C. Spit
- D. Cape

**86. Which country contains Socotra Island, known for its alien-looking dragon blood trees?**
- A. Oman
- B. Yemen  ✅
- C. Djibouti
- D. Eritrea

**87. What does the 'orographic effect' describe in meteorology and geography?**
- A. The influence of ocean currents on rainfall
- B. Precipitation caused when moist air rises over mountains and cools  ✅
- C. Wind patterns around deserts
- D. Temperature inversion in valleys

**88. Which country's coastline includes the Skeleton Coast, named for its shipwrecks and bleached whale bones?**
- A. Angola
- B. Namibia  ✅
- C. South Africa
- D. Mozambique

**89. What is the name of the permanently frozen layer of soil found beneath the active layer in Arctic regions?**
- A. Cryosphere
- B. Permafrost  ✅
- C. Tundra substrate
- D. Frost wedge

**90. Which island chain sits at the boundary of the Pacific and North American tectonic plates, stretching from Alaska toward Russia?**
- A. Hawaiian Islands
- B. Aleutian Islands  ✅
- C. Kuril Islands
- D. Thousand Islands

**91. What is the name of the lowest exposed point on Earth's dry land?**
- A. Death Valley
- B. Mariana Trench coast
- C. Dead Sea shore  ✅
- D. Afar Depression

**92. Which country contains the world's largest river delta, the Ganges–Brahmaputra delta?**
- A. India
- B. Bangladesh
- C. Myanmar
- D. Both India and Bangladesh  ✅

**93. What is the 'Wallace Line'?**
- A. A longitude marking the International Date Line
- B. A biogeographical boundary separating Asian and Australian fauna in Southeast Asia  ✅
- C. The border between the tropics and subtropics
- D. The depth contour of 200 m marking the continental shelf

**94. Which tectonic boundary runs through the East African Rift Valley?**
- A. A convergent plate boundary
- B. A divergent plate boundary  ✅
- C. A transform fault boundary
- D. A subduction zone boundary

**95. What is the name of the vast, flat, treeless plain that stretches across northern Russia and Canada?**
- A. Pampas
- B. Steppe
- C. Tundra  ✅
- D. Taiga

**96. Which country contains the Atacama Desert, one of the driest places on Earth?**
- A. Peru
- B. Argentina
- C. Chile  ✅
- D. Bolivia

**97. What is the geographic term for a U-shaped valley carved by a glacier?**
- A. Canyon
- B. Fjord
- C. Arête
- D. Glacial trough  ✅

**98. Which ocean current keeps northwestern Europe significantly warmer than its latitude would suggest?**
- A. Benguela Current
- B. Gulf Stream / North Atlantic Current  ✅
- C. Labrador Current
- D. Canary Current

**99. What is the name of the ancient supercontinent that broke apart to form today's continents?**
- A. Laurasia
- B. Gondwana
- C. Pangaea  ✅
- D. Rodinia

**100. Which country has the largest Exclusive Economic Zone (ocean territory)?**
- A. USA
- B. Russia
- C. France  ✅
- D. Australia

**101. What is 'karst topography'?**
- A. Flat plains formed by river deposition
- B. Landscape shaped by the dissolution of soluble rocks, featuring sinkholes, caves and disappearing streams  ✅
- C. Volcanic terrain with lava plateaus
- D. Wind-eroded desert scenery

**102. Which strait connects the Black Sea to the Sea of Marmara, running through Istanbul?**
- A. Dardanelles
- B. Bosphorus  ✅
- C. Kerch Strait
- D. Otranto Strait

---

## Food (102 questions)

### Easy (34)

**1. Which spice is responsible for giving turmeric its bright yellow colour?**
- A. Saffron
- B. Curcumin  ✅
- C. Paprika
- D. Annatto

**2. What is the main ingredient in guacamole?**
- A. Tomato
- B. Avocado  ✅
- C. Mango
- D. Lime

**3. Which country is the origin of sushi?**
- A. China
- B. Korea
- C. Vietnam
- D. Japan  ✅

**4. What type of pastry is used to make a croissant?**
- A. Choux
- B. Shortcrust
- C. Filo
- D. Laminated/puff  ✅

**5. What is the primary ingredient in hummus?**
- A. Lentils
- B. Black beans
- C. Chickpeas  ✅
- D. Edamame

**6. Pizza originated in which country?**
- A. Spain
- B. Greece
- C. France
- D. Italy  ✅

**7. What does the 'vinegar' in fish and chips traditionally refer to?**
- A. White wine vinegar
- B. Malt vinegar  ✅
- C. Apple cider vinegar
- D. Balsamic vinegar

**8. Which fruit is known as the 'king of fruits' in South and Southeast Asia?**
- A. Jackfruit
- B. Durian  ✅
- C. Rambutan
- D. Mangosteen

**9. What type of bean is used to make traditional Indian dal?**
- A. Kidney beans
- B. Chickpeas
- C. Lentils  ✅
- D. Black-eyed peas

**10. Which country invented the dish 'Pad Thai'?**
- A. Vietnam
- B. Cambodia
- C. Thailand  ✅
- D. Laos

**11. What is the main ingredient in a traditional Margherita pizza topping?**
- A. Pesto and basil
- B. Tomato sauce, mozzarella and basil  ✅
- C. BBQ sauce and chicken
- D. Cream and mushrooms

**12. Which grain is used to make sushi rice?**
- A. Long-grain white rice
- B. Short-grain white rice  ✅
- C. Brown rice
- D. Jasmine rice

**13. What is the key fermented ingredient in traditional Korean kimchi?**
- A. Soy sauce
- B. Miso paste
- C. Napa cabbage and gochugaru (red chilli)  ✅
- D. Ginger and garlic only

**14. Which nut is marzipan traditionally made from?**
- A. Hazelnut
- B. Walnut
- C. Almond  ✅
- D. Cashew

**15. What colour is a ripe mango on the inside?**
- A. White
- B. Red
- C. Yellow-orange  ✅
- D. Green

**16. Which spice is known as the world's most expensive by weight?**
- A. Vanilla
- B. Cardamom
- C. Saffron  ✅
- D. Turmeric

**17. What is the base spirit in a classic Margarita cocktail?**
- A. Vodka
- B. Rum
- C. Gin
- D. Tequila  ✅

**18. Which vegetable is the main ingredient in a traditional French ratatouille?**
- A. Carrots and peas
- B. Aubergine/eggplant, courgette and tomatoes  ✅
- C. Potatoes and leeks
- D. Broccoli and cauliflower

**19. What is a 'naan'?**
- A. A type of flat oven-baked bread  ✅
- B. A rice dish from South Asia
- C. A deep-fried snack
- D. A lentil-based curry

**20. Which country produces the most coffee in the world?**
- A. Colombia
- B. Ethiopia
- C. Brazil  ✅
- D. Vietnam

**21. What does 'al dente' mean when cooking pasta?**
- A. Well done, soft throughout
- B. Slightly firm to the bite  ✅
- C. Cooked in salted water
- D. Tossed in olive oil

**22. Which fruit is the main flavour in a traditional Pavlova?**
- A. Strawberry
- B. Passion fruit and kiwi  ✅
- C. Peach
- D. Mango

**23. What is the main protein in a traditional Caesar salad?**
- A. Tuna
- B. Salmon
- C. Chicken or anchovies  ✅
- D. Prawns

**24. Which sauce is made from fermented soybeans and is salty and dark?**
- A. Fish sauce
- B. Soy sauce  ✅
- C. Oyster sauce
- D. Hoisin sauce

**25. What type of food is 'prosciutto'?**
- A. Italian cured ham  ✅
- B. French cheese
- C. Spanish chorizo
- D. Greek yoghurt

**26. Which herb is most commonly used in Italian pesto?**
- A. Parsley
- B. Oregano
- C. Rosemary
- D. Basil  ✅

**27. What is the main ingredient in a traditional Spanish gazpacho?**
- A. Cucumber
- B. Potato
- C. Tomato  ✅
- D. Beetroot

**28. What is 'tofu' made from?**
- A. Chickpeas
- B. Almonds
- C. Soy milk  ✅
- D. Coconut milk

**29. Which country is the origin of the dish 'paella'?**
- A. Portugal
- B. Italy
- C. France
- D. Spain  ✅

**30. What cooking method involves submerging food in oil at high heat?**
- A. Steaming
- B. Poaching
- C. Deep-frying  ✅
- D. Braising

**31. What is the main ingredient in a traditional French onion soup?**
- A. Onion and beef broth  ✅
- B. Potato and cream
- C. Leek and chicken stock
- D. Garlic and white wine

**32. Which spice gives chai tea its characteristic warm flavour?**
- A. Cinnamon alone
- B. Ginger alone
- C. A blend of spices including cardamom, ginger, cinnamon and cloves  ✅
- D. Turmeric and pepper

**33. What is the name of the Japanese soup with noodles in a rich broth?**
- A. Udon
- B. Ramen  ✅
- C. Soba
- D. Pho

**34. What is 'paneer'?**
- A. A type of Indian bread
- B. A fresh, non-melting cheese used in Indian cooking  ✅
- C. A spice blend
- D. A fermented lentil dish


### Medium (34)

**35. What is the Maillard reaction in cooking?**
- A. The process of caramelising sugar
- B. A chemical reaction between amino acids and sugars that causes browning and flavour development  ✅
- C. The emulsification of fats in sauces
- D. The gelatinisation of starch when heated

**36. Which Italian region is Parmigiano-Reggiano cheese legally required to come from?**
- A. Tuscany
- B. Lombardy
- C. Emilia-Romagna  ✅
- D. Veneto

**37. What is the primary difference between 'stock' and 'broth' in cooking?**
- A. Stock uses vegetables only; broth uses meat
- B. Stock is made primarily from bones and is typically unseasoned; broth is made from meat and is seasoned  ✅
- C. There is no meaningful difference
- D. Stock is clear; broth is always cloudy

**38. What is 'mise en place' in professional cooking?**
- A. A French plating technique
- B. The preparation and organisation of all ingredients before cooking begins  ✅
- C. The method of tasting food during cooking
- D. A classical French sauce

**39. Which country produces Wagyu beef?**
- A. Australia
- B. USA
- C. Argentina
- D. Japan  ✅

**40. What is the name of the Indian bread baked in a tandoor oven and typically served with curry?**
- A. Roti
- B. Paratha
- C. Naan  ✅
- D. Puri

**41. What is 'umami' considered in taste classification?**
- A. A variety of sourness
- B. The fifth basic taste, often described as savoury or meaty  ✅
- C. A type of sweetness from fermented foods
- D. The sensation of fat in food

**42. Which cheese is traditionally used in a Greek salad?**
- A. Halloumi
- B. Feta  ✅
- C. Ricotta
- D. Kasseri

**43. What is the key process that makes sourdough bread different from regular bread?**
- A. Using baking powder instead of yeast
- B. Slow fermentation using a wild yeast and bacterial starter culture  ✅
- C. Adding vinegar to the dough
- D. Baking twice at different temperatures

**44. Which fermented fish sauce is a key ingredient in ancient Roman cooking and modern Southeast Asian cuisine?**
- A. Worcestershire sauce
- B. Garum/fish sauce  ✅
- C. Oyster sauce
- D. Miso broth

**45. What is the spice 'asafoetida' used for in Indian cooking?**
- A. Adding heat like chilli
- B. Replacing onion and garlic in dishes, providing a pungent savoury note  ✅
- C. Adding colour to rice
- D. Sweetening desserts

**46. Which French sauce is made from egg yolks, butter and lemon juice or vinegar?**
- A. Béchamel
- B. Hollandaise  ✅
- C. Velouté
- D. Espagnole

**47. What is the traditional Japanese technique of preparing fugu (puffer fish)?**
- A. Marinating in miso for 24 hours to neutralise toxins
- B. Precise butchering by a licensed chef to remove the toxic organs  ✅
- C. Fermenting the fish for several months
- D. Flash-freezing to destroy parasites

**48. What is 'tempering chocolate'?**
- A. Melting chocolate to add to a ganache
- B. A process of heating and cooling chocolate to stabilise the cocoa butter crystals for a glossy finish  ✅
- C. Adding tempered milk to couverture chocolate
- D. Measuring the cocoa percentage of a bar

**49. Which country is the origin of the flatbread 'injera' and the dish it accompanies?**
- A. Sudan
- B. Somalia
- C. Ethiopia  ✅
- D. Kenya

**50. What gives Sichuan cuisine its characteristic numbing sensation?**
- A. Bird's eye chilli
- B. Sichuan peppercorns containing hydroxy-alpha-sanshool  ✅
- C. A type of ginger
- D. White pepper in large quantities

**51. What is the name of the Japanese condiment made from fermented soybeans with a very pungent smell?**
- A. Miso
- B. Doenjang
- C. Natto  ✅
- D. Tempeh

**52. Which fat is traditionally used in a classic French croissant?**
- A. Vegetable shortening
- B. Coconut oil
- C. Lard
- D. Butter  ✅

**53. What is 'chaat masala', used widely in Indian street food?**
- A. A dry spice blend with amchur, cumin and chaat, giving a tangy-sour flavour  ✅
- B. A wet marinade for tikka dishes
- C. A sauce for street-food wraps
- D. A blend of garam masala and red chilli only

**54. What is the origin country of 'Bibimbap'?**
- A. China
- B. Japan
- C. Vietnam
- D. South Korea  ✅

**55. What is the culinary term 'julienne' used to describe?**
- A. A type of French omelette
- B. Cutting vegetables into thin matchstick strips  ✅
- C. A braising technique for tough cuts
- D. A style of layered pastry

**56. Which fish is traditionally used in a classic bouillabaisse?**
- A. Salmon and cod
- B. A variety of Mediterranean rockfish  ✅
- C. Tuna and swordfish
- D. Mackerel and herring

**57. What is the key ingredient that makes a 'consommé' different from regular stock?**
- A. It is made from fish only
- B. It is clarified using a 'raft' of egg whites and minced meat to produce a crystal-clear soup  ✅
- C. It is always cold-served
- D. It uses roasted vegetables only

**58. What does 'charcuterie' refer to?**
- A. The art of cheese making and ageing
- B. Prepared meat products such as sausages, pâtés and cured meats  ✅
- C. The French tradition of pastry making
- D. A style of bread fermentation

**59. Which Indian bread is made by shallow-frying layered dough and is flaky?**
- A. Puri
- B. Bhatura
- C. Naan
- D. Paratha  ✅

**60. What is 'molecular gastronomy'?**
- A. Studying the chemical and physical transformations in cooking at a scientific level  ✅
- B. A type of cuisine from Southeast Asia
- C. A method of calorie counting in professional kitchens
- D. The study of fermentation in food

**61. What is the name of the creamy Portuguese egg custard tart?**
- A. Canelé
- B. Pastel de nata  ✅
- C. Madeleine
- D. Flan

**62. Which protein gives bread dough its elastic structure?**
- A. Casein
- B. Gluten  ✅
- C. Zein
- D. Albumin

**63. What is 'ghee' in Indian cooking?**
- A. A type of yoghurt-based marinade
- B. Clarified butter with milk solids removed  ✅
- C. A spiced lentil paste
- D. Rendered lard used in frying

**64. Which country invented the technique of confit — preserving meat in its own fat?**
- A. Italy
- B. Spain
- C. France  ✅
- D. Portugal

**65. What makes 'Neapolitan pizza' distinct from other styles?**
- A. Thicker crust and heavier toppings
- B. A thin, soft crust cooked in a wood-fired oven at very high temperatures  ✅
- C. Stuffed crust with extra cheese
- D. A rectangular shape baked in a pan

**66. What is 'tahini' made from?**
- A. Sunflower seeds
- B. Sesame seeds  ✅
- C. Hemp seeds
- D. Flaxseeds

**67. What is 'ceviche' and where does it originate?**
- A. A slow-cooked beef stew from Mexico
- B. Raw fish cured in citrus juice, originating from Peru  ✅
- C. A fermented prawn paste from Southeast Asia
- D. A smoked fish salad from Scandinavia

**68. What is the purpose of 'resting' meat after cooking?**
- A. To allow the meat to cool for safe handling
- B. To allow juices to redistribute throughout the meat for a more moist result  ✅
- C. To finish cooking through carryover heat only
- D. To firm up the exterior crust


### Hard (34)

**69. What is the precise culinary definition of 'emulsification'?**
- A. Thickening a sauce by reducing liquid
- B. Combining two immiscible liquids (typically oil and water) into a stable mixture using an emulsifier  ✅
- C. The process of clarifying a stock
- D. Binding fat to starch during frying

**70. Which enzyme in raw pineapple breaks down protein and prevents gelatin-based desserts from setting?**
- A. Papain
- B. Bromelain  ✅
- C. Ficin
- D. Actinidin

**71. What is the 'smoke point' of an oil and why does it matter?**
- A. The temperature at which oil begins to burn with open flame
- B. The temperature at which an oil breaks down, produces smoke and harmful compounds, affecting flavour  ✅
- C. The ideal temperature for deep-frying chicken
- D. The point at which oil solidifies

**72. Which traditional French sauce is a reduction of white wine, vinegar and tarragon, finished with egg yolk and butter?**
- A. Béarnaise  ✅
- B. Hollandaise
- C. Beurre blanc
- D. Velouté

**73. What is the significance of 'specific heat capacity' when choosing a pan material for cooking?**
- A. Higher specific heat means faster heating
- B. Materials with lower specific heat heat up and cool quickly (responsive), while higher specific heat retains heat longer  ✅
- C. It determines how non-stick a surface becomes
- D. It measures the pan's corrosion resistance

**74. What is 'spherification' in modern cooking?**
- A. A technique of rolling dough into spheres
- B. A process using sodium alginate and calcium chloride to form liquid-filled spheres with a gel membrane  ✅
- C. Deep-frying small balls of food
- D. A method of forming cheese into round shapes

**75. What is the difference between 'dry-aged' and 'wet-aged' beef?**
- A. Dry-aged is cooked immediately; wet-aged is frozen
- B. Dry-aged is exposed to air in a controlled environment, developing deep flavour; wet-aged is sealed in vacuum packaging  ✅
- C. Dry-aged uses no salt; wet-aged is heavily brined
- D. Dry-aged is cheaper and faster than wet-aged

**76. Why does adding salt to pasta water improve the dish beyond just flavour?**
- A. It raises the boiling point significantly, cooking pasta faster
- B. It seasons the pasta from within as it absorbs water and raises boiling point slightly  ✅
- C. It prevents pasta from sticking to the pot
- D. It breaks down the gluten structure for softer pasta

**77. Which Japanese technique of 'umami layering' uses two primary umami compounds together for a synergistic effect?**
- A. Glutamate and inosinate  ✅
- B. Tannin and saponin
- C. Glutamate and aspartate
- D. Ribonucleotides and polyphenols

**78. What is the ideal temperature range for cold smoking food?**
- A. 0–4°C
- B. 20–30°C  ✅
- C. 60–80°C
- D. 100–120°C

**79. What is 'terroir' when applied to food and wine?**
- A. The classification system of French wines
- B. The complete natural environment (soil, climate, terrain) that influences the taste of food or wine produced there  ✅
- C. The ageing technique applied to cheese
- D. The mineral content of water used in brewing

**80. Which cooking method is 'sous vide' and what is its primary advantage?**
- A. Cooking over charcoal at very high heat for intense flavour
- B. Cooking vacuum-sealed food in a precisely temperature-controlled water bath, enabling perfect doneness throughout  ✅
- C. Steam cooking in a sealed pressure vessel
- D. Slow-roasting in a covered clay pot

**81. What is the role of 'pectin' in jam and jelly making?**
- A. It adds flavour and colour to the preserve
- B. A naturally occurring carbohydrate in fruit that forms a gel when cooked with sugar and acid  ✅
- C. It acts as a preservative preventing mould
- D. It clarifies the liquid to produce a clear jelly

**82. What is the culinary process of 'chiffonade'?**
- A. Finely dicing shallots and herbs together
- B. Stacking, rolling and slicing leafy herbs or vegetables into thin ribbons  ✅
- C. A classical brunoise cut smaller than 3 mm
- D. Blanching and shocking green vegetables

**83. What is 'cultured butter' and what distinguishes it from standard butter?**
- A. Butter from cows fed grass only
- B. Butter made from fermented cream, giving it a tangy, complex flavour  ✅
- C. Unsalted butter clarified for high-heat cooking
- D. Butter with added probiotics and vitamins

**84. Which Maillard reaction by-products are responsible for the characteristic crust aroma of freshly baked bread?**
- A. Volatile fatty acids from yeast fermentation
- B. Melanoidins and pyrazines formed during baking  ✅
- C. Caramelised lactose from milk solids
- D. Oxidised gluten proteins

**85. What is 'hydrocolloid' cookery and which common example is used in molecular gastronomy?**
- A. The study of water content in produce
- B. Using gelling or thickening agents (e.g. agar, xanthan gum, carrageenan) to create unusual textures  ✅
- C. Cooking with very high-pressure steam
- D. A method of cooking with cold nitrogen gas

**86. Which region of Italy produces 'Aceto Balsamico Tradizionale', the most prized balsamic vinegar, aged minimum 12 years?**
- A. Tuscany
- B. Sicily
- C. Modena and Reggio Emilia  ✅
- D. Umbria

**87. What is the biological reason why cutting onions makes you cry?**
- A. Acidic juice irritates the eyes on contact
- B. An enzyme reaction converts sulphur compounds into propanethial S-oxide, a volatile gas that reacts with tear fluid to form sulphuric acid  ✅
- C. Pollen released from the onion's layers causes allergy
- D. Ammonia vapours are released when the cells are ruptured

**88. What does 'Appellation d'Origine Contrôlée' (AOC) guarantee in French food and wine?**
- A. The product is organic and pesticide-free
- B. The product is made in a specific region using traditional methods, ensuring geographical origin and quality  ✅
- C. The product has been aged for a minimum legally defined period
- D. The producer has met calorie labelling requirements

**89. What is 'transglutaminase', sometimes called 'meat glue'?**
- A. An additive that preserves meat for longer
- B. An enzyme that bonds proteins together, allowing pieces of meat to be fused into a uniform cut  ✅
- C. A tenderising salt used in dry-ageing
- D. A curing salt mixture for charcuterie

**90. What is the chemistry behind why coffee tastes bitter even when sweetened?**
- A. Sugar does not fully dissolve in hot liquid
- B. Chlorogenic acid lactones and quinic acid formed during roasting bind to bitter taste receptors persistently  ✅
- C. High-temperature water extracts more tannins
- D. The crema layer contains the most bitter compounds

**91. What is 'autolysis' in bread baking?**
- A. The process of stretching and folding dough during fermentation
- B. Resting flour and water before adding yeast and salt, allowing enzymes to begin breaking down starch and proteins for better gluten development  ✅
- C. The oven spring that occurs in the first minutes of baking
- D. Retarding dough in a cold environment overnight

**92. What is the purpose of 'blooming' gelatin before use?**
- A. Flavouring the gelatin with herbs
- B. Allowing gelatin granules to absorb cold water and swell, ensuring even dissolving and a smooth final texture  ✅
- C. Warming gelatin to activate its gelling property
- D. Dissolving sugar into the gelatin base

**93. Which traditional Japanese cooking philosophy guides using every part of an ingredient with nothing wasted?**
- A. Washoku
- B. Mottainai  ✅
- C. Ikigai
- D. Umami

**94. What is a 'beurre noisette' and at what point does it turn from good to burnt?**
- A. Clarified butter with water removed; it burns at 200°C
- B. Butter cooked until milk solids turn golden and nutty (hazelnut colour) at around 130–140°C; it turns black ('beurre noir') if taken further  ✅
- C. Whipped butter infused with herbs; it burns at 90°C
- D. Emulsified butter with cream; it splits above 75°C

**95. What is the functional difference between 'baking soda' and 'baking powder'?**
- A. There is no functional difference
- B. Baking soda is pure sodium bicarbonate needing an acid in the recipe; baking powder contains baking soda plus a dry acid and reacts on its own  ✅
- C. Baking powder is stronger and always used in smaller quantities
- D. Baking soda gives flavour; baking powder provides all the lift

**96. What is 'retrograde starch' and why is it relevant to day-old bread?**
- A. Starch that has never been cooked
- B. When cooked starch cools, amylose crystallises back into an ordered structure, making bread firm and stale  ✅
- C. Starch that has been broken down completely by enzymes
- D. Uncooked starch granules that remain hard in the centre of dense bread

**97. What is the difference between a 'compound' and a 'classic' butter sauce?**
- A. Compound butter uses more cream; classic butter sauce uses less
- B. Compound butter is softened butter blended with flavourings; classic sauces like beurre blanc are emulsified warm butter sauces  ✅
- C. Compound butter is French; classic is Italian
- D. Classic butter sauce is always cold; compound is always served warm

**98. What is 'convection' versus 'conduction' as methods of heat transfer in cooking?**
- A. Conduction is faster; convection is slower
- B. Conduction transfers heat through direct contact; convection transfers it through the movement of a fluid (air or liquid)  ✅
- C. Convection happens in ovens only; conduction in pans only
- D. They are the same process at different temperatures

**99. What is 'carryover cooking' and why must it be accounted for when roasting meat?**
- A. The heat retained in the oven after it is turned off
- B. The continued cooking of food from residual internal heat after it is removed from the heat source, raising internal temperature by 3–8°C  ✅
- C. Basting a roast to prevent the exterior from drying out
- D. The transfer of flavour from bones to meat during slow roasting

**100. What is 'acidulation' in culinary technique?**
- A. Adding acid to reduce a sauce
- B. Treating cut fruit or vegetables with acidulated water (with lemon juice or vinegar) to prevent enzymatic browning  ✅
- C. Marinating proteins in acid to denature and tenderise them
- D. The process of adding acidity to wine-based sauces

**101. Which compound in chilli peppers causes the sensation of heat and activates TRPV1 pain receptors?**
- A. Piperine
- B. Gingerol
- C. Capsaicin  ✅
- D. Allicin

**102. What is the culinary term for cutting vegetables into 3 mm uniform cubes?**
- A. Julienne
- B. Chiffonade
- C. Brunoise  ✅
- D. Paysanne

---

## History (102 questions)

### Easy (34)

**1. Who was the first President of the United States?**
- A. John Adams
- B. Benjamin Franklin
- C. George Washington  ✅
- D. Thomas Jefferson

**2. In which year did World War II end?**
- A. 1943
- B. 1944
- C. 1945  ✅
- D. 1946

**3. Which ancient wonder of the world still stands today?**
- A. Colossus of Rhodes
- B. Hanging Gardens of Babylon
- C. Great Pyramid of Giza  ✅
- D. Lighthouse of Alexandria

**4. Who was the first woman to win a Nobel Prize?**
- A. Rosalind Franklin
- B. Marie Curie  ✅
- C. Dorothy Hodgkin
- D. Rita Levi-Montalcini

**5. Which empire was ruled by Julius Caesar?**
- A. Greek Empire
- B. Ottoman Empire
- C. Roman Empire  ✅
- D. Byzantine Empire

**6. In which city did the French Revolution begin?**
- A. Versailles
- B. Lyon
- C. Marseille
- D. Paris  ✅

**7. Who wrote the Declaration of Independence (primary drafter)?**
- A. George Washington
- B. Benjamin Franklin
- C. John Adams
- D. Thomas Jefferson  ✅

**8. In what year did India gain independence from British rule?**
- A. 1945
- B. 1947  ✅
- C. 1950
- D. 1952

**9. Who was the leader of Nazi Germany during World War II?**
- A. Benito Mussolini
- B. Joseph Stalin
- C. Adolf Hitler  ✅
- D. Francisco Franco

**10. Which ancient civilisation built the pyramids at Giza?**
- A. Roman
- B. Greek
- C. Mesopotamian
- D. Egyptian  ✅

**11. Who is known for his non-violent resistance movement that helped India gain independence?**
- A. Jawaharlal Nehru
- B. Sardar Patel
- C. Subhas Chandra Bose
- D. Mahatma Gandhi  ✅

**12. What was the name of the ship that sank on its maiden voyage in 1912?**
- A. The Lusitania
- B. The Britannic
- C. The Titanic  ✅
- D. The Olympic

**13. Who ruled England as Queen for over 60 years in the 19th century?**
- A. Queen Elizabeth I
- B. Queen Mary I
- C. Queen Anne
- D. Queen Victoria  ✅

**14. In which year did the Berlin Wall fall?**
- A. 1985
- B. 1987
- C. 1989  ✅
- D. 1991

**15. What was the name of the first man-made satellite, launched by the Soviet Union in 1957?**
- A. Vostok
- B. Luna
- C. Sputnik  ✅
- D. Mir

**16. Who was the first human to walk on the Moon?**
- A. Buzz Aldrin
- B. Yuri Gagarin
- C. Michael Collins
- D. Neil Armstrong  ✅

**17. Which country was the first to give women the right to vote (in national elections, 1893)?**
- A. USA
- B. UK
- C. Finland
- D. New Zealand  ✅

**18. Who was the ancient Greek philosopher who taught Alexander the Great?**
- A. Socrates
- B. Plato
- C. Aristotle  ✅
- D. Pythagoras

**19. What was the name of the long journey taken by the Chinese Communist Party's army in 1934–35?**
- A. The Great Leap
- B. The Long March  ✅
- C. The Dragon's Walk
- D. The Red Trek

**20. In which century did the Renaissance begin in Italy?**
- A. 12th
- B. 13th
- C. 14th  ✅
- D. 15th

**21. Which war was fought between the North and South of the United States?**
- A. Revolutionary War
- B. War of 1812
- C. Civil War  ✅
- D. Mexican–American War

**22. Who discovered penicillin by accident in 1928?**
- A. Louis Pasteur
- B. Robert Koch
- C. Alexander Fleming  ✅
- D. Joseph Lister

**23. What was the name of the first artificial Earth satellite?**
- A. Explorer 1
- B. Sputnik 1  ✅
- C. Luna 1
- D. Vanguard 1

**24. Which battle in 1815 ended Napoleon's rule for the final time?**
- A. Austerlitz
- B. Trafalgar
- C. Borodino
- D. Waterloo  ✅

**25. Who led the Cuban Revolution and became Cuba's leader?**
- A. Ernesto Che Guevara
- B. Camilo Cienfuegos
- C. Raúl Castro
- D. Fidel Castro  ✅

**26. In which year did the First World War begin?**
- A. 1912
- B. 1914  ✅
- C. 1916
- D. 1918

**27. Which civilisation built Machu Picchu in Peru?**
- A. Aztec
- B. Maya
- C. Olmec
- D. Inca  ✅

**28. Who was the last Pharaoh of ancient Egypt?**
- A. Nefertiti
- B. Hatshepsut
- C. Cleopatra  ✅
- D. Nefertari

**29. What was the name of the first nuclear bomb dropped on Japan in 1945?**
- A. Fat Man
- B. Little Boy  ✅
- C. Big Bang
- D. Trinity

**30. Which country did the US fight during the Vietnam War?**
- A. North Korea
- B. China
- C. North Vietnam  ✅
- D. Cambodia

**31. Who was South Africa's first Black President?**
- A. Desmond Tutu
- B. Oliver Tambo
- C. Nelson Mandela  ✅
- D. Walter Sisulu

**32. Which ancient city was buried by the eruption of Mount Vesuvius in 79 AD?**
- A. Rome
- B. Athens
- C. Herculaneum
- D. Pompeii  ✅

**33. What document did King John of England sign in 1215, limiting the king's power?**
- A. The Bill of Rights
- B. Magna Carta  ✅
- C. The Treaty of Westphalia
- D. The Act of Settlement

**34. Who was known as the 'Iron Lady' of British politics?**
- A. Margaret Thatcher  ✅
- B. Theresa May
- C. Barbara Castle
- D. Edith Summerskill


### Medium (34)

**35. What was the name of the plan for the post-WWII reconstruction of Europe funded by the United States?**
- A. Truman Doctrine
- B. Marshall Plan  ✅
- C. Eisenhower Initiative
- D. Lend-Lease Act

**36. In which year did the Soviet Union launch the first human into space, Yuri Gagarin?**
- A. 1957
- B. 1959
- C. 1961  ✅
- D. 1963

**37. Which Chinese dynasty built the majority of the Great Wall of China as it stands today?**
- A. Han
- B. Tang
- C. Song
- D. Ming  ✅

**38. What was the name of the policy of racial segregation in South Africa?**
- A. Jim Crow
- B. Apartheid  ✅
- C. Segregación
- D. Bantustaan

**39. Who was the Byzantine emperor who codified Roman law into the Corpus Juris Civilis?**
- A. Constantine I
- B. Theodosius I
- C. Justinian I  ✅
- D. Heraclius

**40. Which event triggered the First World War?**
- A. Sinking of the Lusitania
- B. Assassination of Archduke Franz Ferdinand  ✅
- C. The invasion of Belgium
- D. The July Crisis telegram

**41. What was the name of the British secret intelligence operation that decoded German Enigma messages in WWII?**
- A. Operation Overlord
- B. Operation Barbarossa
- C. Ultra  ✅
- D. Bletchley Protocol

**42. In which year did the Russian Revolution take place, overthrowing the Tsar?**
- A. 1914
- B. 1915
- C. 1917  ✅
- D. 1920

**43. Which explorer was the first European to reach India by sea, sailing around Africa?**
- A. Christopher Columbus
- B. Ferdinand Magellan
- C. Bartolomeu Dias
- D. Vasco da Gama  ✅

**44. Who led the Mongol Empire at its greatest extent in the 13th century?**
- A. Ögedei Khan
- B. Kublai Khan
- C. Genghis Khan  ✅
- D. Timur

**45. What was the name of the agreement that ended WWI, signed in 1919?**
- A. Treaty of Utrecht
- B. Congress of Vienna
- C. Treaty of Versailles  ✅
- D. Treaty of Brest-Litovsk

**46. Which ancient trade network connected China to the Mediterranean world?**
- A. Amber Road
- B. Spice Route
- C. Silk Road  ✅
- D. Incense Trail

**47. What was the Reformation, begun by Martin Luther in 1517?**
- A. A revolution against the French monarchy
- B. A movement challenging the authority of the Catholic Church and leading to Protestant Christianity  ✅
- C. The rebuilding of Rome after its sack
- D. A reform of Islamic jurisprudence

**48. Which empire was known as the 'Sick Man of Europe' in the 19th century?**
- A. Austro-Hungarian Empire
- B. Russian Empire
- C. Ottoman Empire  ✅
- D. Spanish Empire

**49. What was 'Manifest Destiny' in 19th-century American history?**
- A. The belief that the USA was destined to expand across the North American continent  ✅
- B. The Monroe Doctrine declaring the Americas off-limits to European powers
- C. The campaign to abolish slavery
- D. The annexation of Alaska from Russia

**50. Who was the first Emperor of unified China, standardising writing, currency and weights?**
- A. Liu Bang
- B. Wu Zetian
- C. Qin Shi Huang  ✅
- D. Xuanzong

**51. What was the 'Scramble for Africa' in the late 19th century?**
- A. An economic competition between African kingdoms
- B. The rapid colonisation of Africa by European powers between the 1880s and WWI  ✅
- C. An African resistance movement against colonial rule
- D. A series of wars between Egypt and Sudan

**52. Which revolutionary led the liberation of much of South America from Spanish rule?**
- A. José de San Martín
- B. Bernardo O'Higgins
- C. Simón Bolívar  ✅
- D. Antonio José de Sucre

**53. What was the 'Cultural Revolution' in China (1966–76)?**
- A. A campaign to promote Chinese arts internationally
- B. A political campaign by Mao Zedong targeting perceived capitalist and traditional elements, causing mass upheaval  ✅
- C. The modernisation of China's economy under Deng Xiaoping
- D. A revolution in Chinese education and technology

**54. Who was the Aztec ruler when the Spanish conquistadors arrived in 1519?**
- A. Cuauhtémoc
- B. Itzcoatl
- C. Moctezuma II  ✅
- D. Ahuitzotl

**55. What was the main cause of the Irish Potato Famine (1845–52)?**
- A. Drought destroying all crops
- B. A potato blight (Phytophthora infestans) destroying the staple crop amid continued food exports  ✅
- C. British trade embargo on Irish goods
- D. A series of unusually cold winters freezing the harvest

**56. Which naval battle in 1571 halted the Ottoman expansion into the western Mediterranean?**
- A. Battle of Lepanto  ✅
- B. Battle of Trafalgar
- C. Battle of Actium
- D. Battle of Salamis

**57. What was the significance of the 'Meiji Restoration' in Japan (1868)?**
- A. The establishment of a military dictatorship
- B. The restoration of imperial rule and rapid modernisation and industrialisation of Japan  ✅
- C. A Buddhist revival movement
- D. The annexation of Korea and Taiwan

**58. Who commanded the Allied forces on D-Day, June 6, 1944?**
- A. Bernard Montgomery
- B. George Patton
- C. Dwight D. Eisenhower  ✅
- D. Omar Bradley

**59. What was the 'Dawes Plan' of 1924?**
- A. A US plan to partition Germany after WWI
- B. An American scheme to restructure German reparation payments and stabilise the German economy  ✅
- C. A French plan for occupying the Ruhr Valley
- D. A League of Nations disarmament plan

**60. Which Indian emperor converted to Buddhism after the bloody Kalinga War?**
- A. Chandragupta Maurya
- B. Bindusara
- C. Ashoka  ✅
- D. Chandragupta II

**61. What was the significance of the Haitian Revolution (1791–1804)?**
- A. The first successful slave-led revolution, establishing the first Black republic in the world  ✅
- B. A revolution against French settlers by the indigenous Taino people
- C. France's voluntary grant of independence to Saint-Domingue
- D. A revolution inspired by the American Constitution

**62. Which Mughal emperor built the Taj Mahal?**
- A. Akbar
- B. Aurangzeb
- C. Jahangir
- D. Shah Jahan  ✅

**63. What was the 'Holocaust'?**
- A. The bombing of European cities in WWII
- B. The systematic genocide of six million Jews and millions of others by Nazi Germany  ✅
- C. The firebombing of Dresden
- D. Stalin's purges in the Soviet Union

**64. Which country launched the 'Great Leap Forward' economic campaign in 1958?**
- A. Soviet Union
- B. North Korea
- C. Cuba
- D. China  ✅

**65. Who assassinated US President Abraham Lincoln in 1865?**
- A. Charles Guiteau
- B. Leon Czolgosz
- C. John Wilkes Booth  ✅
- D. James Earl Ray

**66. What was the significance of the Battle of Thermopylae (480 BC)?**
- A. A decisive Greek victory over Persia
- B. A small Greek force famously delayed the Persian army before being defeated  ✅
- C. The final defeat of the Persian Empire
- D. A Spartan victory over Athens

**67. What was the purpose of the Nuremberg Trials (1945–46)?**
- A. To determine war reparations from Germany
- B. To prosecute Nazi leaders for war crimes, crimes against humanity and crimes against peace  ✅
- C. To divide Germany into occupation zones
- D. To try Nazi doctors for medical experiments

**68. Which Chinese leader launched the 'Great Proletarian Cultural Revolution'?**
- A. Deng Xiaoping
- B. Zhou Enlai
- C. Jiang Zemin
- D. Mao Zedong  ✅


### Hard (34)

**69. What was the 'Defenestration of Prague' of 1618 and why is it significant?**
- A. The expulsion of Jews from Prague
- B. The throwing of Catholic officials from a window, triggering the Thirty Years' War  ✅
- C. The demolition of Prague's old town gates
- D. The first Protestant revolt against the Holy Roman Emperor

**70. Which civilisation developed the first known writing system, cuneiform?**
- A. Egyptians
- B. Indus Valley
- C. Sumerians  ✅
- D. Phoenicians

**71. What was the significance of the Battle of Ain Jalut in 1260?**
- A. The final Crusader victory in the Holy Land
- B. The first major defeat of the Mongol army, halting their expansion into Africa  ✅
- C. Saladin's reconquest of Jerusalem
- D. The destruction of the Knights Templar

**72. What does 'historiography' mean?**
- A. The discovery and excavation of historical sites
- B. The study of how history is written, the methods and assumptions of historians  ✅
- C. The science of dating ancient objects
- D. The compilation of national archives

**73. Which Byzantine emperor split the Roman Empire into Eastern and Western halves administratively in 285 AD?**
- A. Constantine I
- B. Theodosius I
- C. Diocletian  ✅
- D. Justinian I

**74. What was the 'Prester John' legend and its historical impact?**
- A. A mythical Christian king in the East whose existence spurred European exploration and diplomatic missions  ✅
- B. A crusader king who conquered Jerusalem
- C. A legendary Arabic cartographer
- D. A Mongol khan who converted to Christianity

**75. What was the significance of the Taiping Rebellion (1850–64) in China?**
- A. It established the Communist Party of China
- B. One of the deadliest civil wars in history, killing an estimated 20–30 million people  ✅
- C. It led to the founding of the Republic of China in 1912
- D. It expelled all Western missionaries from China

**76. Who led the Haitian Revolution's final phase and became Haiti's first head of state as an independent nation?**
- A. Toussaint Louverture
- B. Jean-Jacques Dessalines  ✅
- C. Alexandre Pétion
- D. Henri Christophe

**77. What was the 'White Man's Burden', a poem by Kipling, used to justify?**
- A. Free trade between Britain and India
- B. Western imperial expansion as a duty to 'civilise' non-European peoples  ✅
- C. The abolition of the slave trade
- D. The settlement of the American West

**78. Which event is considered the start of the 30 Years' War (1618–48) and what made its peace settlement historically unique?**
- A. The St. Bartholomew's Day Massacre; its peace imposed Catholicism on Europe
- B. The Defenestration of Prague; the Peace of Westphalia established the modern concept of sovereign nation-states  ✅
- C. The Sack of Magdeburg; the peace imposed confessional unity
- D. Battle of White Mountain; the peace restored the Habsburg monopoly

**79. What was the significance of the Wannsee Conference of January 1942?**
- A. The planning of Operation Barbarossa
- B. Senior Nazi officials coordinating the logistics of the 'Final Solution' — the systematic murder of all European Jews  ✅
- C. The establishment of the concentration camp system
- D. Hitler's war council on the North Africa campaign

**80. Which Indian dynasty's rule marked the 'Golden Age' of ancient India, associated with advances in science, art and literature?**
- A. Maurya
- B. Chola
- C. Gupta  ✅
- D. Kushan

**81. What was the 'Scramble for Concessions' in China (1898)?**
- A. Western powers claiming treaty ports, leased territories and railway rights following China's weakness after 1895  ✅
- B. China's attempt to buy back Hong Kong from Britain
- C. The Boxer Rebellion's demands for foreign concessions
- D. Japan's annexation of Taiwan and Korea simultaneously

**82. Who wrote 'The Prince', a foundational text of political realism in the Renaissance?**
- A. Leonardo da Vinci
- B. Niccolò Machiavelli  ✅
- C. Erasmus of Rotterdam
- D. Francesco Guicciardini

**83. What was the significance of the Battle of Plassey (1757) for Indian history?**
- A. The Mughal Empire's decisive defeat of the Marathas
- B. The British East India Company's victory over the Nawab of Bengal, establishing British dominance in India  ✅
- C. The first major sepoy revolt against British rule
- D. The defeat of French forces in India

**84. Which empire absorbed the Byzantine Empire by capturing Constantinople in 1453?**
- A. Safavid Empire
- B. Mongol Ilkhanate
- C. Ottoman Empire  ✅
- D. Timurid Empire

**85. What was the 'Great Game' of the 19th century?**
- A. The rivalry between England and France in the Americas
- B. The strategic rivalry between the British and Russian Empires over Central Asia and Afghanistan  ✅
- C. A diplomatic framework governing colonial Africa
- D. A series of military exercises between European powers

**86. What does the term 'feudalism' describe as a system of medieval Europe?**
- A. A money-based economic system of early capitalism
- B. A hierarchical system of land ownership and obligations in exchange for military service and protection  ✅
- C. A democratic system of city-states
- D. A theocratic system governed by the Catholic Church

**87. Who was Timur (Tamerlane) and what were his conquests?**
- A. A Chinese admiral who mapped Southeast Asia
- B. A Central Asian conqueror who built a vast empire from Anatolia to India in the late 14th century  ✅
- C. A Mongol ruler who converted to Islam and reformed its administration
- D. An Indian king who united the subcontinent

**88. What was the significance of the 'Night of the Long Knives' in Nazi Germany (1934)?**
- A. The first Kristallnacht against Jewish businesses
- B. Hitler's purge of the SA's leadership and political rivals, consolidating his authority  ✅
- C. The assassination of President Hindenburg
- D. The Gestapo's first mass arrest of communists

**89. Which ancient Greek historian is often called the 'Father of History'?**
- A. Thucydides
- B. Polybius
- C. Herodotus  ✅
- D. Plutarch

**90. What was the 'Sykes–Picot Agreement' of 1916?**
- A. A secret agreement between Britain and France to divide the Middle East into spheres of influence after WWI  ✅
- B. The armistice terms agreed between the Ottoman Empire and the Allies
- C. The Treaty creating the League of Nations mandate system
- D. A Franco-British plan for the Gallipoli campaign

**91. Who was the last emperor of China, forced to abdicate in 1912?**
- A. Guangxu Emperor
- B. Jiaqing Emperor
- C. Puyi  ✅
- D. Tongzhi Emperor

**92. What was the 'Troubles' in Northern Ireland?**
- A. A famine caused by British economic policies
- B. A decades-long ethno-nationalist conflict between unionists and nationalists, primarily from 1968 to 1998  ✅
- C. A Protestant–Catholic religious war of the 17th century
- D. The campaign for Irish Home Rule in the 1880s

**93. Which ancient road network of the Roman Empire is said to 'lead to Rome'?**
- A. Via Appia
- B. All major Roman roads radiated from the capital  ✅
- C. Via Egnatia
- D. Via Flaminia

**94. What was the 'Meiji oligarchy' in post-Restoration Japan?**
- A. The council of regional samurai lords who ruled Japan collectively
- B. A group of young leaders from domains that led the Meiji Restoration, dominating policy into the 20th century  ✅
- C. The official council of the Emperor's family members
- D. The Zaibatsu industrial conglomerates that controlled the economy

**95. Which Roman emperor issued the Edict of Milan in 313 AD, granting religious tolerance in the empire?**
- A. Nero
- B. Trajan
- C. Constantine I  ✅
- D. Diocletian

**96. What was the 'Continental System' imposed by Napoleon?**
- A. A military alliance of Continental European nations against Britain
- B. Napoleon's trade blockade designed to cripple Britain economically by closing European ports to British goods  ✅
- C. The standardised legal code imposed across Napoleon's empire
- D. A system of roads and canals linking Paris to the empire's extremities

**97. Who was the 16th-century Ottoman sultan known as 'The Magnificent' who brought the empire to its greatest extent?**
- A. Selim I
- B. Suleiman I  ✅
- C. Mehmed II
- D. Bayezid II

**98. What was the significance of the Council of Nicaea (325 AD)?**
- A. It established the Pope's supreme authority over secular rulers
- B. It established foundational Christian doctrine, including the nature of Christ, and produced the Nicene Creed  ✅
- C. It excommunicated the Eastern churches
- D. It authorised the first crusade

**99. Which 1905 event in Russia triggered the first Russian Revolution?**
- A. The assassination of Tsar Nicholas II's brother
- B. Bloody Sunday — troops fired on peaceful protestors petitioning the Tsar in St. Petersburg  ✅
- C. Russia's defeat in the Russo-Japanese War alone
- D. A famine in the Volga region

**100. What was the 'encomienda' system in Spanish colonial America?**
- A. A tax system levied on silver and gold exports
- B. A labour and tribute system granting colonists authority over indigenous people in exchange for supposed protection and religious instruction  ✅
- C. A system of land grants for Spanish settlers only
- D. An early form of plantation slavery using only African slaves

**101. Who was Simón Bolívar and what is his historical legacy?**
- A. A Mexican revolutionary who fought Spain to a standstill
- B. A South American independence leader who liberated modern Venezuela, Colombia, Ecuador, Peru and Bolivia  ✅
- C. A Brazilian emperor who declared independence from Portugal
- D. An Argentine general who became the first president of La Plata

**102. What was the primary purpose of the Bretton Woods Conference of 1944?**
- A. To plan the Allied invasion of Japan
- B. To design the post-WWII international monetary system, establishing the IMF, World Bank and dollar-gold standard  ✅
- C. To negotiate the division of Germany
- D. To establish the United Nations Security Council

---

## Music (102 questions)

### Easy (34)

**1. Which band released the album 'Thriller', the best-selling album of all time?**
- A. Prince
- B. Michael Jackson  ✅
- C. Whitney Houston
- D. Madonna

**2. How many strings does a standard guitar have?**
- A. 4
- B. 5
- C. 6  ✅
- D. 7

**3. Which pop star is known as the 'Queen of Pop'?**
- A. Beyoncé
- B. Rihanna
- C. Lady Gaga
- D. Madonna  ✅

**4. What is the name of the group consisting of four people who sing together without instruments?**
- A. Quartet  ✅
- B. Orchestra
- C. Choir
- D. Band

**5. Which singer released 'Rolling in the Deep' in 2010?**
- A. Beyoncé
- B. Rihanna
- C. Adele  ✅
- D. Amy Winehouse

**6. Which instrument does a drummer play?**
- A. Guitar
- B. Piano
- C. Drum kit  ✅
- D. Violin

**7. How many keys does a standard piano have?**
- A. 72
- B. 76
- C. 88  ✅
- D. 92

**8. Which band consisted of John Lennon, Paul McCartney, George Harrison and Ringo Starr?**
- A. The Rolling Stones
- B. The Beach Boys
- C. The Beatles  ✅
- D. Led Zeppelin

**9. What does 'DJ' stand for?**
- A. Digital Jockey
- B. Disc Jockey  ✅
- C. Dance Judge
- D. Dual Junction

**10. Who sang 'Shape of You' in 2017?**
- A. Justin Bieber
- B. Sam Smith
- C. Ed Sheeran  ✅
- D. Harry Styles

**11. What is the name of Taylor Swift's devoted fan base?**
- A. Beyhive
- B. Swifties  ✅
- C. Little Monsters
- D. Beliebers

**12. Which musical note is written on the middle of a standard treble clef?**
- A. D4
- B. B4
- C. C4 (Middle C)  ✅
- D. E4

**13. Which famous opera singer is associated with 'Nessun Dorma' from Turandot?**
- A. Plácido Domingo
- B. José Carreras
- C. Luciano Pavarotti  ✅
- D. Andrea Bocelli

**14. What genre is Kendrick Lamar associated with?**
- A. R&B
- B. Pop
- C. Hip-hop/rap  ✅
- D. Rock

**15. Which instrument is Yo-Yo Ma famous for playing?**
- A. Violin
- B. Piano
- C. Cello  ✅
- D. Flute

**16. What tempo marking means 'slow' in music?**
- A. Allegro
- B. Presto
- C. Largo  ✅
- D. Vivace

**17. Which pop duo recorded 'Don't You Want Me'?**
- A. Eurythmics
- B. Pet Shop Boys
- C. Human League  ✅
- D. Erasure

**18. Who sang 'Hello' (2015) and won multiple Grammy Awards?**
- A. Adele  ✅
- B. Beyoncé
- C. Sam Smith
- D. Amy Winehouse

**19. How many musicians are in a trio?**
- A. 2
- B. 3  ✅
- C. 4
- D. 5

**20. Which city is most associated with the birth of jazz music?**
- A. Chicago
- B. New York
- C. Memphis
- D. New Orleans  ✅

**21. What instrument does a pianist play?**
- A. Organ
- B. Harpsichord
- C. Piano  ✅
- D. Accordion

**22. Which legendary guitarist was known as 'Slowhand'?**
- A. Jimi Hendrix
- B. Eric Clapton  ✅
- C. Carlos Santana
- D. B.B. King

**23. What does 'BPM' stand for in music production?**
- A. Beats Per Minute  ✅
- B. Bass Per Measure
- C. Bars Per Mix
- D. Beat Pattern Mode

**24. Which Scandinavian pop group is known for 'Dancing Queen' and 'Waterloo'?**
- A. A-ha
- B. Roxette
- C. ABBA  ✅
- D. Europe

**25. Who is often called the 'King of Rock and Roll'?**
- A. Chuck Berry
- B. Little Richard
- C. Elvis Presley  ✅
- D. Jerry Lee Lewis

**26. What does 'forte' mean in music dynamics?**
- A. Very softly
- B. Moderately
- C. Loudly  ✅
- D. Very loudly

**27. Which song begins 'Is this the real life? Is this just fantasy?'?**
- A. Somebody to Love
- B. Don't Stop Me Now
- C. Bohemian Rhapsody  ✅
- D. We Will Rock You

**28. Which female artist released 'Lemonade' as a visual album in 2016?**
- A. Rihanna
- B. Beyoncé  ✅
- C. Nicki Minaj
- D. Cardi B

**29. What is the name of the classical music piece known as 'Four Seasons' by Vivaldi?**
- A. The Four Seasons  ✅
- B. Spring Symphony
- C. Seasonal Concerto
- D. Vivaldi Variations

**30. Which rock band is associated with the albums 'The Wall' and 'Dark Side of the Moon'?**
- A. Deep Purple
- B. Genesis
- C. Pink Floyd  ✅
- D. The Who

**31. What is the Italian term for gradually getting louder?**
- A. Decrescendo
- B. Crescendo  ✅
- C. Fortissimo
- D. Rallentando

**32. Which rapper is known for 'God's Plan' and 'Hotline Bling'?**
- A. Kanye West
- B. J. Cole
- C. Drake  ✅
- D. Lil Wayne

**33. Which instrument family includes the trumpet, trombone and French horn?**
- A. Woodwind
- B. Percussion
- C. String
- D. Brass  ✅

**34. What is the term for the repeating chorus-like section of a pop song?**
- A. Bridge
- B. Chorus  ✅
- C. Verse
- D. Outro


### Medium (34)

**35. Which composer wrote the 'Ninth Symphony' despite being completely deaf?**
- A. Mozart
- B. Bach
- C. Schubert
- D. Beethoven  ✅

**36. What time signature is known as 'common time'?**
- A. 3/4
- B. 6/8
- C. 4/4  ✅
- D. 2/2

**37. Which music genre originated in Kingston, Jamaica in the late 1960s?**
- A. Soca
- B. Dancehall
- C. Ska
- D. Reggae  ✅

**38. What does 'a cappella' mean?**
- A. Accompanied by piano only
- B. Very fast
- C. Performed without instrumental accompaniment  ✅
- D. Performed by a solo voice

**39. Who was the lead vocalist of the rock band Queen?**
- A. David Bowie
- B. Robert Plant
- C. Freddie Mercury  ✅
- D. Mick Jagger

**40. What is the name of the chord progression I–V–vi–IV, used in hundreds of pop songs?**
- A. Circle of fifths
- B. Andalusian cadence
- C. The Axis progression  ✅
- D. The Nashville progression

**41. Which composer wrote 'The Magic Flute' and 'Symphony No. 40'?**
- A. Haydn
- B. Handel
- C. Schubert
- D. Mozart  ✅

**42. What genre is Daft Punk most associated with?**
- A. Ambient
- B. House / electronic  ✅
- C. Drum and bass
- D. Trance

**43. Which American city is known as 'Motown' and gave its name to a music genre?**
- A. Chicago
- B. Memphis
- C. Philadelphia
- D. Detroit  ✅

**44. What scale uses only the black keys on a piano?**
- A. Whole-tone scale
- B. Pentatonic scale  ✅
- C. Chromatic scale
- D. Dorian scale

**45. Who composed the 'Four Seasons' violin concertos?**
- A. Corelli
- B. Handel
- C. Telemann
- D. Vivaldi  ✅

**46. Which artist famously burned his guitar on stage at the 1967 Monterey Pop Festival?**
- A. Pete Townshend
- B. Eric Clapton
- C. Carlos Santana
- D. Jimi Hendrix  ✅

**47. What is a 'leitmotif' in classical music and film scores?**
- A. A repeating bass line
- B. A recurring musical theme associated with a character, place or idea  ✅
- C. A variation technique in sonata form
- D. The main theme played only at the opening

**48. Which legendary singer was known as the 'Voice' and recorded 'My Way' and 'New York, New York'?**
- A. Bing Crosby
- B. Dean Martin
- C. Sammy Davis Jr.
- D. Frank Sinatra  ✅

**49. What is 'polyphony' in music?**
- A. Music with no harmonic content
- B. Music consisting of a single melody line
- C. Two or more independent melodic lines sounding simultaneously  ✅
- D. A type of drone-based music

**50. Who wrote the opera 'La Traviata'?**
- A. Puccini
- B. Rossini
- C. Bizet
- D. Verdi  ✅

**51. What is the 'circle of fifths'?**
- A. A visual tool showing the chromatic scale
- B. A diagram showing the relationship between the 12 major and minor keys via intervals of a perfect fifth  ✅
- C. The cycle of a song's verse and chorus
- D. A technique for modulating between keys in jazz

**52. Which British band, featuring Thom Yorke, released 'OK Computer' and 'Kid A'?**
- A. Portishead
- B. Massive Attack
- C. Radiohead  ✅
- D. Blur

**53. What is the 'bridge' in a standard pop song structure?**
- A. The opening instrumental section
- B. A contrasting section that breaks the pattern of verse and chorus, typically appearing once before the final chorus  ✅
- C. A repeat of the first verse
- D. The instrumental solo

**54. Who composed 'The Rite of Spring', whose 1913 premiere famously caused a riot in Paris?**
- A. Debussy
- B. Bartók
- C. Stravinsky  ✅
- D. Prokofiev

**55. What distinguishes a 'turntable' from a standard record player in DJ culture?**
- A. Turntables play CDs; record players play vinyl
- B. Turntables allow manual speed control and backward playback for scratching; standard players are for passive listening  ✅
- C. There is no difference
- D. Record players are digital; turntables are analogue

**56. Which Indian classical form of music uses a 'raga' as its melodic framework?**
- A. Carnatic and Hindustani music both use ragas  ✅
- B. Only Carnatic music
- C. Only Hindustani music
- D. Dhrupad only

**57. What is the 'Nashville Number System'?**
- A. A genre classification for country music
- B. A shorthand way of notating chord progressions using numbers instead of key-specific chord names  ✅
- C. A ranking system for country chart songs
- D. The notation system used in recording studios for lead sheets

**58. Which composer created the opera 'The Barber of Seville'?**
- A. Donizetti
- B. Bellini
- C. Verdi
- D. Rossini  ✅

**59. What is 'call and response' in music?**
- A. When a DJ mixes two tracks simultaneously
- B. A musical pattern where a phrase by one part is answered by another, common in gospel, blues and jazz  ✅
- C. The interaction between soloist and orchestra
- D. A technique of playing the same melody an octave apart

**60. Which composer wrote the 'Unfinished Symphony'?**
- A. Brahms
- B. Mahler
- C. Schumann
- D. Schubert  ✅

**61. What does 'syncopation' mean in rhythm?**
- A. Playing only on the beat
- B. Stressing notes on weak or off-beats, creating a displaced rhythmic feel  ✅
- C. Gradually accelerating the tempo
- D. Playing a steady, unchanging pulse

**62. Which music producer, known as 'Dr. Dre', co-founded which record label with Suge Knight?**
- A. Bad Boy Records
- B. Def Jam Records
- C. Interscope only
- D. Death Row Records  ✅

**63. What is 'atonal' music?**
- A. Music based on a single sustained note
- B. Music that avoids establishing a tonal centre or key  ✅
- C. Music in a minor key only
- D. Music without any dynamics

**64. Which composer wrote the 'Goldberg Variations'?**
- A. Handel
- B. Telemann
- C. Scarlatti
- D. J. S. Bach  ✅

**65. What is the difference between 'melody' and 'harmony'?**
- A. Melody is rhythm; harmony is pitch
- B. Melody is a single sequence of notes; harmony is multiple notes sounded simultaneously to support or enrich it  ✅
- C. Melody is vocal; harmony is instrumental
- D. There is no meaningful distinction

**66. Which hip-hop group included Jay-Z and had massive commercial success with 'Hard Knock Life'?**
- A. Wu-Tang Clan
- B. Roc-A-Fella Records artists under Jay-Z solo career
- C. Jay-Z was always solo  ✅
- D. Rocafella family group

**67. What does the musical marking 'da capo' (D.C.) instruct a performer to do?**
- A. Skip to the coda
- B. Repeat from the beginning  ✅
- C. Play from a specific sign
- D. Fade out gradually

**68. What is a 'tritone' in music theory?**
- A. A chord of three notes
- B. An interval of three whole tones, also called the 'devil's interval' for its dissonance  ✅
- C. A three-part melody
- D. A diminished seventh chord


### Hard (34)

**69. What is 'serialism' in 20th-century music?**
- A. Music based on a series of improvisations
- B. A compositional technique using a fixed order of all 12 pitches (or other parameters) to organise a piece  ✅
- C. Music written in a strict number series like Fibonacci
- D. A minimalist school that uses very few notes

**70. Who developed the 12-tone technique of serialism?**
- A. Alban Berg
- B. Anton Webern
- C. Arnold Schoenberg  ✅
- D. Igor Stravinsky

**71. What is the 'Shepard tone' illusion?**
- A. An optical illusion used in music videos
- B. A continuously 'rising' auditory illusion created by superimposing tones separated by octaves so it seems to ascend forever  ✅
- C. A harmony technique for smooth voice leading
- D. A psychoacoustic effect of very loud low frequencies

**72. What is 'musique concrète'?**
- A. Abstract compositions for orchestra without tonal centre
- B. An early form of electronic music using recorded real-world sounds manipulated on tape  ✅
- C. Music derived entirely from computer synthesis
- D. Impressionist piano music by Debussy's school

**73. Which composer wrote 'Für Elise' and is the subject of debate about the identity of 'Elise'?**
- A. Schubert
- B. Brahms
- C. Schumann
- D. Beethoven  ✅

**74. What is the 'Alberti bass' accompaniment pattern in classical music?**
- A. A fast tremolo in the bass register
- B. A broken-chord pattern (lowest–highest–middle–highest) in the left hand, common in classical piano  ✅
- C. A walking bass line in jazz piano
- D. A repeating octave bass pattern in Baroque music

**75. Who composed 'Tristan und Isolde', famous for its 'Tristan chord' that undermined traditional tonality?**
- A. Mahler
- B. Brahms
- C. Liszt
- D. Wagner  ✅

**76. What is 'spectral music', a compositional school from the 1970s?**
- A. Music based on strict mathematical proportions
- B. Music derived from the acoustic properties of sound spectra, using timbre as a primary structural element  ✅
- C. Music inspired by the colour spectrum
- D. Minimalist music using very long sustained notes

**77. Which classical composer famously described music as 'frozen architecture'?**
- A. Schopenhauer
- B. Nietzsche
- C. Friedrich von Schlegel
- D. Schelling  ✅

**78. What is 'microtonality' in music?**
- A. Using very fast, tiny rhythmic subdivisions
- B. Using intervals smaller than a semitone, outside standard Western tuning  ✅
- C. Playing very quietly (micro = soft)
- D. A technique of close harmonic spacing

**79. What distinguishes 'counterpoint' from simple harmony?**
- A. Counterpoint uses only minor chords
- B. Counterpoint involves two or more independent melodic lines that are harmonically related, each with its own rhythmic identity  ✅
- C. Counterpoint applies only to sacred music
- D. Counterpoint is harmony with added dissonance

**80. Which Bach cantata number contains the famous 'Jesu, Joy of Man's Desiring' chorale?**
- A. BWV 147  ✅
- B. BWV 78
- C. BWV 82
- D. BWV 140

**81. What is 'prepared piano' as invented by John Cage?**
- A. A piano with extra strings added for a lower register
- B. A standard piano modified by placing objects between its strings to alter its timbre  ✅
- C. A player piano with automated hammers
- D. A piano tuned to just intonation

**82. What is 'heterophony' in music?**
- A. Multiple instruments playing in different keys
- B. Simultaneous variations of the same melody performed by different parts  ✅
- C. A choral piece without harmonic support
- D. A type of call and response found only in African music

**83. Which minimalist composer wrote 'Music for 18 Musicians'?**
- A. Philip Glass
- B. La Monte Young
- C. Terry Riley
- D. Steve Reich  ✅

**84. What is the 'Picardy third'?**
- A. A dissonant chord used in Baroque counterpoint
- B. Ending a piece in a minor key with a major chord as the final tonic chord  ✅
- C. A French ornament similar to a mordent
- D. A modulation technique between distantly related keys

**85. What does the term 'rubato' mean in performance?**
- A. Strictly in time
- B. Flexibility in tempo, speeding up and slowing down expressively  ✅
- C. A gradual slowing to the end
- D. A pause on a note or rest

**86. Which opera composer wrote 'Tosca', 'Madama Butterfly' and 'La Bohème'?**
- A. Verdi
- B. Mascagni
- C. Donizetti
- D. Puccini  ✅

**87. What is 'equal temperament' and why was it controversial?**
- A. A tuning system where all 12 semitones are equally spaced, enabling playing in all keys but compromising the pure intervals of just intonation  ✅
- B. A system of tuning each instrument to the same pitch
- C. A Baroque tuning system based on pure ratios only
- D. A modern digital tuning standard approved by the ISO

**88. Which jazz pianist developed bebop alongside Charlie Parker?**
- A. Bill Evans
- B. Thelonious Monk  ✅
- C. Dizzy Gillespie
- D. Dizzy Gillespie and Thelonious Monk — but who was the primary pianist?

**89. What is a 'cadenza' in a classical concerto?**
- A. The conductor's introduction before the orchestra enters
- B. A virtuosic solo passage, often improvised or written out, near the end of a movement  ✅
- C. A brief transitional link between movements
- D. The final chord of a concerto played by the full orchestra

**90. Which concept in music theory describes the tension between a dominant chord and its resolution to the tonic?**
- A. Modulation
- B. Polytonality
- C. Dissonance–consonance resolution / functional harmony  ✅
- D. Atonality

**91. What is 'gamelan' music?**
- A. A type of Japanese court music
- B. A traditional ensemble music of Java and Bali, primarily using tuned percussion instruments  ✅
- C. West African drum-circle music
- D. A Korean stringed instrument tradition

**92. Which American composer wrote 'Appalachian Spring', drawing on folk music?**
- A. Charles Ives
- B. Samuel Barber
- C. Aaron Copland  ✅
- D. Leonard Bernstein

**93. What is 'musicking', a concept introduced by Christopher Small?**
- A. Writing music notation for beginners
- B. The idea that music is an activity (a verb) encompassing all engagement with music, not just the work itself  ✅
- C. Listening to recorded music attentively
- D. The composition of music for commercial use

**94. What is the 'Amen cadence' (plagal cadence)?**
- A. A perfect authentic cadence ending on the tonic
- B. A IV–I chord progression, associated with the word 'Amen' in hymns  ✅
- C. A deceptive cadence where the dominant resolves to vi
- D. A half cadence ending on the dominant

**95. What is 'hemiola' in music?**
- A. A chord built in intervals of a third
- B. A rhythmic effect where three beats in duple time are re-grouped as two beats in triple time  ✅
- C. A form of polyrhythm using five against three
- D. A syncopated pattern on the first and fourth beats

**96. Which German composer wrote 'The Well-Tempered Clavier' as a demonstration of equal temperament?**
- A. Handel
- B. Telemann
- C. Buxtehude
- D. J. S. Bach  ✅

**97. What is 'through-composed' music?**
- A. Music with a strict repeating structure like ABA
- B. Music that does not repeat sections, developing continuously from beginning to end without returning to earlier material  ✅
- C. Music composed for a film score from start to finish
- D. An improvised form of jazz

**98. Which 20th-century composer developed the idea of 'chance music' or 'aleatoric music'?**
- A. Pierre Boulez
- B. Karlheinz Stockhausen
- C. John Cage  ✅
- D. Edgard Varèse

**99. What is the 'Neapolitan chord' (♭II) and where is it typically found?**
- A. A major chord built on the flattened second degree, typically appearing before a dominant or cadential 6/4  ✅
- B. A minor chord a semitone above the tonic
- C. A dominant seventh chord unique to Italian opera
- D. A secondary dominant borrowed from a parallel major key

**100. What is 'isometry' between rhythm and melody in medieval music?**
- A. Equal spacing of all note values
- B. A technique (isorhythm) where a rhythmic pattern (talea) and melodic pattern (color) repeat independently  ✅
- C. A canon at the unison
- D. A technique of varying the melody while keeping rhythm fixed

**101. Which instrument family uses a bow to vibrate strings and includes the violin, viola, cello and double bass?**
- A. Plucked strings
- B. Keyboard strings
- C. Arco strings
- D. Bowed strings (chordophones)  ✅

**102. What is 'blue note' in jazz and blues theory?**
- A. A note played very quietly
- B. Slightly flattened thirds, fifths or sevenths that add an expressive, melancholic quality not fully in the major or minor scale  ✅
- C. The highest note in a blues scale
- D. A note played with vibrato in jazz improvisation

---

## Fitness (102 questions)

### Easy (34)

**1. Which muscle group is targeted by a squat?**
- A. Chest and shoulders
- B. Back and biceps
- C. Quadriceps, glutes and hamstrings  ✅
- D. Core and abs only

**2. What does 'rep' stand for in weight training?**
- A. Rest
- B. Repetition  ✅
- C. Resistance
- D. Recovery

**3. How many calories are in one gram of carbohydrate?**
- A. 2
- B. 4  ✅
- C. 7
- D. 9

**4. What is the main muscle of the upper arm, often called the 'show muscle'?**
- A. Triceps
- B. Deltoid
- C. Bicep  ✅
- D. Forearm flexor

**5. What type of exercise is running, cycling or swimming?**
- A. Anaerobic
- B. Resistance
- C. Cardiovascular/aerobic  ✅
- D. Isometric

**6. What does BMI stand for?**
- A. Body Mass Index  ✅
- B. Basic Muscle Intensity
- C. Body Mobility Index
- D. Basal Metabolic Intake

**7. Which stretch targets the hamstring at the back of the thigh?**
- A. Quad stretch
- B. Hip flexor stretch
- C. Standing forward fold / hamstring stretch  ✅
- D. Calf stretch

**8. What is a 'set' in weight training?**
- A. One complete exercise movement
- B. A group of repetitions performed consecutively before resting  ✅
- C. A type of warm-up
- D. A measurement of total weight lifted

**9. What does HIIT stand for?**
- A. High Intensity Interval Training  ✅
- B. Heavy Intensity Iron Training
- C. High Impact Isometric Training
- D. Horizontal Incline Interval Technique

**10. Which macro nutrient provides the body's preferred source of energy during exercise?**
- A. Fat
- B. Protein
- C. Carbohydrate  ✅
- D. Fibre

**11. What is the purpose of a 'warm-up' before exercise?**
- A. To exhaust muscles before working them hard
- B. To gradually increase heart rate, blood flow and muscle temperature to prepare the body  ✅
- C. To stretch cold muscles as far as possible
- D. To reduce the need for cool-down afterwards

**12. How many grams of protein are in one gram of dietary protein?**
- A. 4
- B. 7
- C. 9
- D. 1 — it is already protein  ✅

**13. Which exercise is performed lying on your back, pushing a bar upward?**
- A. Deadlift
- B. Row
- C. Bench press  ✅
- D. Shoulder press

**14. What does 'core' refer to in fitness?**
- A. Only the six-pack abs
- B. The muscles of the abdomen, lower back, hips and pelvis that stabilise the spine  ✅
- C. The chest muscles
- D. The leg muscles

**15. Which vitamin is produced by the body through sunlight exposure?**
- A. Vitamin A
- B. Vitamin C
- C. Vitamin D  ✅
- D. Vitamin E

**16. What is a 'plank' exercise?**
- A. A lying back extension
- B. An isometric exercise holding a push-up position on forearms or hands  ✅
- C. A side-lying leg raise
- D. A standing core rotation

**17. What is the recommended number of steps per day often cited for general health?**
- A. 2,000
- B. 5,000
- C. 10,000  ✅
- D. 15,000

**18. Which muscle group is targeted by a pull-up?**
- A. Chest and triceps
- B. Legs and glutes
- C. Shoulder and traps
- D. Back (latissimus dorsi) and biceps  ✅

**19. What is 'resting heart rate'?**
- A. Heart rate during intense exercise
- B. Heart rate immediately after a run
- C. Heart rate when fully at rest, typically measured in the morning  ✅
- D. The maximum heart rate you can achieve

**20. How many hours of sleep per night is commonly recommended for adults?**
- A. 5–6
- B. 6–7
- C. 7–9  ✅
- D. 9–11

**21. What does 'flexibility' refer to in fitness?**
- A. How much weight you can lift
- B. The range of motion available at a joint  ✅
- C. Cardiovascular endurance
- D. Muscular strength

**22. What is the large muscle at the back of your lower leg called?**
- A. Quadriceps
- B. Hamstring
- C. Tibialis
- D. Calf (gastrocnemius)  ✅

**23. What type of training involves lifting weights or using resistance to build muscle?**
- A. Cardio training
- B. Strength/resistance training  ✅
- C. Mobility training
- D. Yoga

**24. Which exercise involves lowering your body and pushing back up with your arms?**
- A. Sit-up
- B. Pull-up
- C. Lunge
- D. Push-up  ✅

**25. What is 'overtraining'?**
- A. Training with too heavy a weight
- B. Training too frequently without enough recovery, leading to performance decline and injury risk  ✅
- C. Warming up for too long
- D. Using improper form

**26. What does a 'cool-down' after exercise help with?**
- A. Building more muscle immediately after the workout
- B. Gradually lowering heart rate and preventing blood pooling in the legs  ✅
- C. Increasing flexibility permanently
- D. Replenishing glycogen stores

**27. What is the largest muscle in the human body?**
- A. Hamstring
- B. Quadriceps
- C. Gluteus maximus  ✅
- D. Latissimus dorsi

**28. What does 'aerobic' exercise mean?**
- A. Exercise without oxygen use
- B. Short-burst, high-intensity activity
- C. Exercise that requires oxygen and uses the aerobic energy system over a sustained period  ✅
- D. Exercise done in water

**29. Which exercise is a fundamental leg movement where you step forward and lower your back knee?**
- A. Squat
- B. Deadlift
- C. Lunge  ✅
- D. Leg press

**30. What is the purpose of stretching after exercise?**
- A. To build muscle faster
- B. To aid recovery, reduce muscle tightness and maintain or improve flexibility  ✅
- C. To burn more calories post-workout
- D. To prevent all future injury

**31. What is 'VO2 max'?**
- A. Maximum weight a person can lift
- B. The maximum rate at which the body can consume oxygen during exercise  ✅
- C. The optimal training heart rate
- D. A measure of resting metabolism

**32. Which mineral is most important for muscle contraction, including the heart?**
- A. Iron
- B. Calcium  ✅
- C. Magnesium
- D. Potassium

**33. What does 'compound exercise' mean?**
- A. An exercise using only machines
- B. An exercise that works multiple muscle groups and joints simultaneously  ✅
- C. An exercise using body weight only
- D. An exercise repeated in quick succession

**34. What is the purpose of a 'spotter' in weight training?**
- A. To count your repetitions
- B. To assist and ensure safety during a heavy lift  ✅
- C. To correct your form remotely
- D. To time your rest periods


### Medium (34)

**35. What is 'muscle hypertrophy'?**
- A. Muscle fatigue caused by lactic acid
- B. The growth of muscle fibres in size through resistance training  ✅
- C. The increase in muscle nerve efficiency
- D. Loss of muscle mass through inactivity

**36. What does the FITT principle stand for?**
- A. Frequency, Intensity, Time, Type  ✅
- B. Force, Interval, Tension, Training
- C. Fitness, Intensity, Target, Technique
- D. Frequency, Isometrics, Tempo, Training

**37. What is the difference between 'myofibrillar' and 'sarcoplasmic' hypertrophy?**
- A. One is fast-twitch; one is slow-twitch growth
- B. Myofibrillar grows contractile proteins (strength); sarcoplasmic increases fluid and energy stores (size/endurance)  ✅
- C. One is upper body; one is lower body adaptation
- D. They describe the same process in different muscle groups

**38. What is 'progressive overload'?**
- A. Progressively reducing rest periods only
- B. Gradually increasing training stimulus (weight, volume, intensity) over time to continue triggering adaptation  ✅
- C. Changing exercises every session
- D. Alternating between heavy and light weeks indefinitely

**39. What is the role of 'glycogen' in exercise performance?**
- A. It provides structural support to muscle tissue
- B. Stored form of carbohydrate in muscles and liver, the primary fuel for high-intensity exercise  ✅
- C. It lubricates the joints during activity
- D. It is the fat burned during low-intensity steady-state exercise

**40. What does 'RPE' stand for and how is it used?**
- A. Rate of Perceived Effort — a subjective 1–10 scale of how hard exercise feels  ✅
- B. Repetition to Peak Exhaustion
- C. Rate of Physical Exertion measured by heart rate
- D. Rest Period Evaluation for recovery planning

**41. What is 'lactate threshold' and why does it matter for endurance athletes?**
- A. The point at which muscles begin producing lactic acid at all
- B. The intensity at which lactate accumulates in the blood faster than it can be cleared, marking the upper limit of sustainable effort  ✅
- C. The maximum sprint speed of an athlete
- D. The point of full glycogen depletion

**42. What is the 'mind-muscle connection'?**
- A. The neural efficiency of lifting a maximum weight
- B. Consciously focusing attention on the target muscle during an exercise to improve activation and effectiveness  ✅
- C. The psychological motivation to train consistently
- D. The connection between sleep quality and muscle growth

**43. How many calories are in one gram of fat?**
- A. 4
- B. 5
- C. 7
- D. 9  ✅

**44. What is 'EPOC' (Excess Post-Exercise Oxygen Consumption)?**
- A. The oxygen debt before a warm-up
- B. The elevated metabolic rate after intense exercise as the body restores itself to resting state, commonly called 'afterburn'  ✅
- C. The maximum oxygen uptake during peak exercise
- D. The breathing rate drop after a cool-down

**45. What is a 'compound lift' in powerlifting?**
- A. Any lift using a barbell only
- B. Multi-joint exercises like squat, bench press and deadlift  ✅
- C. A lift performed in a circuit
- D. Two exercises performed back to back

**46. What does 'concentric' mean in a muscle contraction?**
- A. Muscle lengthening under load (e.g. lowering a weight)
- B. Muscle shortening under load (e.g. the curl-up phase of a bicep curl)  ✅
- C. A static contraction with no movement
- D. A rapid, explosive contraction

**47. What is 'periodisation' in training?**
- A. Tracking workouts in a training diary
- B. Structuring training into phases (e.g. hypertrophy, strength, power) over weeks or months to optimise adaptation and peak performance  ✅
- C. Resting for one day in every seven
- D. Alternating cardio and strength sessions

**48. Which energy system provides ATP for very short, explosive efforts of up to ~10 seconds?**
- A. Aerobic/oxidative system
- B. Glycolytic system
- C. Phosphocreatine (ATP-PCr) system  ✅
- D. Beta-oxidation system

**49. What is 'deload week' in strength training?**
- A. A week of complete rest from all exercise
- B. A planned reduction in training volume and/or intensity to allow recovery and supercompensation  ✅
- C. A week of higher volume to shock the muscles
- D. A nutrition strategy of reduced calories

**50. What is the function of the rotator cuff?**
- A. To flex and extend the knee
- B. To stabilise the shoulder joint and rotate the arm  ✅
- C. To support the lumbar spine
- D. To control hip external rotation

**51. What is 'proprioception' and why is it important for athletes?**
- A. The ability to sense pain in muscles after training
- B. The body's sense of its own position and movement in space, crucial for balance, coordination and injury prevention  ✅
- C. The speed of nerve signal transmission
- D. The ratio of fast-twitch to slow-twitch muscle fibres

**52. What is an 'isometric' contraction?**
- A. A muscle contraction where the muscle lengthens
- B. A contraction where the muscle exerts force without changing length, like holding a position  ✅
- C. A high-speed explosive contraction
- D. A contraction involving two opposing muscle groups

**53. What is 'super-compensation' in training theory?**
- A. A technique of eating twice normal calories after a race
- B. The process where fitness rises above the original baseline during recovery after a training stimulus, if timed correctly  ✅
- C. Combining strength and cardio into one session
- D. Training through injury to maintain fitness

**54. What is 'time under tension' (TUT) and how does it affect training?**
- A. The total time spent at the gym
- B. The total time a muscle is under load during a set; longer TUT can increase hypertrophy stimulus  ✅
- C. The rest period between sets
- D. The time taken to complete a full training programme

**55. What does the 'posterior chain' refer to?**
- A. The frontal muscles of the body
- B. The muscles running along the back of the body: glutes, hamstrings, erector spinae and upper back  ✅
- C. The hip flexors and quadriceps
- D. Only the upper back and traps

**56. What is 'plyometric' training?**
- A. Slow, controlled muscle lengthening exercises
- B. Explosive, jump-based exercises that use the stretch-shortening cycle to develop power  ✅
- C. Resistance training with resistance bands only
- D. Training in water to reduce joint impact

**57. What is 'functional fitness'?**
- A. Only Olympic lifting and powerlifting
- B. Training that mimics everyday movements to improve performance in daily activities and reduce injury risk  ✅
- C. Exercise using only body weight
- D. Sport-specific conditioning for athletes only

**58. What is 'sarcopenia'?**
- A. Excessive fat stored in muscle tissue
- B. The age-related loss of muscle mass and strength  ✅
- C. Inflammation of the muscle fascia
- D. Overuse injury of tendons

**59. What macro percentage split is typical in a standard athletic diet?**
- A. 70% fat, 20% protein, 10% carbs
- B. 50–60% carbs, 20–30% protein, 20–30% fat  ✅
- C. 90% protein, 5% carbs, 5% fat
- D. 60% fat, 30% protein, 10% carbs

**60. Which training method involves exercising at 60–70% max heart rate for fat oxidation?**
- A. HIIT
- B. Sprint intervals
- C. Tempo training
- D. Zone 2 / low-intensity steady-state cardio  ✅

**61. What is 'ankle mobility' and why does it affect squatting?**
- A. Ankle strength for calf raises
- B. The range of dorsiflexion at the ankle; limited mobility forces the heel to lift or the torso to lean excessively in a squat  ✅
- C. The speed of ankle joint rotation
- D. The flexibility of the plantar fascia

**62. What is the primary energy substrate used during low-intensity, long-duration cardio?**
- A. Muscle glycogen
- B. Phosphocreatine
- C. Fat (fatty acids via beta-oxidation)  ✅
- D. Blood glucose from carbohydrates

**63. What is 'eccentric' muscle contraction?**
- A. Muscle shortening under load
- B. Muscle lengthening under load, like lowering a dumbbell slowly  ✅
- C. Muscle contraction with no joint movement
- D. An explosive concentric movement

**64. What does 'DOMS' stand for and when does it typically peak?**
- A. Daily Overuse Muscle Soreness, immediately post-exercise
- B. Delayed Onset Muscle Soreness, peaking 24–72 hours after exercise  ✅
- C. Deep Oxygen Metabolic Stress, within 6 hours
- D. Duration-based Overload Muscle Strain, within 12 hours

**65. Which protein is responsible for muscle contraction at the cellular level?**
- A. Collagen
- B. Keratin
- C. Actin and myosin  ✅
- D. Elastin

**66. What is a 'training max' in powerlifting programming?**
- A. The maximum weight ever attempted
- B. A percentage of your true one-rep max (often 90%) used as the base for programme calculations to manage fatigue  ✅
- C. The heaviest warm-up weight
- D. The weight used on the final working set

**67. What is 'cross-training' in the context of sport?**
- A. Training only the opposite side of the body
- B. Engaging in a variety of different sports or exercise types to complement primary sport training and reduce overuse injury  ✅
- C. Competing in two sports simultaneously
- D. Training purely with resistance bands

**68. What is the 'hip hinge' movement pattern and which exercises use it?**
- A. Any exercise that bends the hip forward
- B. A movement where the hips push back while the torso hinges forward with a neutral spine, fundamental to deadlifts and Romanian deadlifts  ✅
- C. A lateral hip movement for glute activation
- D. Any squat variation with a wide stance


### Hard (34)

**69. What is the 'sliding filament theory' of muscle contraction?**
- A. Muscles lengthen when calcium is released
- B. Myosin heads bind to actin, pulling the thin filaments toward the centre of the sarcomere, shortening it using ATP  ✅
- C. Muscle fibres slide over tendons during movement
- D. ATP directly elongates muscle fibres during relaxation

**70. What is the 'Henneman size principle' in motor unit recruitment?**
- A. Larger motor units are always recruited first
- B. Motor units are recruited from smallest (slow-twitch) to largest (fast-twitch) as force demands increase  ✅
- C. All motor units fire simultaneously during maximal effort
- D. Fast-twitch fibres are only recruited during eccentric contractions

**71. What is the difference between Type I and Type II muscle fibres?**
- A. Type I are fast-twitch, high-force; Type II are slow-twitch, endurance
- B. Type I are slow-twitch, fatigue-resistant, aerobic; Type II are fast-twitch, powerful, fatigue quickly  ✅
- C. Type I are in the legs; Type II are in the upper body
- D. Type I respond to strength training; Type II to endurance training

**72. What is 'metabolic flexibility' in exercise physiology?**
- A. The ability to run at a wide range of speeds
- B. The body's capacity to efficiently switch between carbohydrate and fat as fuel sources depending on availability and intensity  ✅
- C. The range of exercises a person can perform safely
- D. Adaptability of the cardiovascular system to different training loads

**73. What is 'reactive strength index' (RSI) and how is it measured?**
- A. Peak force divided by time to peak force
- B. Jump height divided by ground contact time, measuring an athlete's ability to rapidly transition from landing to take-off  ✅
- C. Maximum power output divided by body mass
- D. Maximum heart rate divided by lactate threshold heart rate

**74. What does 'muscle pennation angle' determine?**
- A. The angle at which a muscle inserts into a joint
- B. The angle of muscle fibres relative to the line of action; greater pennation allows more fibres per area (more force), but less shortening velocity  ✅
- C. The degree of flexibility at a given joint
- D. The ratio of muscle to tendon length

**75. What is 'rate coding' in neuromuscular physiology?**
- A. The speed at which a muscle rebuilds after damage
- B. The frequency at which a motor neuron fires action potentials, increasing force output as firing rate rises  ✅
- C. The recruitment order of motor units
- D. The speed of nerve conduction velocity to a muscle

**76. What is the 'stretch-shortening cycle' (SSC)?**
- A. A cool-down stretching protocol
- B. The sequence of eccentric loading followed immediately by concentric action, storing and releasing elastic energy to produce more force than concentric alone  ✅
- C. A plyometric programme design model
- D. The alternation between flexibility and strength in periodisation

**77. What is 'phosphocreatine resynthesis rate' and why does it matter for repeated sprints?**
- A. How fast glycogen restores after a sprint
- B. The rate at which creatine phosphate is rebuilt from creatine and ATP during recovery, determining readiness for subsequent maximal efforts  ✅
- C. The speed at which lactic acid is cleared from the blood
- D. The time required for full mitochondrial recovery

**78. What is 'tendon stiffness' and how does it affect force transmission?**
- A. Tendons that are more likely to snap under load
- B. Stiffer tendons transmit force more rapidly from muscle to bone, beneficial for power and reactive movements, but may increase injury risk  ✅
- C. Tendon flexibility required for full range of motion
- D. A pathological condition in Achilles tendons

**79. What does 'mitochondrial biogenesis' mean in exercise adaptation?**
- A. Mitochondria repairing after damage
- B. The creation of new mitochondria within cells in response to endurance training, increasing aerobic capacity  ✅
- C. The destruction of mitochondria during overtraining
- D. Mitochondria doubling in size during strength training

**80. What is 'anabolic signalling' and which pathways are most relevant to muscle growth?**
- A. Hormones that cause fat loss
- B. Molecular pathways (especially mTOR) activated by resistance exercise and protein intake that stimulate muscle protein synthesis  ✅
- C. The inflammatory cascade after muscle damage
- D. Neural signalling that controls motor unit recruitment

**81. What is 'cardiac hypertrophy' in athletes and how does it differ from pathological hypertrophy?**
- A. Both are dangerous enlargements of the heart
- B. Athletic hypertrophy ('athlete's heart') involves proportional enlargement of chambers and walls, improving cardiac output; pathological enlarges walls disproportionately, impairing function  ✅
- C. Athlete's heart reduces stroke volume; pathological increases it
- D. There is no measurable difference on an ECG

**82. What is 'respiratory exchange ratio' (RER) and what does an RER of 1.0 indicate?**
- A. Breathing rate; 1.0 means maximum breathing
- B. The ratio of CO2 produced to O2 consumed; RER of 1.0 indicates predominant carbohydrate oxidation  ✅
- C. The ratio of inhalation to exhalation; 1.0 means balanced breathing
- D. Oxygen saturation of the blood; 1.0 means 100% saturation

**83. What is 'blood flow restriction' (BFR) training and its evidence base?**
- A. Wearing compression garments during heavy lifting
- B. Applying a cuff to restrict venous outflow while allowing arterial inflow, enabling hypertrophy and strength gains at low loads  ✅
- C. Restricting breathing to train at altitude
- D. Using cold-water immersion after training to restrict inflammation

**84. What is the 'general adaptation syndrome' (GAS) proposed by Hans Selye?**
- A. A list of common sports injuries
- B. The body's three-stage response to stress: alarm, resistance and exhaustion — foundational to periodisation  ✅
- C. The hormonal response to overtraining
- D. A scale of recovery needs based on training volume

**85. What is 'relative energy deficiency in sport' (RED-S)?**
- A. Low blood sugar during a marathon
- B. A condition of insufficient energy availability to support athlete health and performance, affecting hormone function, bone density and immunity  ✅
- C. Electrolyte imbalance during ultra-endurance events
- D. Dehydration-related performance decline

**86. What does 'mTOR' stand for and what is its role in muscle building?**
- A. Muscle Tissue Oxidation Receptor — triggers fat burning
- B. Mechanistic Target of Rapamycin — a key signalling protein that integrates nutrient and exercise signals to stimulate muscle protein synthesis  ✅
- C. Motor Threshold Output Rate — measures neural drive to muscles
- D. Mitochondrial Transfer and Output Regulator

**87. What is 'net muscle protein balance' and what determines it?**
- A. Total daily protein intake
- B. The difference between muscle protein synthesis (MPS) and muscle protein breakdown (MPB); positive balance over time leads to hypertrophy  ✅
- C. Protein remaining in the blood after digestion
- D. The ratio of essential to non-essential amino acids consumed

**88. What is 'altitude training' and the physiological mechanism behind its performance benefits?**
- A. Training in a hot environment to simulate altitude
- B. Training at high elevation where lower oxygen partial pressure stimulates EPO production, increasing red blood cell count and oxygen-carrying capacity  ✅
- C. Using a hyperbaric chamber for accelerated recovery
- D. Performing breath-hold training to increase lung capacity

**89. What is 'fascial tissue' and its role in movement?**
- A. A type of muscle fibre that only activates under maximal load
- B. Connective tissue surrounding and connecting muscles, contributing to force transmission, proprioception and structural integrity  ✅
- C. The protective cartilage layer in major joints
- D. The synovial fluid layer between muscle groups

**90. What is 'foam rolling' thought to achieve mechanically?**
- A. Breaking up scar tissue between muscle fibres
- B. Applying pressure to increase blood flow, temporarily decrease stiffness and stimulate mechanoreceptors to reduce perceived tightness  ✅
- C. Stretching the muscle length through myofascial release
- D. Increasing muscle cross-sectional area through compression

**91. What is the 'force-velocity relationship' in muscle physiology?**
- A. Force increases as contraction velocity increases
- B. There is an inverse relationship: muscles produce maximum force at low speeds and less force at high speeds  ✅
- C. Force and velocity are unrelated in submaximal contractions
- D. Force is constant regardless of velocity

**92. What is 'immunosuppression' post-exercise and why does it matter?**
- A. Exercise permanently weakens the immune system
- B. Heavy exercise temporarily depresses immune function (especially in an 'open window' after intense exercise), increasing susceptibility to upper respiratory infections  ✅
- C. Strength training suppresses white blood cell production
- D. The immune system only activates during illness, not exercise

**93. What is 'concurrent training interference'?**
- A. The difficulty of combining two different diets simultaneously
- B. The potential for endurance training to blunt strength/hypertrophy adaptations when both are performed in the same programme  ✅
- C. Performing two different strength exercises in the same session
- D. The hormonal conflict between morning and evening training sessions

**94. What is 'neural adaptation' in the early stages of resistance training?**
- A. The growth of muscle fibres in the first few weeks
- B. Improvements in strength driven by better motor unit recruitment, firing rate and inter-muscular coordination before significant muscle mass is gained  ✅
- C. The brain's adjustment to pain signals from DOMS
- D. An increase in nerve myelination for faster signal conduction

**95. What is 'energy flux' in exercise metabolism?**
- A. The total daily calorie intake
- B. The rate at which energy is both consumed and expended, relevant to metabolic health and fat oxidation independent of net calorie balance  ✅
- C. The conversion of ATP to ADP during contraction
- D. The speed at which glycogen is converted to glucose

**96. What is the 'acute:chronic workload ratio' (ACWR) used for in sports science?**
- A. Measuring daily calorie needs
- B. A tool comparing recent training load (acute) to longer-term load (chronic) to identify injury risk when spikes occur  ✅
- C. Setting strength training percentages
- D. Calculating rest between competitions

**97. What is 'eccentric overload training' and what specific adaptations does it target?**
- A. Training with heavier eccentric loads than the muscle can lift concentrically, building tendon stiffness, muscle strength and reducing injury risk  ✅
- B. Training only the eccentric phase of a movement using assistants to lift the weight
- C. Lowering weight as slowly as possible to maximise time under tension only
- D. A deload technique that uses lighter loads in the eccentric phase

**98. What is 'heat acclimation' and what physiological changes does it produce?**
- A. A technique of training in cold environments to increase calorie burn
- B. Adapting to exercising in heat, producing increased plasma volume, lower core temperature at rest, earlier sweating and improved performance in hot conditions  ✅
- C. Using a sauna only after training for recovery
- D. Training in the warmest part of the day to maximise fat burning

**99. What is 'muscle architecture' and how does fascicle length affect performance?**
- A. The gross shape and visual appearance of a muscle
- B. The internal arrangement of muscle fibres; longer fascicles favour speed/power (more sarcomeres in series) while greater pennation favours force (more fibres in parallel)  ✅
- C. The position of a muscle on the skeleton
- D. The ratio of fast to slow twitch fibres in a muscle

**100. What is 'oxidative stress' in exercise physiology?**
- A. Breathing difficulty during maximal effort
- B. An imbalance between reactive oxygen species production and antioxidant defences, occurring during intense exercise and acting as a training signal but potentially damaging at excessive levels  ✅
- C. The process by which fat is oxidised for fuel
- D. Muscle acidosis caused by lactate accumulation

**101. What is the 'repeated bout effect' in exercise?**
- A. Performing more reps each session due to progressive overload
- B. The reduced muscle damage and soreness experienced in subsequent bouts of exercise following an initial damaging session, due to rapid neuromuscular and structural adaptation  ✅
- C. The plateau effect experienced after months of consistent training
- D. Performing the same workout repeatedly without variation

**102. What is 'overreaching' and how does it differ from overtraining?**
- A. They are the same thing
- B. Overreaching is a short-term accumulation of training load causing temporary performance decline that reverses with recovery; overtraining is a prolonged, pathological state requiring weeks or months to resolve  ✅
- C. Overtraining is planned; overreaching is accidental
- D. Overreaching only affects elite athletes; overtraining affects recreational athletes

---

## Science (102 questions)

### Easy (34)

**1. What is the chemical formula for water?**
- A. H2O2
- B. HO2
- C. H2O  ✅
- D. H3O

**2. What planet is known as the Red Planet?**
- A. Venus
- B. Jupiter
- C. Mars  ✅
- D. Saturn

**3. What is the force that pulls objects toward Earth?**
- A. Magnetism
- B. Friction
- C. Gravity  ✅
- D. Centripetal force

**4. How many bones are in the adult human body?**
- A. 196
- B. 206  ✅
- C. 216
- D. 226

**5. What is the boiling point of water at sea level in degrees Celsius?**
- A. 90°C
- B. 95°C
- C. 100°C  ✅
- D. 105°C

**6. What gas do plants absorb from the air during photosynthesis?**
- A. Oxygen
- B. Nitrogen
- C. Carbon dioxide  ✅
- D. Hydrogen

**7. What is the closest star to Earth?**
- A. Proxima Centauri
- B. Sirius
- C. Betelgeuse
- D. The Sun  ✅

**8. What is the symbol for gold on the periodic table?**
- A. Go
- B. Gd
- C. Ag
- D. Au  ✅

**9. What is the powerhouse of the cell?**
- A. Nucleus
- B. Ribosome
- C. Mitochondria  ✅
- D. Golgi apparatus

**10. Which planet is largest in our solar system?**
- A. Saturn
- B. Uranus
- C. Neptune
- D. Jupiter  ✅

**11. What is the speed of light in a vacuum (approximately)?**
- A. 300 km/s
- B. 3,000 km/s
- C. 300,000 km/s  ✅
- D. 3,000,000 km/s

**12. What is the chemical symbol for iron?**
- A. Ir
- B. Fe  ✅
- C. In
- D. Fo

**13. How many planets are in our solar system?**
- A. 7
- B. 8  ✅
- C. 9
- D. 10

**14. What is the study of living organisms called?**
- A. Chemistry
- B. Physics
- C. Biology  ✅
- D. Geology

**15. What is the atomic number of hydrogen?**
- A. 1  ✅
- B. 2
- C. 3
- D. 4

**16. What is the freezing point of water in degrees Celsius?**
- A. -10°C
- B. -5°C
- C. 0°C  ✅
- D. 5°C

**17. Which organ pumps blood around the body?**
- A. Lungs
- B. Kidney
- C. Liver
- D. Heart  ✅

**18. What is the name of the process by which plants make food using sunlight?**
- A. Respiration
- B. Transpiration
- C. Photosynthesis  ✅
- D. Fermentation

**19. What type of rock is formed from cooled lava?**
- A. Sedimentary
- B. Metamorphic
- C. Igneous  ✅
- D. Fossil

**20. Which element has the chemical symbol 'O'?**
- A. Gold
- B. Osmium
- C. Oxygen  ✅
- D. Oganesson

**21. What is the unit of electrical resistance?**
- A. Volt
- B. Ampere
- C. Watt
- D. Ohm  ✅

**22. What is the name of the force that opposes motion between surfaces?**
- A. Gravity
- B. Drag
- C. Friction  ✅
- D. Tension

**23. Which scientist developed the theory of evolution by natural selection?**
- A. Gregor Mendel
- B. Louis Pasteur
- C. Isaac Newton
- D. Charles Darwin  ✅

**24. How many chambers does the human heart have?**
- A. 2
- B. 3
- C. 4  ✅
- D. 5

**25. What gas makes up approximately 78% of Earth's atmosphere?**
- A. Oxygen
- B. Carbon dioxide
- C. Argon
- D. Nitrogen  ✅

**26. What is the name of the instrument used to measure temperature?**
- A. Barometer
- B. Thermometer  ✅
- C. Hygrometer
- D. Altimeter

**27. Which planet is closest to the Sun?**
- A. Venus
- B. Mars
- C. Mercury  ✅
- D. Earth

**28. What is DNA an abbreviation for?**
- A. Deoxyribonucleic acid  ✅
- B. Disodium nucleotide array
- C. Dynamic neuron aggregate
- D. Dioxynuclear amino acid

**29. What is the most abundant gas in Earth's atmosphere?**
- A. Oxygen
- B. Argon
- C. Carbon dioxide
- D. Nitrogen  ✅

**30. Which organ in the human body produces insulin?**
- A. Liver
- B. Kidney
- C. Pancreas  ✅
- D. Adrenal gland

**31. What is the name of the layer of gases surrounding Earth?**
- A. Hydrosphere
- B. Biosphere
- C. Lithosphere
- D. Atmosphere  ✅

**32. What is the symbol for carbon on the periodic table?**
- A. Ca
- B. Co
- C. Cr
- D. C  ✅

**33. What is the unit of force in the SI system?**
- A. Joule
- B. Watt
- C. Newton  ✅
- D. Pascal

**34. Which planet has a ring system most famously visible from Earth?**
- A. Jupiter
- B. Uranus
- C. Neptune
- D. Saturn  ✅


### Medium (34)

**35. What is Newton's Second Law of Motion?**
- A. Every action has an equal and opposite reaction
- B. An object in motion stays in motion unless acted upon
- C. Force equals mass times acceleration (F=ma)  ✅
- D. Energy is neither created nor destroyed

**36. What is the 'half-life' of a radioactive substance?**
- A. The time for its radiation to become harmless
- B. The time for half of the radioactive nuclei in a sample to decay  ✅
- C. Half the time it takes to fully decay
- D. The time for radiation to travel halfway through a material

**37. What is the difference between 'mitosis' and 'meiosis'?**
- A. Mitosis produces sex cells; meiosis produces body cells
- B. Mitosis produces two genetically identical daughter cells; meiosis produces four genetically diverse gametes  ✅
- C. They are the same process in different organisms
- D. Mitosis occurs only in plants; meiosis only in animals

**38. What is Avogadro's number and what does it represent?**
- A. 6.022 × 10²³ — the number of particles (atoms or molecules) in one mole of a substance  ✅
- B. 1.381 × 10⁻²³ — Boltzmann's constant
- C. 6.674 × 10⁻¹¹ — the gravitational constant
- D. 9.109 × 10⁻³¹ — the mass of an electron

**39. What is the 'Doppler effect'?**
- A. The bending of light around a gravitational mass
- B. The change in observed frequency of a wave due to relative motion between the source and observer  ✅
- C. The scattering of light by particles in the atmosphere
- D. The interference pattern of waves passing through a slit

**40. What distinguishes an acid from a base on the pH scale?**
- A. Acids have pH above 7; bases below 7
- B. Acids have pH below 7; bases have pH above 7  ✅
- C. Acids are always liquid; bases are always solid
- D. Acids contain oxygen; bases contain nitrogen

**41. What is the 'double helix' structure of DNA?**
- A. DNA is a single strand coiled around proteins
- B. Two antiparallel polynucleotide strands twisted into a helical shape, held by hydrogen bonds between complementary base pairs  ✅
- C. DNA forms a triple helix in all organisms
- D. The double helix refers to two separate DNA molecules side by side

**42. What is Ohm's Law?**
- A. Power = Current × Voltage
- B. Voltage = Current × Resistance  ✅
- C. Current = Voltage × Resistance
- D. Resistance = Power ÷ Current

**43. What is 'plate tectonics'?**
- A. The theory that Earth's crust is divided into moving plates that shape continents, mountains and volcanic activity  ✅
- B. The study of earthquake wave patterns
- C. The process of rock formation from cooling magma
- D. A theory about the movement of ocean currents

**44. What is the 'greenhouse effect'?**
- A. The warming caused by sunlight entering greenhouses
- B. The trapping of heat in Earth's atmosphere by gases like CO2 that absorb and re-emit infrared radiation  ✅
- C. The reflection of sunlight by ice caps
- D. The cooling effect of clouds blocking sunlight

**45. What is 'oxidation' in chemistry?**
- A. Gaining electrons or increasing oxidation state; losing hydrogen or gaining oxygen  ✅
- B. Adding water to a compound
- C. Breaking a covalent bond with heat
- D. Losing protons in an acid-base reaction

**46. What is the 'uncertainty principle', formulated by Heisenberg?**
- A. All measurements contain some experimental error
- B. The more precisely you know a particle's position, the less precisely you can know its momentum, and vice versa  ✅
- C. Quantum particles are never at rest
- D. The speed of light is constant regardless of observer

**47. How does a vaccine work?**
- A. It directly kills the pathogen in the body
- B. It introduces a harmless antigen that trains the immune system to recognise and respond to a pathogen  ✅
- C. It provides antibodies directly from another organism
- D. It raises body temperature to kill viruses

**48. What is the 'central dogma of molecular biology'?**
- A. DNA is the universal blueprint for all life
- B. Genetic information flows from DNA to RNA to protein  ✅
- C. Proteins control gene expression directly
- D. RNA is the original molecule of life

**49. What is 'nuclear fission'?**
- A. The fusion of two light atomic nuclei to release energy
- B. The splitting of a heavy atomic nucleus into smaller nuclei, releasing large amounts of energy  ✅
- C. The decay of radioactive nuclei over time
- D. The capture of neutrons by a stable nucleus

**50. What is the 'Big Bang theory'?**
- A. The universe was created by a deity in an instant
- B. The theory that the universe began approximately 13.8 billion years ago as an extremely hot, dense state and has been expanding ever since  ✅
- C. The theory that the universe has always existed
- D. A theory that galaxies collide to create new stars

**51. What is 'entropy' in thermodynamics?**
- A. The total energy of a system
- B. A measure of disorder or randomness in a system; the Second Law states it increases in an isolated system  ✅
- C. The efficiency of a heat engine
- D. The amount of work a system can do

**52. What is 'CRISPR-Cas9' used for in biology?**
- A. A vaccine delivery system
- B. A gene-editing tool that allows precise modification of DNA sequences  ✅
- C. A protein synthesis accelerator
- D. A technique for cloning whole organisms

**53. What is the 'strong nuclear force'?**
- A. The force that binds electrons to nuclei
- B. The force that holds protons and neutrons together within atomic nuclei, overcoming electromagnetic repulsion  ✅
- C. The force responsible for radioactive decay
- D. The gravitational attraction between neutrons

**54. What is 'osmosis'?**
- A. Active transport of molecules through a membrane
- B. The diffusion of water molecules through a semi-permeable membrane from high to low concentration  ✅
- C. The breakdown of solutes by enzymes
- D. The active movement of ions against a concentration gradient

**55. What distinguishes a 'eukaryotic' cell from a 'prokaryotic' cell?**
- A. Eukaryotes are larger; prokaryotes are smaller — no further difference
- B. Eukaryotic cells have a membrane-bound nucleus and organelles; prokaryotic cells (like bacteria) do not  ✅
- C. Prokaryotes have mitochondria; eukaryotes do not
- D. Eukaryotes reproduce asexually only; prokaryotes sexually

**56. What does 'mass spectrometry' measure?**
- A. The magnetic properties of elements
- B. The mass-to-charge ratio of ions, used to identify chemical compounds and isotopes  ✅
- C. The spectral colour of light emitted by atoms
- D. The density of solids under pressure

**57. What is the 'electromagnetic spectrum'?**
- A. The range of all possible frequencies of electromagnetic radiation, from radio waves to gamma rays  ✅
- B. The full range of visible light colours
- C. The field of charged particles around a magnet
- D. The spectrum of energy released in nuclear fission

**58. What is 'natural selection', the mechanism of evolution?**
- A. Random mutation creating new species instantly
- B. The process by which organisms with heritable traits better suited to the environment reproduce more successfully over generations  ✅
- C. The extinction of weaker species by stronger ones
- D. A species choosing its own adaptive traits over time

**59. What is the 'Krebs cycle'?**
- A. A cycle of water evaporation and rainfall
- B. A metabolic pathway in the mitochondria that generates ATP, CO2 and NADH from acetyl-CoA  ✅
- C. The nitrogen cycle in soil bacteria
- D. A cycle of blood oxygen exchange in the lungs

**60. What is 'black hole' in astrophysics?**
- A. A star that has gone cold and dark
- B. A region of spacetime where gravity is so intense that nothing, including light, can escape  ✅
- C. A gap between galaxies with no matter
- D. A collapsed neutron star that emits X-rays

**61. What is 'surface tension' in liquids?**
- A. The pressure at the bottom of a body of water
- B. The cohesive force at the surface of a liquid that causes it to behave like an elastic sheet  ✅
- C. The friction between a liquid and its container
- D. The boiling threshold of a liquid when heated from below

**62. What is 'redshift' in astronomy?**
- A. Light from approaching objects appearing bluer
- B. The lengthening of light wavelengths from objects moving away from the observer, used to infer the expansion of the universe  ✅
- C. The reddening of stars due to high temperature
- D. Distortion of starlight by a gravitational lens

**63. What is the 'law of conservation of energy'?**
- A. Energy can be created from matter
- B. Energy cannot be created or destroyed, only converted from one form to another  ✅
- C. Energy is always lost as heat in any reaction
- D. The total energy of the universe is zero

**64. What is 'quantum entanglement'?**
- A. Two particles occupying the same quantum state
- B. A phenomenon where two particles are correlated so that measuring one instantly determines the state of the other, regardless of distance  ✅
- C. The vibration of particles in a quantum field
- D. The dual wave-particle nature of light

**65. What is the 'Cambrian explosion'?**
- A. A mass extinction event 540 million years ago
- B. A rapid diversification of complex multicellular animal life approximately 541 million years ago  ✅
- C. The volcanic event that ended the Permian period
- D. The origin of photosynthetic life 2.4 billion years ago

**66. What is 'gel electrophoresis' used for in biology?**
- A. Cooling samples for DNA storage
- B. Separating DNA, RNA or protein fragments by size using an electric current through a gel matrix  ✅
- C. Amplifying specific DNA sequences
- D. Inserting genes into bacterial plasmids

**67. What is 'dark matter'?**
- A. Interstellar dust blocking light from distant stars
- B. Matter hypothesised to account for unexplained gravitational effects in galaxies, not interacting with light and not yet directly detected  ✅
- C. The vacuum energy of empty space
- D. Matter falling into a black hole

**68. What is 'carbon dating' used for?**
- A. Measuring the purity of carbon samples
- B. Dating once-living materials by measuring the decay of carbon-14, accurate to roughly 50,000 years  ✅
- C. Identifying the age of rocks by uranium decay
- D. Testing the carbon content of fossil fuels


### Hard (34)

**69. What is the 'Standard Model' of particle physics?**
- A. The model describing the origin of the universe
- B. The theoretical framework describing the fundamental particles and forces (excluding gravity) that make up the universe  ✅
- C. A model predicting weather patterns using quantum mechanics
- D. The baseline cosmological model of dark matter distribution

**70. What is 'wave-particle duality'?**
- A. The idea that waves and particles are completely different and incompatible
- B. The quantum principle that matter and light exhibit properties of both waves and particles depending on how they are observed  ✅
- C. The dual nature of electromagnetic and gravitational fields
- D. The principle that particles in a wave interfere only when colliding

**71. What is a 'Higgs boson' and what does it do?**
- A. A force-carrying particle responsible for electromagnetism
- B. A particle associated with the Higgs field, which gives other fundamental particles their mass  ✅
- C. A theoretical particle that carries the gravitational force
- D. A particle that mediates the strong nuclear force between quarks

**72. What is 'general relativity' in Einstein's framework?**
- A. The principle that all inertial reference frames are equivalent
- B. A theory of gravity describing it as the curvature of spacetime caused by mass and energy  ✅
- C. The equivalence of mass and energy expressed as E=mc²
- D. The slowing of time for fast-moving objects only

**73. What is the 'Pauli exclusion principle'?**
- A. No two atoms can occupy the same space simultaneously
- B. No two identical fermions can occupy the same quantum state simultaneously, explaining electron shell structure  ✅
- C. Photons cannot interact with each other
- D. A particle's spin and position cannot both be known precisely

**74. What is 'quantum tunnelling'?**
- A. The ability of large particles to pass through any solid
- B. A quantum phenomenon where a particle passes through a barrier it classically could not surmount, due to its wave-like probability distribution  ✅
- C. The transport of electrons through a conductor
- D. The transfer of energy between quantum states in a laser

**75. What is the 'Chandrasekhar limit' in astrophysics?**
- A. The maximum mass of a neutron star
- B. The maximum mass of a white dwarf (~1.4 solar masses) above which electron degeneracy pressure cannot support the star against collapse  ✅
- C. The distance at which a star can form a planetary system
- D. The luminosity threshold at which a star becomes a red giant

**76. What is 'chirality' in chemistry and biology?**
- A. The acidity of a molecule
- B. The property of a molecule that cannot be superimposed on its mirror image, like left and right hands — critical in biochemistry as mirror-image molecules behave differently  ✅
- C. The ability of a molecule to absorb UV light
- D. The symmetry of a crystal lattice

**77. What is the 'second law of thermodynamics' and why is it profound?**
- A. Energy is conserved in all reactions
- B. In an isolated system, entropy always increases or stays constant — implying a direction to time and limiting the efficiency of any process  ✅
- C. Heat naturally flows from cold to hot
- D. Work can be fully converted to heat without loss

**78. What is 'CERN' and its primary scientific goal?**
- A. A European weather prediction centre
- B. The European Organisation for Nuclear Research, operating the Large Hadron Collider to study fundamental particles and forces  ✅
- C. A climate research facility in Switzerland
- D. An astronomical observation network studying dark matter

**79. What is the 'Fermi paradox'?**
- A. The difficulty of measuring quantum particles accurately
- B. The apparent contradiction between the high probability of extraterrestrial civilisations existing and the lack of any evidence or contact  ✅
- C. The exponential growth of computing power described by Moore's Law
- D. The unexpected beta decay of neutrons outside an atomic nucleus

**80. What does 'renormalisation' address in quantum field theory?**
- A. Normalising probability distributions in quantum measurements
- B. A mathematical procedure to remove infinities from physical calculations by absorbing them into observable quantities  ✅
- C. Restoring a quantum system to its ground state
- D. Standardising units across different quantum models

**81. What is a 'neutron star' and what extreme properties does it have?**
- A. A collapsed white dwarf star with no nuclear processes
- B. An extremely dense stellar remnant where protons and electrons have merged into neutrons, with densities matching atomic nuclei  ✅
- C. A star that only emits neutron radiation
- D. A failed black hole held in equilibrium by nuclear forces

**82. What is 'CRISPR' an acronym for?**
- A. Cluster Rapid Integration Sequence Procedure Revision
- B. Clustered Regularly Interspaced Short Palindromic Repeats  ✅
- C. Complex Receptor Integration System for Protein Regulation
- D. Critical RNA Integration and Sequence Repair

**83. What is the 'observer effect' in quantum mechanics?**
- A. Scientists influencing results through wishful thinking
- B. The act of measuring a quantum system disturbs it, collapsing its wavefunction and changing the observed outcome  ✅
- C. Human error introduced during precise measurement
- D. The gravitational influence of measuring equipment on quantum particles

**84. What is 'Hawking radiation'?**
- A. Radiation emitted by neutron stars collapsing into pulsars
- B. Theoretical radiation emitted by black holes due to quantum effects near the event horizon, causing them to slowly lose mass and evaporate  ✅
- C. Radiation produced when matter enters a black hole
- D. Gamma ray bursts from colliding black holes

**85. What is the 'fine-tuned universe' argument in cosmology?**
- A. The universe was designed by an intelligence
- B. The observation that the fundamental constants of nature appear precisely calibrated to permit complex structures and life, raising questions of why this is so  ✅
- C. The universe has a fixed size determined by its initial conditions
- D. The universe's expansion rate was slowed by dark energy at a critical point

**86. What is 'RNA interference' (RNAi)?**
- A. A technique for amplifying DNA sequences in the lab
- B. A biological process where small RNA molecules silence gene expression by binding to and degrading specific mRNA  ✅
- C. The transcription of RNA from a DNA template
- D. The insertion of viral RNA into host cell DNA

**87. What is the 'principle of complementarity' in quantum mechanics (Bohr)?**
- A. Measurements complement each other by reducing total uncertainty
- B. Wave and particle descriptions of a quantum object are mutually exclusive but both necessary for a complete picture  ✅
- C. Complementary forces always cancel exactly
- D. Opposite quantum states are always equally probable

**88. What is 'cosmic inflation' in cosmology?**
- A. The ongoing expansion of the universe driven by dark energy
- B. A period of exponential expansion of the universe in the first fraction of a second after the Big Bang, explaining its uniformity  ✅
- C. The slow cooling of the universe after the Big Bang
- D. The stretching of spacetime caused by dark matter

**89. What is a 'quasar'?**
- A. A type of collapsed star emitting X-rays
- B. An extremely luminous active galactic nucleus powered by accretion of matter onto a supermassive black hole  ✅
- C. A massive star in the early stages of formation
- D. A neutron star emitting regular radio pulses

**90. What is 'epigenetics'?**
- A. The study of genetic mutations caused by the environment
- B. Changes in gene expression that do not involve changes to the DNA sequence, often heritable, driven by factors like methylation and histone modification  ✅
- C. The inherited genetic traits of a species as a whole
- D. The study of gene function across different species

**91. What is the 'photoelectric effect' and why was it significant?**
- A. The heating of a surface by absorbed light
- B. The emission of electrons from a material when it absorbs light of sufficient frequency, explained by Einstein as evidence for the particle nature of light  ✅
- C. The fluorescence of materials under UV radiation
- D. The conversion of light to electricity in photovoltaic cells

**92. What is a 'gravitational wave'?**
- A. A wave of gravitational particles (gravitons) emitted by the sun
- B. A ripple in the curvature of spacetime caused by accelerating masses, predicted by general relativity and first detected in 2015  ✅
- C. The oscillation of tidal forces between two large masses
- D. A standing wave in the gravitational potential of a galaxy

**93. What is the 'hydrophobic effect' in biochemistry?**
- A. The attraction between water molecules and non-polar substances
- B. The tendency of non-polar molecules to cluster together in water to minimise the disruption to water's hydrogen-bond network, driving protein folding and cell membrane formation  ✅
- C. The repulsion of water molecules from ionic substances
- D. The surface tension of water at the interface with oils

**94. What is 'dark energy' and what evidence points to its existence?**
- A. The energy stored in dark matter particles
- B. A hypothetical form of energy causing the observed accelerating expansion of the universe, inferred from distant supernova observations in 1998  ✅
- C. The energy released when matter falls into a black hole
- D. Radiation remaining from the Big Bang detected as the CMB

**95. What is the 'Drake equation'?**
- A. A formula for calculating the probability of life on a planet
- B. A probabilistic formula estimating the number of communicative extraterrestrial civilisations in the galaxy using factors like star formation rate and the fraction of planets with life  ✅
- C. An equation predicting the frequency of gamma ray bursts
- D. A model for calculating the mass of a galaxy from its luminosity

**96. What is 'spontaneous symmetry breaking' in physics?**
- A. A particle breaking apart asymmetrically in a collider
- B. A phenomenon where a system obeying symmetric laws settles into an asymmetric ground state, responsible for particle masses in the Standard Model  ✅
- C. Random particle decay that violates conservation laws
- D. The unequal distribution of matter and antimatter at the Big Bang

**97. What is the 'anthropic principle'?**
- A. All life forms have a common ancestor
- B. The observation that the universe's conditions must be compatible with conscious observers existing to observe them — used to explain why physical constants have the values they do  ✅
- C. Human activity is the primary driver of climate change
- D. Evolution produces intelligence as its inevitable outcome

**98. What is 'Bell's theorem' and its implications?**
- A. A theorem about the Bell curve in statistics
- B. A theorem showing that no local hidden variable theory can reproduce all predictions of quantum mechanics, implying non-locality or the incompleteness of classical descriptions  ✅
- C. A proof that quantum computers are more powerful than classical ones
- D. A theorem about the speed of information transfer in a quantum network

**99. What is the 'Coriolis effect'?**
- A. The deceleration of winds near mountains
- B. The deflection of moving objects (e.g. winds, ocean currents) due to Earth's rotation — to the right in the northern hemisphere, left in the southern  ✅
- C. The effect of gravity on atmospheric pressure with altitude
- D. The circular ocean currents created by the Moon's gravitational pull

**100. What is 'protein folding' and why is it a fundamental problem in biology?**
- A. How proteins are transported across cell membranes
- B. The process by which a protein chain assumes its three-dimensional functional shape; misfolds cause diseases like Alzheimer's; predicting the shape from sequence was a grand challenge in science  ✅
- C. How ribosomes synthesise protein chains from mRNA
- D. The degradation of proteins by proteases in the cell

**101. What is the 'Boltzmann brain' thought experiment?**
- A. A model of the brain using thermodynamic principles
- B. The idea that a self-aware brain spontaneously assembling from random thermal fluctuations is statistically possible given infinite time, posing a cosmological problem  ✅
- C. An experiment to test neural signal transmission rates
- D. Boltzmann's model of intelligence as an emergent property of entropy

**102. What is 'abiogenesis'?**
- A. The evolution of one species into another
- B. The process by which life arose naturally from non-living matter, the subject of origin-of-life research  ✅
- C. The extinction of life through environmental catastrophe
- D. The appearance of life from extraterrestrial sources (panspermia)

---

## Movies (102 questions)

### Easy (34)

**1. Which 1994 film features a box of chocolates and the quote 'Life is like a box of chocolates'?**
- A. Cast Away
- B. The Green Mile
- C. Philadelphia
- D. Forrest Gump  ✅

**2. Which 1997 film starring Leonardo DiCaprio and Kate Winslet became a massive box office hit?**
- A. Titanic  ✅
- B. Romeo + Juliet
- C. The Beach
- D. Inception

**3. What is the name of the toy cowboy in the 'Toy Story' films?**
- A. Buzz
- B. Rex
- C. Woody  ✅
- D. Bo

**4. Which trilogy follows young wizard Harry Potter?**
- A. The Chronicles of Narnia
- B. His Dark Materials
- C. Harry Potter series  ✅
- D. Percy Jackson

**5. Which animated film features the song 'Let It Go' and was set in the kingdom of Arendelle?**
- A. Moana
- B. Brave
- C. Tangled
- D. Frozen  ✅

**6. Who directed the 'Lord of the Rings' film trilogy?**
- A. Steven Spielberg
- B. James Cameron
- C. Peter Jackson  ✅
- D. George Lucas

**7. What is the catchphrase of the character Buzz Lightyear?**
- A. To the stars and beyond!
- B. Reach for the sky!
- C. To infinity and beyond!  ✅
- D. The sky's the limit!

**8. Which superhero wears a suit of armour and is played by Robert Downey Jr.?**
- A. Captain America
- B. Thor
- C. Iron Man  ✅
- D. Black Panther

**9. Which film features the line 'I'll be back'?**
- A. Robocop
- B. The Terminator  ✅
- C. Predator
- D. Total Recall

**10. In 'The Lion King', what is the name of Simba's father?**
- A. Scar
- B. Timon
- C. Rafiki
- D. Mufasa  ✅

**11. Which 1977 sci-fi space epic began a franchise with the words 'A long time ago in a galaxy far, far away'?**
- A. Star Trek
- B. Flash Gordon
- C. 2001: A Space Odyssey
- D. Star Wars  ✅

**12. Who played Jack Sparrow in the 'Pirates of the Caribbean' series?**
- A. Orlando Bloom
- B. Johnny Depp  ✅
- C. Jude Law
- D. Geoffrey Rush

**13. Which 2010 Christopher Nolan film follows a team that enters people's dreams?**
- A. Interstellar
- B. The Prestige
- C. Inception  ✅
- D. Memento

**14. In which film does a clownfish search the ocean for his son 'Nemo'?**
- A. Shark Tale
- B. Finding Dory
- C. Finding Nemo  ✅
- D. The Little Mermaid

**15. Which actress played Katniss Everdeen in 'The Hunger Games'?**
- A. Kristen Stewart
- B. Emma Stone
- C. Jennifer Lawrence  ✅
- D. Shailene Woodley

**16. Which 1993 film by Steven Spielberg depicts dinosaurs escaping in a theme park?**
- A. The Lost World
- B. Jurassic World
- C. Jurassic Park  ✅
- D. Dinosaur

**17. What is the highest-grossing film of all time (unadjusted for inflation)?**
- A. Avengers: Endgame
- B. Avatar (2009)  ✅
- C. Titanic
- D. Top Gun: Maverick

**18. Which film features the line 'You can't handle the truth!'?**
- A. A Few Good Men  ✅
- B. The Firm
- C. JFK
- D. Born on the Fourth of July

**19. Who voiced the character 'Shrek'?**
- A. Eddie Murphy
- B. Antonio Banderas
- C. Mike Myers  ✅
- D. John Lithgow

**20. Which Marvel hero wields a magic hammer called Mjolnir?**
- A. Iron Man
- B. Captain America
- C. Hulk
- D. Thor  ✅

**21. Which 1980 horror film features twins saying 'Come play with us'?**
- A. Poltergeist
- B. Halloween
- C. The Shining  ✅
- D. Carrie

**22. Which 2008 superhero film starred Heath Ledger as the Joker?**
- A. Batman Begins
- B. The Dark Knight  ✅
- C. Batman v Superman
- D. Suicide Squad

**23. What was the first Pixar feature film, released in 1995?**
- A. A Bug's Life
- B. Monsters, Inc.
- C. Toy Story  ✅
- D. Cars

**24. Which actress stars as Clarice Starling in 'The Silence of the Lambs'?**
- A. Sigourney Weaver
- B. Jodie Foster  ✅
- C. Meryl Streep
- D. Glenn Close

**25. In 'The Matrix', what colour pill does Neo choose?**
- A. Blue
- B. Red  ✅
- C. Green
- D. White

**26. Which Bond film introduced the character of 'M' played by Judi Dench?**
- A. GoldenEye  ✅
- B. Tomorrow Never Dies
- C. Casino Royale
- D. The Living Daylights

**27. What animated film features the character WALL-E?**
- A. Up
- B. Ratatouille
- C. WALL-E  ✅
- D. Brave

**28. Which film's theme song begins 'I will always love you', sung by Whitney Houston?**
- A. Dreamgirls
- B. The Bodyguard  ✅
- C. Waiting to Exhale
- D. Sparkle

**29. Which 2001 animated film follows a donkey and an ogre on a quest?**
- A. Madagascar
- B. Shrek  ✅
- C. Spirit
- D. Brother Bear

**30. In 'Home Alone', what is the name of the child left behind?**
- A. Tommy
- B. Billy
- C. Danny
- D. Kevin  ✅

**31. Which actor played Will Hunting in 'Good Will Hunting'?**
- A. Ben Affleck
- B. Damon Wayans
- C. Matt Damon  ✅
- D. Edward Norton

**32. Which film features aliens landing in a cornfield and a baseball field being built?**
- A. Signs
- B. Contact
- C. Field of Dreams  ✅
- D. Close Encounters of the Third Kind

**33. Which 1984 film features a time-travelling DeLorean?**
- A. Ghostbusters
- B. The Terminator
- C. Short Circuit
- D. Back to the Future  ✅

**34. What is the name of the shark in 'Jaws'?**
- A. Bruce  ✅
- B. Jaws
- C. Great White
- D. Fin


### Medium (34)

**35. Who directed 'Schindler's List', 'Jaws' and 'E.T. the Extra-Terrestrial'?**
- A. Martin Scorsese
- B. Francis Ford Coppola
- C. Steven Spielberg  ✅
- D. Stanley Kubrick

**36. Which film won the Academy Award for Best Picture in 1994 (for the 1993 ceremony)?**
- A. Forrest Gump
- B. Pulp Fiction
- C. Schindler's List  ✅
- D. The Shawshank Redemption

**37. What is the name of the technique of editing two simultaneously occurring actions together, alternating between them?**
- A. Montage
- B. Match cut
- C. Cross-cutting  ✅
- D. Jump cut

**38. Which director is known for 'Pulp Fiction', 'Inglourious Basterds' and 'Once Upon a Time in Hollywood'?**
- A. David Fincher
- B. Joel Coen
- C. Quentin Tarantino  ✅
- D. Paul Thomas Anderson

**39. What is the 'MacGuffin' plot device in filmmaking?**
- A. A villain's ultimate weapon
- B. An object or goal that motivates characters but whose exact nature is unimportant to the audience  ✅
- C. The climactic scene of a film
- D. A surprise twist ending

**40. Which 1968 Stanley Kubrick film features HAL 9000?**
- A. Dr. Strangelove
- B. A Clockwork Orange
- C. Barry Lyndon
- D. 2001: A Space Odyssey  ✅

**41. What was the first feature-length animated film produced by Walt Disney Studios?**
- A. Pinocchio
- B. Bambi
- C. Fantasia
- D. Snow White and the Seven Dwarfs  ✅

**42. Which film won the first Academy Award for Best Animated Feature in 2002?**
- A. Monsters, Inc.
- B. Ice Age
- C. Shrek  ✅
- D. Spirited Away

**43. Which film by Elia Kazan stars Marlon Brando as a dock worker with the line 'I coulda been a contender'?**
- A. The Wild One
- B. On the Waterfront  ✅
- C. A Streetcar Named Desire
- D. Last Tango in Paris

**44. What does 'mise en scène' refer to in film studies?**
- A. The film's musical score
- B. Everything visible in the frame: setting, lighting, costumes, blocking and camera placement  ✅
- C. The editing style of a film
- D. The narrative structure of a script

**45. Which Alfred Hitchcock film features the famous shower murder scene?**
- A. Vertigo
- B. Rear Window
- C. North by Northwest
- D. Psycho  ✅

**46. Who played the character Anton Chigurh in 'No Country for Old Men'?**
- A. Daniel Day-Lewis
- B. Tommy Lee Jones
- C. Javier Bardem  ✅
- D. Josh Brolin

**47. Which 1972 Francis Ford Coppola film is widely regarded as one of the greatest films ever made?**
- A. Apocalypse Now
- B. The Conversation
- C. The Godfather  ✅
- D. One from the Heart

**48. What is 'chiaroscuro' in cinematography?**
- A. The use of extreme close-ups for dramatic effect
- B. High-contrast lighting with strong shadows and bright highlights, associated with film noir  ✅
- C. A technique of blurring the background
- D. Handheld camera movement to create tension

**49. Which film introduced the 'bullet time' visual effect?**
- A. Dark City
- B. Blade
- C. The Matrix  ✅
- D. eXistenZ

**50. What does 'non-diegetic sound' mean in film?**
- A. Dialogue recorded on location
- B. Sound like a film score that the characters cannot hear, existing outside the story's world  ✅
- C. Sound effects added in post-production
- D. Ambient sound recorded during filming

**51. Which director made 'Bicycle Thieves' (1948), a foundational work of Italian Neorealism?**
- A. Roberto Rossellini
- B. Luchino Visconti
- C. Federico Fellini
- D. Vittorio De Sica  ✅

**52. Which film features the character Tyler Durden, played by Brad Pitt?**
- A. Se7en
- B. Snatch
- C. Twelve Monkeys
- D. Fight Club  ✅

**53. What is the 'Bechdel Test' applied to films?**
- A. A measure of a film's commercial success
- B. A test asking whether a film has at least two named women who talk to each other about something other than a man  ✅
- C. A rating for film violence
- D. A measure of narrative originality

**54. Which Polish director made 'The Pianist' (2002) and 'Rosemary's Baby' (1968)?**
- A. Krzysztof Kieślowski
- B. Andrzej Wajda
- C. Roman Polanski  ✅
- D. Jerzy Skolimowski

**55. What is a 'Steadicam' shot?**
- A. A fixed, tripod-mounted camera shot
- B. A shot achieved with a body-mounted camera stabilisation rig, allowing smooth movement without the shaking of handheld footage  ✅
- C. A crane shot tracking a character from above
- D. A dutch angle shot to create unease

**56. Which 2014 film by Alejandro González Iñárritu was filmed to appear as a single continuous shot?**
- A. The Revenant
- B. Birdman  ✅
- C. Babel
- D. Amores Perros

**57. Which Japanese director made 'Seven Samurai' and 'Rashomon'?**
- A. Yasujirō Ozu
- B. Nagisa Ōshima
- C. Akira Kurosawa  ✅
- D. Kenji Mizoguchi

**58. What is the name of the protagonist in '2001: A Space Odyssey' who battles the AI HAL?**
- A. Frank Poole
- B. Dr. Floyd
- C. Dave Bowman  ✅
- D. Jack Torrance

**59. Which actress has won the most Academy Awards for acting (4 wins)?**
- A. Meryl Streep
- B. Katharine Hepburn  ✅
- C. Ingrid Bergman
- D. Cate Blanchett

**60. What is 'aspect ratio' in filmmaking?**
- A. The ratio of dialogue to action in a film
- B. The ratio of the width of the image to its height  ✅
- C. The ratio of location to studio filming
- D. The frames-per-second rate

**61. Which film's famous opening scene involves a young boy riding a tricycle through a hotel?**
- A. Poltergeist
- B. The Omen
- C. Hereditary
- D. The Shining  ✅

**62. Which 1950s film noir directed by Billy Wilder features Joe Gillis and Norma Desmond?**
- A. Double Indemnity
- B. The Lost Weekend
- C. Sunset Boulevard  ✅
- D. Some Like It Hot

**63. What is 'in medias res' as a narrative technique in film?**
- A. A film told in reverse chronological order
- B. Beginning the story in the middle of the action, without preamble  ✅
- C. A film with multiple parallel storylines
- D. A narrative technique using flashbacks throughout

**64. Which 1994 film by Robert Zemeckis uses extensive visual effects to insert its protagonist into historical footage?**
- A. Contact
- B. Cast Away
- C. Forrest Gump  ✅
- D. Back to the Future

**65. What is the 'Kuleshov effect'?**
- A. The use of colour to convey emotion
- B. The psychological phenomenon where the audience infers meaning from the juxtaposition of two shots, even if neither shot contains that meaning alone  ✅
- C. A wide-angle lens distortion technique
- D. The change in an actor's performance based on method acting

**66. Which French New Wave director made 'Breathless' (À bout de souffle) in 1960?**
- A. François Truffaut
- B. Éric Rohmer
- C. Claude Chabrol
- D. Jean-Luc Godard  ✅

**67. What did 'The Jazz Singer' (1927) mark in cinema history?**
- A. First colour feature film
- B. First feature film with synchronised dialogue — the first major sound film  ✅
- C. First animated feature film
- D. First widescreen feature film

**68. Which 1941 Orson Welles film is often called the greatest film ever made in critics' polls?**
- A. The Magnificent Ambersons
- B. Touch of Evil
- C. The Third Man
- D. Citizen Kane  ✅


### Hard (34)

**69. What is the 'auteur theory' in film criticism?**
- A. The idea that films should be judged on box office success
- B. The theory that the director is the primary creative author of a film, giving it a distinctive personal vision  ✅
- C. A theory about how audiences interpret film meaning
- D. The idea that cinematography is more important than screenplay

**70. Which Soviet director pioneered montage theory with films like 'Battleship Potemkin' (1925)?**
- A. Dziga Vertov
- B. Vsevolod Pudovkin
- C. Alexander Dovzhenko
- D. Sergei Eisenstein  ✅

**71. What is 'dialectical montage' in Eisenstein's theory?**
- A. Cutting to the rhythm of the film's musical score
- B. The collision of shots to produce a new idea or emotion in the viewer's mind beyond what each shot contains alone  ✅
- C. A series of dissolves linking related images
- D. Parallel editing between two storylines

**72. What cinematic technique did director Jean-Luc Godard introduce with the 'jump cut'?**
- A. A match-cut that emphasises continuity
- B. A deliberate break in continuity within a scene, calling attention to the constructedness of cinema  ✅
- C. A cut from a close-up to an extreme wide shot
- D. An eyeline match cut between two characters

**73. What is 'German Expressionism' in early cinema?**
- A. A documentary movement chronicling the Weimar Republic
- B. A silent-era film style using distorted sets, heavy shadows and subjective distortion to externalise psychological states  ✅
- C. A genre of romantic films made during the German economic miracle
- D. The first movement to use synchronised sound in Germany

**74. What is 'long take' aesthetics and which director is most associated with using it philosophically?**
- A. Editing as many shots as possible for dynamic pacing — Eisenstein
- B. An extended uninterrupted shot allowing events to unfold in real time — associated with Andrei Tarkovsky and Béla Tarr  ✅
- C. A slow motion close-up to heighten emotion
- D. A zoom that replaces conventional cuts

**75. What is 'deep focus' photography in cinematography and who popularised it?**
- A. A shallow depth of field to blur backgrounds — popularised by David Lean
- B. A technique keeping both foreground and background in sharp focus simultaneously — popularised by Orson Welles and Gregg Toland  ✅
- C. A zoom lens technique creating a compressed perspective
- D. An ultra-wide-angle shot distorting spatial depth

**76. What did Italian Neorealism advocate for in its filmmaking approach?**
- A. Studio-controlled environments with professional actors and polished scripts
- B. On-location shooting with non-professional actors and semi-documentary style, focusing on working-class social reality post-WWII  ✅
- C. Surrealist imagery and dreamlike narratives
- D. Highly stylised art direction and costume

**77. What is 'haptic visuality' in film theory?**
- A. The technical quality of film grain
- B. A quality of the camera's gaze that mimics the sense of touch, making the viewer feel textural and sensory experience through vision  ✅
- C. The motion blur of handheld cinematography
- D. The emotional response to a film's colour palette

**78. Which theorist wrote 'The Work of Art in the Age of Mechanical Reproduction', arguing cinema democratises art?**
- A. André Bazin
- B. Siegfried Kracauer
- C. Walter Benjamin  ✅
- D. Christian Metz

**79. What is 'suture theory' in psychoanalytic film theory?**
- A. A theory of how film scoring stitches together emotional responses
- B. The process by which the viewer is stitched into the film's narrative through shot-reverse-shot and the concealment of the apparatus of production  ✅
- C. The editing technique of matching action across cuts
- D. A Lacanian theory of desire projected onto screen characters

**80. What is the 'female gaze' in feminist film theory?**
- A. The tendency for films to feature female protagonists
- B. The way women directors frame the world differently from the dominant 'male gaze', focussing on female subjectivity and desire  ✅
- C. The marketing of films toward female audiences
- D. The narrative trope of the femme fatale

**81. Which French film theorist advocated for 'spatial realism' and against montage, arguing the long take preserves ambiguity?**
- A. Roland Barthes
- B. Christian Metz
- C. André Bazin  ✅
- D. Gilles Deleuze

**82. What is 'post-classical Hollywood cinema' defined by?**
- A. Films made after the studio system's collapse in the 1960s, marked by greater narrative complexity, auteurist influence and genre revision  ✅
- B. Hollywood films after the introduction of digital filmmaking
- C. The era of blockbusters from 1975 onwards
- D. The period of silent cinema before the talkies

**83. What is Gilles Deleuze's distinction between 'movement-image' and 'time-image' in cinema?**
- A. Movement-images are action films; time-images are slow art cinema
- B. Movement-image cinema subordinates time to action and cause-effect logic; time-image cinema presents time directly, with ambiguity and contemplation — linked to post-WWII modernism  ✅
- C. Movement-images use tracking shots; time-images use static camera
- D. A distinction between genre cinema and documentary

**84. What does 'diegesis' mean in narratology as applied to film?**
- A. The plot of a film as summarised in a synopsis
- B. The story world — the fictional world in which the characters live and events occur, including elements characters can perceive  ✅
- C. The editing rhythm of a film
- D. The gap between story events and their narrative presentation

**85. What is the 'persistence of vision' theory that was historically used to explain the illusion of movement in cinema?**
- A. The brain memorises each frame and merges them
- B. The retina retains an image briefly after it disappears; though now considered oversimplified, it was the dominant explanation for how separate frames appear as continuous motion  ✅
- C. The frame rate must match the speed of human vision exactly
- D. The flicker of early projectors created the illusion of depth

**86. Which director's 'Shoah' (1985) runs over 9 hours and consists entirely of testimonies and locations, with no archival footage?**
- A. Alain Resnais
- B. Marcel Ophüls
- C. Claude Lanzmann  ✅
- D. Costa-Gavras

**87. What is the 'uncanny valley' in CGI and digital characters?**
- A. The difficulty of simulating natural landscapes in computer graphics
- B. The psychological discomfort triggered when a humanoid figure looks almost, but not quite, real — the gap just below perfect realism  ✅
- C. The flat, artificial look of early CGI effects
- D. The limitation of digital cameras in low-light environments

**88. What is 'negative space' in film composition?**
- A. The empty area around the subject in the frame, which shapes the viewer's perception of the subject and emotional tone  ✅
- B. The unused footage left on the cutting room floor
- C. The space in a scene before actors enter frame
- D. The dark areas of underexposed film

**89. Which film theorist introduced the concept of 'identificatory voyeurism' and the 'male gaze'?**
- A. Claire Johnston
- B. E. Ann Kaplan
- C. Laura Mulvey  ✅
- D. Teresa de Lauretis

**90. What is 'colour grading' in post-production and how does it differ from basic colour correction?**
- A. They are the same — correcting errors in exposure and colour balance
- B. Colour correction fixes technical flaws; grading is a creative process shaping the mood, tone and aesthetic of the image  ✅
- C. Colour grading is only used in black-and-white conversion
- D. Grading refers to the gamma curve only

**91. What is the 'continuity system' (or 'invisible style') of Hollywood filmmaking?**
- A. A style of filming where all takes are of equal length
- B. A set of conventions (180-degree rule, match cuts, consistent screen direction) designed to make editing imperceptible and maintain spatial coherence  ✅
- C. Using the same cinematographer across a franchise
- D. A rule that storylines must resolve within 120 minutes

**92. What did Luis Buñuel and Salvador Dali intend to provoke with 'Un Chien Andalou' (1929)?**
- A. To tell a coherent story of Surrealist dreams
- B. To destroy rational and moral values in the viewer through irrational, disturbing imagery with no logical narrative  ✅
- C. To critique the bourgeoisie through symbolism
- D. To demonstrate new editing techniques to other filmmakers

**93. What distinguishes a 'dolly zoom' (the Hitchcock zoom or Vertigo effect) from a standard zoom?**
- A. The camera pans while the zoom is applied
- B. The camera physically moves toward or away from the subject while the focal length is adjusted in the opposite direction, keeping the subject the same size but distorting the background  ✅
- C. It uses a drone rather than a dolly
- D. The zoom is applied in post-production rather than in camera

**94. What is the narrative purpose of 'parallel editing' as theorised by D. W. Griffith?**
- A. To show the same event from two different characters' perspectives
- B. To create tension and imply a relationship (often temporal) between two simultaneous or thematically linked events in different locations  ✅
- C. To disorient the viewer with contradictory information
- D. To compress time within a single scene

**95. What is 'direct cinema' and how does it differ from cinema vérité?**
- A. They are identical movements
- B. Direct cinema is fly-on-the-wall observational documentary minimising filmmaker intrusion; cinéma vérité deliberately provokes and participates to reveal truth through interaction  ✅
- C. Direct cinema uses interviews; cinéma vérité avoids them
- D. Cinéma vérité is American; direct cinema is French

**96. What is the significance of the 'Production Code' (Hays Code) for Hollywood cinema from 1934 to the late 1960s?**
- A. It set minimum budgets for productions
- B. A system of strict censorship rules prohibiting explicit sexual content, crime being glorified and other material deemed morally harmful, shaping Hollywood narratives for decades  ✅
- C. A code requiring racial diversity in film casts
- D. A standardisation of aspect ratios and projection formats

**97. What is the 'Beckett school' of minimalist cinema associated with which movement?**
- A. The French New Wave's use of location shooting
- B. Minimalist or reductionist cinema (e.g. Bresson, Straub-Huillet) that strips away conventional film language to achieve a purer or more austere expression  ✅
- C. Documentary minimalism avoiding any music score
- D. A school of screenwriting based on dramatic economy

**98. What is a 'wipe' transition and what was its cultural significance in early sound cinema?**
- A. A fade to black between scenes
- B. A geometric shape moving across the screen to reveal the next scene, common in classical Hollywood and associated with joyful adventure (e.g. Star Wars)  ✅
- C. A freeze frame at the end of a scene
- D. A dissolve lasting less than one second

**99. Which director's concept of 'Kino-Eye' advocated for cinema as a tool to reveal truths invisible to human perception?**
- A. Sergei Eisenstein
- B. Vsevolod Pudovkin
- C. Dziga Vertov  ✅
- D. Lev Kuleshov

**100. What is the 'three-act structure' and which theorist's work on Greek tragedy underpins it?**
- A. A structure with beginning, middle and end; based on Gustav Freytag's pyramid
- B. Exposition-confrontation-resolution; traced to Aristotle's Poetics and its concepts of beginning, middle and end  ✅
- C. A Hollywood formula introduced in the 1970s by Robert McKee
- D. A structure unique to screenwriting with no classical precedent

**101. What is 'phenakistoscope' and its significance to cinema history?**
- A. An early film projector using a carbon arc lamp
- B. A 19th-century optical toy creating the illusion of motion by spinning a disc with sequential images, a direct precursor to film  ✅
- C. The first device to capture moving images on film stock
- D. A Victorian theatre device using mirrors to project still images

**102. What is 'intellectual montage' as theorised by Eisenstein?**
- A. Cutting based purely on rhythm and movement
- B. Editing where the collision of images creates an abstract intellectual concept or idea beyond the literal content of either image  ✅
- C. A series of parallel edits building tension
- D. Slow cutting to allow audiences to absorb complex ideas

---
