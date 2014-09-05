local rtn={}
--game settings
rtn.scrollSpeed = nil
rtn.counterLocation = "Bottom Right"
rtn.timerOn = "Timer Shown"

--level progress constants
rtn.levelCleared = {}
rtn.infUnlocked = 0

--game constants
rtn.victory = 0
rtn.levelTime = 0
rtn.civsInfected = 0
rtn.zombiesLost = 0
rtn.zombieHealth = 50
rtn.currentLevel = 0

--stats constants
rtn.totalInfections = 0
rtn.totalLost = 0
rtn.gamesPlayed = 0
rtn.timePlayed = 0

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
rtn.level0CivX={60, 80, 100, 120, 140, 60, 80, 100, 120, 140, 60, 80, 100, 120, 140, 60, 80, 100, 120, 140}
rtn.level0CivY={60, 60, 60, 60, 60, 80, 80, 80, 80, 80, 100, 100, 100, 100, 100, 120, 120, 120, 120, 120}
rtn.level0Zombies = 4

--level 1
rtn.level1RoomCount = 2
rtn.level1Size = {}
rtn.level1Size[1] = {0, 0, 500, 500}
rtn.level1RoomX={50}
rtn.level1RoomY={50}
rtn.level1RoomW={50}
rtn.level1RoomH={50}
rtn.level1CivX={60, 80}
rtn.level1CivY={60, 60}
rtn.level1Zombies = 1

--level 2
rtn.level2RoomCount = 1
rtn.level2Size = {}
rtn.level2RoomX={150}
rtn.level2Size[1] = {0, 0, 500, 500}
rtn.level2RoomY={50}
rtn.level2RoomW={50}
rtn.level2RoomH={50}
rtn.level2CivX={60, 80}
rtn.level2CivY={60, 60}
rtn.level2Zombies = 2

--level 3
rtn.level3RoomCount = 1
rtn.level3Size = {}
rtn.level3Size[1] = {0, 0, 500, 500}
rtn.level3RoomX={50}
rtn.level3RoomY={50}
rtn.level3RoomW={50}
rtn.level3RoomH={150}
rtn.level3CivX={60}
rtn.level3CivY={60}
rtn.level3Zombies = 1

--level 4
rtn.level4RoomCount = 1
rtn.level4Size = {}
rtn.level4Size[1] = {0, 0, 500, 500}
rtn.level4RoomX={50}
rtn.level4RoomY={50}
rtn.level4RoomW={250}
rtn.level4RoomH={50}
rtn.level4CivX={60}
rtn.level4CivY={60}
rtn.level4Zombies = 1

--level 5
rtn.level5RoomCount = 1
rtn.level5Size = {}
rtn.level5Size[1] = {0, 0, 500, 500}
rtn.level5RoomX={50}
rtn.level5RoomY={250}
rtn.level5RoomW={150}
rtn.level5RoomH={150}
rtn.level5CivX={60}
rtn.level5CivY={60}
rtn.level5Zombies = 1

--level 6
rtn.level6RoomCount = 1
rtn.level6Size = {}
rtn.level6Size[1] = {0, 0, 500, 500}
rtn.level6RoomX={50}
rtn.level6RoomY={250}
rtn.level6RoomW={150}
rtn.level6RoomH={150}
rtn.level6CivX={60}
rtn.level6CivY={60}
rtn.level6Zombies = 1

--level 7
rtn.level7RoomCount = 1
rtn.level7Size = {}
rtn.level7Size[1] = {0, 0, 500, 500}
rtn.level7RoomX={50}
rtn.level7RoomY={250}
rtn.level7RoomW={150}
rtn.level7RoomH={150}
rtn.level7CivX={60}
rtn.level7CivY={60}
rtn.level7Zombies = 1

--level 8
rtn.level8RoomCount = 1
rtn.level8Size = {}
rtn.level8Size[1] = {0, 0, 500, 500}
rtn.level8RoomX={50}
rtn.level8RoomY={250}
rtn.level8RoomW={150}
rtn.level8RoomH={150}
rtn.level8CivX={60}
rtn.level8CivY={60}
rtn.level8Zombies = 1

--level 9
rtn.level9RoomCount = 1
rtn.level9Size = {}
rtn.level9Size[1] = {0, 0, 500, 500}
rtn.level9RoomX={150}
rtn.level9RoomY={20}
rtn.level9RoomW={150}
rtn.level9RoomH={150}
rtn.level9CivX={160}
rtn.level9CivY={160}
rtn.level9Zombies = 1

--level 10
rtn.level10RoomCount = 1
rtn.level10Size = {}
rtn.level10Size[1] = {0, 0, 500, 500}
rtn.level10RoomX={150}
rtn.level10RoomY={20}
rtn.level10RoomW={150}
rtn.level10RoomH={150}
rtn.level10CivX={160}
rtn.level10CivY={160}
rtn.level10Zombies = 1

--!!temporary for infinity mode
--level 11
rtn.level11RoomCount = 1
rtn.level11Size = {}
rtn.level11Size[1] = {0, 0, 500, 500}
rtn.level11RoomX={150}
rtn.level11RoomY={20}
rtn.level11RoomW={150}
rtn.level11RoomH={150}
rtn.level11CivX={100, 50}
rtn.level11CivY={100, 50}
rtn.level11Zombies = 100

return rtn