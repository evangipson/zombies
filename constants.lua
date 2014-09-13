local rtn={}
--game settings
rtn.scrollSpeed = nil
rtn.counterLocation = "Bottom Right"
rtn.timerOn = "Timer Shown"
rtn.rangeOn = "Indicator On"

--level progress constants
rtn.levelCleared = {}
rtn.infUnlocked = 0

--game constants
rtn.victory = 0
rtn.levelTime = 0
rtn.civsInfected = 0
rtn.milInfected = 0
rtn.zombiesLost = 0
rtn.zombieHealth = 50
rtn.civHealth = 50
rtn.currentLevel = 0
rtn.milHealth = 100

--stats constants
rtn.totalInfections = 0
rtn.totalLost = 0
rtn.gamesPlayed = 0
rtn.timePlayed = 0
rtn.totalMilInfections = 0

--save game location
rtn.saveFile = system.pathForFile( "infectzensave.txt", system.DocumentsDirectory)

--level information
--tutorial level
rtn.level0RoomCount = 4
rtn.level0Size = {}
rtn.level0Size[1] = {0, 0, 550, 445}
rtn.level0RoomX={50, 50, 200, 425}
rtn.level0RoomY={50, 95, 50, 270}
rtn.level0RoomW={50, 100, 300, 75}
rtn.level0RoomH={25, 300, 200, 50}
rtn.level0DoorX={75, 75, 200, 200, 425} 
rtn.level0DoorY={75, 95, 100, 150, 295}
rtn.level0DoorType={"H", "H", "V", "V", "V"}
rtn.level0DoorRoom={1, 2, 3, 3, 4}
rtn.level0CivX={60, 80, 100, 120, 140, 60, 80, 100, 120, 140, 60, 80, 100, 120, 140, 60, 80, 100, 120, 140}
rtn.level0CivY={60, 60, 60, 60, 60, 80, 80, 80, 80, 80, 100, 100, 100, 100, 100, 120, 120, 120, 120, 120}
rtn.level0MilX={100}
rtn.level0MilY={100}
rtn.level0Zombies = 4

--level 1
rtn.level1RoomCount = 2
rtn.level1Size = {}
rtn.level1Size[1] = {0, 0, 500, 500}
rtn.level1RoomX={50}
rtn.level1RoomY={50}
rtn.level1RoomW={50}
rtn.level1RoomH={50}
rtn.level1DoorX={75} 
rtn.level1DoorY={50}
rtn.level1DoorType={"H"}
rtn.level1DoorRoom={1}
rtn.level1CivX={120, 120}
rtn.level1CivY={60, 100}
rtn.level1MilX={100}
rtn.level1MilY={100}
rtn.level1Zombies = 1

--level 2
rtn.level2RoomCount = 1
rtn.level2Size = {}
rtn.level2Size[1] = {0, 0, 500, 500}
rtn.level2RoomX={150}
rtn.level2RoomY={50}
rtn.level2RoomW={50}
rtn.level2RoomH={50}
rtn.level2DoorX={50}
rtn.level2DoorY={50}
rtn.level2DoorType={"V"}
rtn.level2DoorRoom={1}
rtn.level2CivX={60, 80}
rtn.level2CivY={60, 60}
rtn.level2MilX={100}
rtn.level2MilY={100}
rtn.level2Zombies = 2

--level 3
rtn.level3RoomCount = 1
rtn.level3Size = {}
rtn.level3Size[1] = {0, 0, 500, 500}
rtn.level3RoomX={50}
rtn.level3RoomY={50}
rtn.level3RoomW={50}
rtn.level3RoomH={150}
rtn.level3DoorX={50} 
rtn.level3DoorY={50}
rtn.level3DoorType={"V"}
rtn.level3DoorRoom={1}
rtn.level3CivX={60, 80}
rtn.level3CivY={60, 60}
rtn.level3MilX={100}
rtn.level3MilY={100}
rtn.level3Zombies = 1

--level 4
rtn.level4RoomCount = 1
rtn.level4Size = {}
rtn.level4Size[1] = {0, 0, 500, 500}
rtn.level4RoomX={50}
rtn.level4RoomY={50}
rtn.level4RoomW={250}
rtn.level4RoomH={50}
rtn.level4DoorX={50} 
rtn.level4DoorY={50}
rtn.level4DoorType={"V"}
rtn.level4DoorRoom={1}
rtn.level4CivX={60, 80}
rtn.level4CivY={60, 60}
rtn.level4MilX={100}
rtn.level4MilY={100}
rtn.level4Zombies = 1

--level 5
rtn.level5RoomCount = 1
rtn.level5Size = {}
rtn.level5Size[1] = {0, 0, 500, 500}
rtn.level5RoomX={50}
rtn.level5RoomY={250}
rtn.level5RoomW={150}
rtn.level5RoomH={150}
rtn.level5DoorX={50} 
rtn.level5DoorY={50}
rtn.level5DoorType={"V"}
rtn.level5DoorRoom={1}
rtn.level5CivX={60, 80}
rtn.level5CivY={60, 60}
rtn.level5MilX={100}
rtn.level5MilY={100}
rtn.level5Zombies = 1

--level 6
rtn.level6RoomCount = 1
rtn.level6Size = {}
rtn.level6Size[1] = {0, 0, 500, 500}
rtn.level6RoomX={50}
rtn.level6RoomY={250}
rtn.level6RoomW={150}
rtn.level6RoomH={150}
rtn.level6DoorX={50} 
rtn.level6DoorY={50}
rtn.level6DoorType={"V"}
rtn.level6DoorRoom={1}
rtn.level6CivX={60, 80}
rtn.level6CivY={60, 60}
rtn.level6MilX={100}
rtn.level6MilY={100}
rtn.level6Zombies = 1

--level 7
rtn.level7RoomCount = 1
rtn.level7Size = {}
rtn.level7Size[1] = {0, 0, 500, 500}
rtn.level7RoomX={50}
rtn.level7RoomY={250}
rtn.level7RoomW={150}
rtn.level7RoomH={150}
rtn.level7DoorX={50} 
rtn.level7DoorY={50}
rtn.level7DoorType={"V"}
rtn.level7DoorRoom={1}
rtn.level7CivX={60, 80}
rtn.level7CivY={60, 60}
rtn.level7MilX={100}
rtn.level7MilY={100}
rtn.level7Zombies = 1

--level 8
rtn.level8RoomCount = 1
rtn.level8Size = {}
rtn.level8Size[1] = {0, 0, 500, 500}
rtn.level8RoomX={50}
rtn.level8RoomY={250}
rtn.level8RoomW={150}
rtn.level8RoomH={150}
rtn.level8DoorX={50} 
rtn.level8DoorY={50}
rtn.level8DoorType={"H"}
rtn.level8DoorRoom={1}
rtn.level8CivX={60, 80}
rtn.level8CivY={60, 60}
rtn.level8MilX={100}
rtn.level8MilY={100}
rtn.level8Zombies = 1

--level 9
rtn.level9RoomCount = 1
rtn.level9Size = {}
rtn.level9Size[1] = {0, 0, 500, 500}
rtn.level9RoomX={150}
rtn.level9RoomY={20}
rtn.level9RoomW={150}
rtn.level9RoomH={150}
rtn.level9DoorX={50} 
rtn.level9DoorY={50}
rtn.level9DoorType={"V"}
rtn.level9DoorRoom={1}
rtn.level9CivX={160, 180}
rtn.level9CivY={160, 160}
rtn.level9MilX={100}
rtn.level9MilY={100}
rtn.level9Zombies = 1

--level 10
rtn.level10RoomCount = 1
rtn.level10Size = {}
rtn.level10Size[1] = {0, 0, 500, 500}
rtn.level10RoomX={150}
rtn.level10RoomY={20}
rtn.level10RoomW={150}
rtn.level10RoomH={150}
rtn.level10DoorX={50} 
rtn.level10DoorY={50}
rtn.level10DoorType={"V"}
rtn.level10DoorRoom={1}
rtn.level10CivX={160, 180}
rtn.level10CivY={160, 160}
rtn.level10MilX={100}
rtn.level10MilY={100}
rtn.level10Zombies = 1

--!!temporary for infinity mode
--level 11
rtn.level11RoomCount = 1
rtn.level11Size = {}
rtn.level11Size[1] = {0, 0, 500, 500}
rtn.level11RoomX={150}
rtn.level11RoomY={50}
rtn.level11RoomW={150}
rtn.level11RoomH={150}
rtn.level11DoorX={150, 150, 300, 300, 200, 250, 200, 250} 
rtn.level11DoorY={100, 150, 100, 150, 50, 50, 200, 200}
rtn.level11DoorType={"V", "V", "V", "V", "H", "H", "H", "H"}
rtn.level11DoorRoom={1, 1, 1, 1, 1, 1, 1, 1}
rtn.level11CivX={100, 50}
rtn.level11CivY={100, 50}
rtn.level11MilX={100}
rtn.level11MilY={100}
rtn.level11Zombies = 100

--achievement constants
rtn.achUnlocked = {}
rtn.achCount = 39
rtn.achArray = {}
rtn.achArrayDesc = {}
rtn.achSecret = {}

rtn.achArray[1] = "It's a start!"
rtn.achArrayDesc[1] = "Complete level 1."
rtn.achArray[2] = "Definitely is a start..."
rtn.achArrayDesc[2] = "Complete level 2."
rtn.achArray[3] = "Now we're getting somewhere!"
rtn.achArrayDesc[3] = "Complete level 3."
rtn.achArray[4] = "People should start noticing"
rtn.achArrayDesc[4] = "Complete level 4."
rtn.achArray[5] = "Brainsss"
rtn.achArrayDesc[5] = "Complete level 5."
rtn.achArray[6] = "Do this three times" --hidden rtn.achievement, number of the best, do level 6 three times in a row
rtn.achArrayDesc[6] = "Complete level 6."
rtn.achArray[7] = "War!"
rtn.achArrayDesc[7] = "Complete level 7."
rtn.achArray[8] = "Running out of name ideas"
rtn.achArrayDesc[8] = "Complete level 8."
rtn.achArray[9] = "Seriously what do we call these?"
rtn.achArrayDesc[9] = "Complete level 9."
rtn.achArray[10] = "Fuck it"
rtn.achArrayDesc[10] = "Complete level 10."

rtn.achArray[11] = "We call him Ted"
rtn.achArrayDesc[11] = "Infect your first civilian."
rtn.achArray[12] = "Baker's dozen"
rtn.achArrayDesc[12] = "Infect 10 civilians."
rtn.achArray[13] = "I bet one of them was a writer."
rtn.achArrayDesc[13] = "Kill 42 civilians."
rtn.achArray[14] = "Baker's throzen"
rtn.achArrayDesc[14] = "Infect 100 civilians."
rtn.achArray[15] = "Kill 'em all"
rtn.achArrayDesc[15] = "Infect 1,000 civilians."
rtn.achArray[16] = "It's a game after all"
rtn.achArrayDesc[16] = "Infect 1,337 civilians."
rtn.achArray[17] = "And I would walk ten thousand miles"
rtn.achArrayDesc[17] = "Infect 10,000 civilians."
rtn.achArray[18] = "And I would walk ten thousand more"
rtn.achArrayDesc[18] = "Infect 20,000 civilians."
rtn.achArray[19] = "Something something zombie"
rtn.achArrayDesc[19] = "Infect 100,000 civilians."
rtn.achArray[20] = "Millionaire!"
rtn.achArrayDesc[20] = "Infect 1,000,000 civilians."
rtn.achArray[21] = "That's a lot"
rtn.achArrayDesc[21] = "Infect 10,000,000 civilians."
rtn.achArray[22] = "Getting bored yet?"
rtn.achArrayDesc[22] = "Infect 100,000,000 civilians."
rtn.achArray[23] = "Getting there"
rtn.achArrayDesc[23] = "Infect 1,000,000,000 civilians."
rtn.achArray[24] = "EVERYONE IS DEAD"
rtn.achArrayDesc[24] = "Infect 7,260,027,620 civilians."

rtn.achArray[25] = "G.I. DEAD, BITCH!"
rtn.achArrayDesc[25] = "Kill your first soldier."
rtn.achArray[26] = "S.W.A.T."
rtn.achArrayDesc[26] = "Kill 10 soldiers."
rtn.achArray[27] = "The Platoon"
rtn.achArrayDesc[27] = "Kill 100 soldiers."

rtn.achArray[28] = "Got a sec?"
rtn.achArrayDesc[28] = "Play for a second."
rtn.achArray[29] = "New York Minute"
rtn.achArrayDesc[29] = "Play for a minute."
rtn.achArray[30] = "15 minutes of fame"
rtn.achArrayDesc[30] = "Play for 15 minutes."
rtn.achArray[31] = "Sands of our time"
rtn.achArrayDesc[31] = "Play for an hour."
rtn.achArray[32] = "Got nothing better to do?"
rtn.achArrayDesc[32] = "Play for a day."
rtn.achArray[33] = "Samara"
rtn.achArrayDesc[33] = "Play for a week."

rtn.achArray[34] = "He will be missed"
rtn.achArrayDesc[34] = "Lose a zombie."
rtn.achArray[35] = "Be more careful!"
rtn.achArrayDesc[35] = "Lose 10 zombies."
rtn.achArray[36] = "Are you even trying?"
rtn.achArrayDesc[36] = "Lose 100 zombies."
rtn.achArray[37] = "Should have made this P2W..."
rtn.achArrayDesc[37] = "Lose 1000 zombies."
rtn.achArray[38] = "Screw it, humanity wins"
rtn.achArrayDesc[38] = "Lose 10000 zombies."

rtn.achArray[39] = "The number of the beast"
rtn.achArrayDesc[39] = "Complete level 6 three times in a row"
rtn.achSecret[39] = 1
rtn.level6achCleared = 0
return rtn