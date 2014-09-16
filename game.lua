local composer = require( "composer" )
local constants = require("constants")
local scene = composer.newScene()
local world = {}
local roomArray={}
local roomCount, civCount, doorCount, milCount
local moveWorld
local roomX={}
local roomY={}
local roomW={}
local roomH={}
local leftWallArray = {}
local rightWallArray = {}
local upperWallArray = {}
local lowerWallArray = {}
local doorArray={}
local doorX={}
local doorY={}
local doorType={}
local doorRoom={}
local civilianArray = {}
local civCircles = {}
local zombieArray = {}
local zombieCircles = {}
local militaryArray = {}
local milCircles = {}
local milLines = {}
local milRangeCircles = {}
local zombieClicks
local zombieCount = 0
local mapSize={}
local startTime, endTime
local tempInfected = 0
local tempMilInfected = 0
local tempLost = 0
local moveCounter = 0
local moveCounterCiv = 0
local bittenCiv
local infCounter = 0
local milCounter = 0
local randomSpawn = 30
local randomMilSpawn = 120
local distX, distY
local distanceArray = {}
local infectBool
local newPosX, newPosY
local civDirection
local achInfections = 0
local displayAchievement = false
local achievementText
local achTime = 0
local achLost = 0
local achMilInfections = 0
local distX, distY
local distanceArray = {}
local bittenMil = 0
local targetDirection = 0
local movementX, movementY
local infectBool
local fireCounter = {}
local zedTarget = 0
local gameAchTimer
local doorDist

function detectLevel(init)
	--check which level player is on and set room variables accordingly
	if constants.currentLevel == 0 then
		--get the map size
		mapSize[1] = {constants.level0Size[1][1],constants.level0Size[1][2],constants.level0Size[1][3],constants.level0Size[1][4]}
		--add room locations
		roomCount = #constants.level0RoomX
		for i=1,roomCount do
			roomX[i] = constants.level0RoomX[i]
			roomY[i] = constants.level0RoomY[i]
			roomW[i] = constants.level0RoomW[i]
			roomH[i] = constants.level0RoomH[i]
		end
		--add door locations
		doorCount = #constants.level0DoorX
		for i=1,doorCount do
			doorX[i] = constants.level0DoorX[i]
			doorY[i] = constants.level0DoorY[i]
			doorType[i] = constants.level0DoorType[i]
			doorRoom[i] = constants.level0DoorRoom[i]
			--!!need to add doorType for the other levels but i'm lazy now
		end
		--add civilian locations
		civCount = #constants.level0CivX
		for i=1,civCount do
			civilianArray[i]={constants.level0CivX[i],constants.level0CivY[i]}
		end
		--add military locations
		milCount = #constants.level0MilX
		for i=1,milCount do
			militaryArray[i] = {constants.level0MilX[i], constants.level0MilY[i]}
			milLines[i] = { militaryArray[i][1], militaryArray[i][2], militaryArray[i][1], militaryArray[i][2] }
		end
		--add the amount of click things
		zombieClicks = constants.level0Zombies
	end
	if constants.currentLevel == 1 then
		mapSize[1] = {constants.level1Size[1][1],constants.level1Size[1][2],constants.level1Size[1][3],constants.level1Size[1][4]}
		--add room locations
		roomCount = #constants.level1RoomX
		for i=1,roomCount do
			roomX[i] = constants.level1RoomX[i]
			roomY[i] = constants.level1RoomY[i]
			roomW[i] = constants.level1RoomW[i]
			roomH[i] = constants.level1RoomH[i]
		end
		--add door locations
		doorCount = #constants.level1DoorX
		for i=1,doorCount do
			doorX[i] = constants.level1DoorX[i]
			doorY[i] = constants.level1DoorY[i]
			doorType[i] = constants.level1DoorType[i]
			doorRoom[i] = constants.level1DoorRoom[i]
		end
		--add civilian locations
		civCount = #constants.level1CivX
		for i=1,civCount do
			civilianArray[i]={constants.level1CivX[i],constants.level1CivY[i]}
		end
		--add military locations
		milCount = #constants.level1MilX
		for i=1,milCount do
			militaryArray[i] = {constants.level1MilX[i], constants.level1MilY[i]}
			milLines[i] = { militaryArray[i][1], militaryArray[i][2], militaryArray[i][1], militaryArray[i][2] }
		end
		--add the amount of click things
		zombieClicks = constants.level1Zombies
	end
	if constants.currentLevel == 2 then
		mapSize[1] = {constants.level2Size[1][1],constants.level2Size[1][2],constants.level2Size[1][3],constants.level2Size[1][4]}
		--add room locations
		roomCount = #constants.level2RoomX
		for i=1,roomCount do
			roomX[i] = constants.level2RoomX[i]
			roomY[i] = constants.level2RoomY[i]
			roomW[i] = constants.level2RoomW[i]
			roomH[i] = constants.level2RoomH[i]
		end
		--add door locations
		doorCount = #constants.level2DoorX
		for i=1,doorCount do
			doorX[i] = constants.level2DoorX[i]
			doorY[i] = constants.level2DoorY[i]
			doorType[i] = constants.level2DoorType[i]
			doorRoom[i] = constants.level2DoorRoom[i]
		end
		--add civilian locations
		civCount = #constants.level2CivX
		for i=1,civCount do
			civilianArray[i]={constants.level2CivX[i],constants.level2CivY[i]}
		end
		--add military locations
		milCount = #constants.level2MilX
		for i=1,milCount do
			militaryArray[i] = {constants.level2MilX[i], constants.level2MilY[i]}
			milLines[i] = { militaryArray[i][1], militaryArray[i][2], militaryArray[i][1], militaryArray[i][2] }
		end
		--add the amount of click things
		zombieClicks = constants.level2Zombies	
	end
	if constants.currentLevel == 3 then
	mapSize[1] = {constants.level3Size[1][1],constants.level3Size[1][2],constants.level3Size[1][3],constants.level3Size[1][4]}
		--add room locations
		roomCount = #constants.level3RoomX
		for i=1,roomCount do
			roomX[i] = constants.level3RoomX[i]
			roomY[i] = constants.level3RoomY[i]
			roomW[i] = constants.level3RoomW[i]
			roomH[i] = constants.level3RoomH[i]
		end
		--add door locations
		doorCount = #constants.level3DoorX
		for i=1,doorCount do
			doorX[i] = constants.level3DoorX[i]
			doorY[i] = constants.level3DoorY[i]
			doorType[i] = constants.level3DoorType[i]
			doorRoom[i] = constants.level3DoorRoom[i]
		end
		--add civilian locations
		civCount = #constants.level3CivX
		for i=1,civCount do
			civilianArray[i]={constants.level3CivX[i],constants.level3CivY[i]}
		end
		--add military locations
		milCount = #constants.level3MilX
		for i=1,milCount do
			militaryArray[i] = {constants.level3MilX[i], constants.level3MilY[i]}
			milLines[i] = { militaryArray[i][1], militaryArray[i][2], militaryArray[i][1], militaryArray[i][2] }
		end
		--add the amount of click things
		zombieClicks = constants.level3Zombies	
	end
	if constants.currentLevel == 4 then
	mapSize[1] = {constants.level4Size[1][1],constants.level4Size[1][2],constants.level4Size[1][3],constants.level4Size[1][4]}
		--add room locations
		roomCount = #constants.level4RoomX
		for i=1,roomCount do
			roomX[i] = constants.level4RoomX[i]
			roomY[i] = constants.level4RoomY[i]
			roomW[i] = constants.level4RoomW[i]
			roomH[i] = constants.level4RoomH[i]
		end
		--add door locations
		doorCount = #constants.level4DoorX
		for i=1,doorCount do
			doorX[i] = constants.level4DoorX[i]
			doorY[i] = constants.level4DoorY[i]
			doorType[i] = constants.level4DoorType[i]
			doorRoom[i] = constants.level4DoorRoom[i]
		end
		--add civilian locations
		civCount = #constants.level4CivX
		for i=1,civCount do
			civilianArray[i]={constants.level4CivX[i],constants.level4CivY[i]}
		end
		--add military locations
		milCount = #constants.level4MilX
		for i=1,milCount do
			militaryArray[i] = {constants.level4MilX[i], constants.level4MilY[i]}
			milLines[i] = { militaryArray[i][1], militaryArray[i][2], militaryArray[i][1], militaryArray[i][2] }
		end
		--add the amount of click things
		zombieClicks = constants.level4Zombies	
	end
	if constants.currentLevel == 5 then
	mapSize[1] = {constants.level5Size[1][1],constants.level5Size[1][2],constants.level5Size[1][3],constants.level5Size[1][4]}
		--add room locations
		roomCount = #constants.level5RoomX
		for i=1,roomCount do
			roomX[i] = constants.level5RoomX[i]
			roomY[i] = constants.level5RoomY[i]
			roomW[i] = constants.level5RoomW[i]
			roomH[i] = constants.level5RoomH[i]
		end
		--add door locations
		doorCount = #constants.level5DoorX
		for i=1,doorCount do
			doorX[i] = constants.level5DoorX[i]
			doorY[i] = constants.level5DoorY[i]
			doorType[i] = constants.level5DoorType[i]
			doorRoom[i] = constants.level5DoorRoom[i]
		end
		--add civilian locations
		civCount = #constants.level5CivX
		for i=1,civCount do
			civilianArray[i]={constants.level5CivX[i],constants.level5CivY[i]}
		end
		--add military locations
		milCount = #constants.level5MilX
		for i=1,milCount do
			militaryArray[i] = {constants.level5MilX[i], constants.level5MilY[i]}
			milLines[i] = { militaryArray[i][1], militaryArray[i][2], militaryArray[i][1], militaryArray[i][2] }
		end
		--add the amount of click things
		zombieClicks = constants.level5Zombies
	end
	if constants.currentLevel == 6 then
	mapSize[1] = {constants.level6Size[1][1],constants.level6Size[1][2],constants.level6Size[1][3],constants.level6Size[1][4]}
		--add room locations
		roomCount = #constants.level6RoomX
		for i=1,roomCount do
			roomX[i] = constants.level6RoomX[i]
			roomY[i] = constants.level6RoomY[i]
			roomW[i] = constants.level6RoomW[i]
			roomH[i] = constants.level6RoomH[i]	
		end
		--add door locations
		doorCount = #constants.level6DoorX
		for i=1,doorCount do
			doorX[i] = constants.level6DoorX[i]
			doorY[i] = constants.level6DoorY[i]
			doorType[i] = constants.level6DoorType[i]
			doorRoom[i] = constants.level6DoorRoom[i]
		end
		--add civilian locations
		civCount = #constants.level6CivX
		for i=1,civCount do
			civilianArray[i]={constants.level6CivX[i],constants.level6CivY[i]}
		end
		--add military locations
		milCount = #constants.level6MilX
		for i=1,milCount do
			militaryArray[i] = {constants.level6MilX[i], constants.level6MilY[i]}
			milLines[i] = { militaryArray[i][1], militaryArray[i][2], militaryArray[i][1], militaryArray[i][2] }
		end
		--add the amount of click things
		zombieClicks = constants.level6Zombies
	end
	if constants.currentLevel == 7 then
	mapSize[1] = {constants.level7Size[1][1],constants.level7Size[1][2],constants.level7Size[1][3],constants.level7Size[1][4]}
		--add room locations
		roomCount = #constants.level7RoomX
		for i=1,roomCount do
			roomX[i] = constants.level7RoomX[i]
			roomY[i] = constants.level7RoomY[i]
			roomW[i] = constants.level7RoomW[i]
			roomH[i] = constants.level7RoomH[i]		
		end
		--add door locations
		doorCount = #constants.level7DoorX
		for i=1,doorCount do
			doorX[i] = constants.level7DoorX[i]
			doorY[i] = constants.level7DoorY[i]
			doorType[i] = constants.level7DoorType[i]
			doorRoom[i] = constants.level7DoorRoom[i]
		end
		--add civilian locations
		civCount = #constants.level7CivX
		for i=1,civCount do
			civilianArray[i]={constants.level7CivX[i],constants.level7CivY[i]}
		end
		--add military locations
		milCount = #constants.level7MilX
		for i=1,milCount do
			militaryArray[i] = {constants.level7MilX[i], constants.level7MilY[i]}
			milLines[i] = { militaryArray[i][1], militaryArray[i][2], militaryArray[i][1], militaryArray[i][2] }
		end
		--add the amount of click things
		zombieClicks = constants.level7Zombies
	end
	if constants.currentLevel == 8 then
	mapSize[1] = {constants.level8Size[1][1],constants.level8Size[1][2],constants.level8Size[1][3],constants.level8Size[1][4]}
		--add room locations
		roomCount = #constants.level8RoomX
		for i=1,roomCount do
			roomX[i] = constants.level8RoomX[i]
			roomY[i] = constants.level8RoomY[i]
			roomW[i] = constants.level8RoomW[i]
			roomH[i] = constants.level8RoomH[i]
		end
		--add door locations
		doorCount = #constants.level8DoorX
		for i=1,doorCount do
			doorX[i] = constants.level8DoorX[i]
			doorY[i] = constants.level8DoorY[i]
			doorType[i] = constants.level8DoorType[i]
			doorRoom[i] = constants.level8DoorRoom[i]
		end
		--add civilian locations
		civCount = #constants.level8CivX
		for i=1,civCount do
			civilianArray[i]={constants.level8CivX[i],constants.level8CivY[i]}
		end
		--add military locations
		milCount = #constants.level8MilX
		for i=1,milCount do
			militaryArray[i] = {constants.level8MilX[i], constants.level8MilY[i]}
			milLines[i] = { militaryArray[i][1], militaryArray[i][2], militaryArray[i][1], militaryArray[i][2] }
		end
		--add the amount of click things
		zombieClicks = constants.level8Zombies
	end
	if constants.currentLevel == 9 then
	mapSize[1] = {constants.level9Size[1][1],constants.level9Size[1][2],constants.level9Size[1][3],constants.level9Size[1][4]}
		--add room locations
		roomCount = #constants.level9RoomX
		for i=1,roomCount do
			roomX[i] = constants.level9RoomX[i]
			roomY[i] = constants.level9RoomY[i]
			roomW[i] = constants.level9RoomW[i]
			roomH[i] = constants.level9RoomH[i]
		end
		--add door locations
		doorCount = #constants.level9DoorX
		for i=1,doorCount do
			doorX[i] = constants.level9DoorX[i]
			doorY[i] = constants.level9DoorY[i]
			doorType[i] = constants.level9DoorType[i]
			doorRoom[i] = constants.level9DoorRoom[i]
		end
		--add civilian locations
		civCount = #constants.level9CivX
		for i=1,civCount do
			civilianArray[i]={constants.level9CivX[i],constants.level9CivY[i]}
		end
		--add military locations
		milCount = #constants.level9MilX
		for i=1,milCount do
			militaryArray[i] = {constants.level9MilX[i], constants.level9MilY[i]}
			milLines[i] = { militaryArray[i][1], militaryArray[i][2], militaryArray[i][1], militaryArray[i][2] }
		end
		--add the amount of click things
		zombieClicks = constants.level9Zombies
	end
	if constants.currentLevel == 10 then
	mapSize[1] = {constants.level10Size[1][1],constants.level10Size[1][2],constants.level10Size[1][3],constants.level10Size[1][4]}
		--add room locations
		roomCount = #constants.level10RoomX
		for i=1,roomCount do
			roomX[i] = constants.level10RoomX[i]
			roomY[i] = constants.level10RoomY[i]
			roomW[i] = constants.level10RoomW[i]
			roomH[i] = constants.level10RoomH[i]
		end
		--add door locations
		doorCount = #constants.level10DoorX
		for i=1,doorCount do
			doorX[i] = constants.level10DoorX[i]
			doorY[i] = constants.level10DoorY[i]
			doorType[i] = constants.level10DoorType[i]
			doorRoom[i] = constants.level10DoorRoom[i]
		end
		--add civilian locations
		civCount = #constants.level10CivX
		for i=1,civCount do
			civilianArray[i]={constants.level10CivX[i],constants.level10CivY[i]}
		end
		--add military locations
		milCount = #constants.level10MilX
		for i=1,milCount do
			militaryArray[i] = {constants.level10MilX[i], constants.level10MilY[i]}
			milLines[i] = { militaryArray[i][1], militaryArray[i][2], militaryArray[i][1], militaryArray[i][2] }
		end
		--add the amount of click things
		zombieClicks = constants.level10Zombies
	end
	--!!temporary for infinity mode
	if constants.currentLevel == 11 then
	mapSize[1] = {constants.level11Size[1][1],constants.level11Size[1][2],constants.level11Size[1][3],constants.level11Size[1][4]}
		--add room locations
		roomCount = #constants.level11RoomX
		for i=1,roomCount do
			roomX[i] = constants.level11RoomX[i]
			roomY[i] = constants.level11RoomY[i]
			roomW[i] = constants.level11RoomW[i]
			roomH[i] = constants.level11RoomH[i]
		end
		--add door locations
		doorCount = #constants.level11DoorX
		for i=1,doorCount do
			doorX[i] = constants.level11DoorX[i]
			doorY[i] = constants.level11DoorY[i]
			doorType[i] = constants.level11DoorType[i]
			doorRoom[i] = constants.level11DoorRoom[i]
		end
		--add civilian locations
		civCount = #constants.level11CivX
		for i=1,civCount do
			civilianArray[i]={constants.level11CivX[i],constants.level11CivY[i]}
		end
		--add military locations
		milCount = #constants.level11MilX
		for i=1,milCount do
			militaryArray[i] = {constants.level11MilX[i], constants.level11MilY[i]}
			milLines[i] = { militaryArray[i][1], militaryArray[i][2], militaryArray[i][1], militaryArray[i][2] }
		end
		--add the amount of click things
		zombieClicks = constants.level11Zombies
	end
end

function checkAchievements ( event )
local isUnlocked = 0
	--check first for infections
	if (achInfections > 0 and achInfections < 5 and constants.achUnlocked[11] == "false") then
		constants.achUnlocked[11] = "true"
		isUnlocked = 11
	end
	if (achInfections > 9 and achInfections < 16 and constants.achUnlocked[12] == "false") then
		constants.achUnlocked[12] = "true"
		isUnlocked = 12
	end
	if (achInfections > 41 and achInfections < 50 and constants.achUnlocked[13] == "false") then
		constants.achUnlocked[13] = "true"
		isUnlocked = 13
	end
	if (achInfections > 99 and achInfections < 120 and constants.achUnlocked[14] == "false") then
		constants.achUnlocked[14] = "true"
		isUnlocked = 14
	end
	if (achInfections > 1000 and achInfections < 1100 and constants.achUnlocked[15] == "false") then
		constants.achUnlocked[15] = "true"
		isUnlocked = 15
	end
	if (achInfections > 1336 and achInfections < 1400 and constants.achUnlocked[16] == "false") then
		constants.achUnlocked[16] = "true"
		isUnlocked = 16
	end
	if (achInfections > 9999 and achInfections < 10100 and constants.achUnlocked[17] == "false") then
		constants.achUnlocked[17] = "true"
		isUnlocked = 17
	end
	if (achInfections > 19999 and achInfections < 20100 and constants.achUnlocked[18] == "false") then
		constants.achUnlocked[18] = "true"
		isUnlocked = 18
	end
	if (achInfections > 99999 and achInfections < 100100 and constants.achUnlocked[19] == "false") then
		constants.achUnlocked[19] = "true"
		isUnlocked = 19
	end
	if (achInfections > 999999 and achInfections < 1000100 and constants.achUnlocked[20] == "false") then
		constants.achUnlocked[20] = "true"
		isUnlocked = 20
	end
	if (achInfections > 9999999 and achInfections < 10000100 and constants.achUnlocked[21] == "false") then
		constants.achUnlocked[21] = "true"
		isUnlocked = 21
	end
	if (achInfections > 99999999 and achInfections < 100000100 and constants.achUnlocked[22] == "false") then
		constants.achUnlocked[22] = "true"
		isUnlocked = 22
	end
	if (achInfections > 999999999 and achInfections < 1000000100 and constants.achUnlocked[23] == "false") then
		constants.achUnlocked[23] = "true"
		isUnlocked = 23
	end
	if (achInfections > 7260027619 and achInfections < 7260027720 and constants.achUnlocked[24] == "false") then
		constants.achUnlocked[24] = "true"
		isUnlocked = 24
	end
	--check for military achievements
	if (achMilInfections > 0 and achMilInfections < 5 and constants.achUnlocked[25] == "false") then
		constants.achUnlocked[25] = "true"
		isUnlocked = 25
	end
	if (achMilInfections > 9 and achMilInfections < 15 and constants.achUnlocked[26] == "false") then
		constants.achUnlocked[26] = "true"
		isUnlocked = 26
	end
	if (achMilInfections > 99 and achMilInfections < 120 and constants.achUnlocked[27] == "false") then
		constants.achUnlocked[27] = "true"
		isUnlocked = 27
	end
	--check for time achievements
	if (achTime > 900 and achTime < 1100) then
		constants.achUnlocked[28] = "true"
		isUnlocked = 28
	end
	if (achTime > 59900 and achTime < 60100) then
		constants.achUnlocked[29] = "true"
		isUnlocked = 29
	end
	if (achTime > 899900 and achTime < 900100) then
		constants.achUnlocked[30] = "true"
		isUnlocked = 30
	end
	if (achTime > 3599900 and achTime < 3600100) then
		constants.achUnlocked[31] = "true"
		isUnlocked = 31
	end
	if (achTime > 86399900 and achTime < 86400100) then
		constants.achUnlocked[32] = "true"
		isUnlocked = 32
	end
	if (achTime > 604799900 and achTime < 604800100) then
		constants.achUnlocked[33] = "true"
		isUnlocked = 33
	end
	if isUnlocked > 0 then
		achPopUp( isUnlocked )
	end
	--check loss achievements
	if (achLost > 0 and achLost < 5 and constants.achUnlocked[34] == "false") then
		constants.achUnlocked[34] = "true"
		isUnlocked = 34
	end
	if (achLost > 9 and achLost < 15 and constants.achUnlocked[35] == "false") then
		constants.achUnlocked[35] = "true"
		isUnlocked = 35
	end
	if (achLost > 99 and achLost < 120 and constants.achUnlocked[36] == "false") then
		constants.achUnlocked[36] = "true"
		isUnlocked = 36
	end
	if (achLost > 999 and achLost < 1100 and constants.achUnlocked[37] == "false") then
		constants.achUnlocked[37] = "true"
		isUnlocked = 37
	end
	if (achLost > 9999 and achLost < 10100 and constants.achUnlocked[38] == "false") then
		constants.achUnlocked[38] = "true"
		isUnlocked = 38
	end
	isUnlocked = false
end

function achPopUp ( isUnlocked )
	displayAchievement = true
	achievementText = "Achievement unlocked!\n"..constants.achArray[isUnlocked]
	gameAchTimer = timer.performWithDelay( 3000, achPopDown )
end

function achPopDown ( event )
	if displayAchievement == true then
		displayAchievement = false
	end
end

function spawnRandom ( event )
	civilianArray[#civilianArray+1] = { math.random(50, 400), math.random(50, 300) }
	civilianArray[#civilianArray].lifeLeft = constants.civHealth
	civilianArray[#civilianArray].status = "healthy"
	civilianArray[#civilianArray].targetType = "none"
	civilianArray[#civilianArray].target = 0
	civilianArray[#civilianArray].targetDist = 9999
end

function spawnRandomMil ( event )
	militaryArray[#militaryArray+1] = { math.random(50, 400), math.random(50, 300) }
	militaryArray[#militaryArray].lifeLeft = constants.milHealth
	militaryArray[#militaryArray].status = "healthy"
	militaryArray[#militaryArray].fireCounter = 0
	militaryArray[#militaryArray].targetDist = 9999
	militaryArray[#militaryArray].target = 0
	milLines[#militaryArray] = { militaryArray[#militaryArray][1], militaryArray[#militaryArray][2], militaryArray[#militaryArray][1], militaryArray[#militaryArray][2] }
	milLines[#militaryArray].fire = 0
end

function eatCivs( event )
	for i=1,#civilianArray do
		if i > #civilianArray then --error because we remove a zombie from the array in the middle of the thing
			print("ERROR: civilianArray > i")
			else
			if civilianArray[i].status == "bitten" then
				civilianArray[i].lifeLeft = civilianArray[i].lifeLeft - 5
			end
			if civilianArray[i].lifeLeft < 1 then --turn into zombie
				bittenCiv = i
				infectCiv()
			end
		end
	end
	for i=1,#militaryArray do
		if i > #militaryArray then --error because we remove a zombie from the array in the middle of the thing
			print("ERROR: militaryArray > i")
			else
			if militaryArray[i].status == "bitten" then
				militaryArray[i].lifeLeft = militaryArray[i].lifeLeft - 5
			end
			if militaryArray[i].lifeLeft < 1 then --turn into zombie
				bittenMil = i
				infectMil()
			end
		end
	end
end

function clickCiv( event )
	if zombieClicks > 0 then
		--the zombie will be inserted in the next slot in the array, so the zombie count + 1.
		--event.target.arrayNumber is given to the civilians when the map is drawn and is their unique identifier.
		--add civilian to zombie array
		--civCircles[event.target.arrayNumber]:removeEventListener( "tap", clickCiv )
		zombieArray[zombieCount+1] = {civilianArray[event.target.arrayNumber][1],civilianArray[event.target.arrayNumber][2]}
		--remove it from civilian table
		table.remove(civilianArray, event.target.arrayNumber)
		--increase zombiecount because there's a zombie now
		zombieCount = zombieCount + 1
		zombieArray[zombieCount].lifeLeft = constants.zombieHealth
		zombieArray[zombieCount].targetType = "none"
		zombieArray[zombieCount].target = 0
		zombieArray[zombieCount].targetDist = 9999
		zombieArray[zombieCount].targetX = 0
		zombieArray[zombieCount].targetY = 0
		for j=1,#roomArray do
			if (zombieArray[zombieCount][1] > roomArray[j][1] and zombieArray[zombieCount][1] < roomArray[j][1]+roomArray[j][4]) then --zed is within x of room
				if (zombieArray[zombieCount][2] > roomArray[j][2] and zombieArray[zombieCount][1] < roomArray[j][2]+roomArray[j][4]) then --zed is within y of room
					zombieArray[zombieCount].currentRoom = j
				end
			end
		end
		zombieClicks = zombieClicks - 1
		tempInfected = tempInfected + 1
		achInfections = achInfections + 1
	else
		print("Cannot infect - no clicks left")
	end
	return true
end

function infectCiv ( event )
		--the zombie will be inserted in the next slot in the array, so the zombie count + 1.
		--event.target.arrayNumber is given to the civilians when the map is drawn and is their unique identifier.
		--add civilian to zombie array
			zombieArray[zombieCount+1] = {civilianArray[bittenCiv][1],civilianArray[bittenCiv][2]}
			--remove it from civilian table
			table.remove(civilianArray, bittenCiv)
		--increase zombiecount because there's a zombie now
		zombieCount = zombieCount + 1
		zombieArray[zombieCount].lifeLeft = constants.zombieHealth
		zombieArray[zombieCount].targetType = "none"
		zombieArray[zombieCount].target = 0
		zombieArray[zombieCount].targetDist = 9999
		--now remove this civ from the zombie that ate it
		for i=1,#zombieArray do
			if zombieArray[i].target == bittenCiv then
				zombieArray[i].target = 0
				zombieArray[i].targetDist = 9999
				zombieArray[i].targetType = "none"
				zombieArray[i].targetX = 0
				zombieArray[i].targetY = 0
			end
		end
		tempInfected = tempInfected + 1
		achInfections = achInfections + 1
end

function infectMil ( event )
	--the zombie will be inserted in the next slot in the array, so the zombie count + 1.
	--event.target.arrayNumber is given to the civilians when the map is drawn and is their unique identifier.
	--add civilian to zombie array
		zombieArray[zombieCount+1] = {militaryArray[bittenMil][1],militaryArray[bittenMil][2]}
		--remove it from civilian table
		table.remove(militaryArray, bittenMil)
	--increase zombiecount because there's a zombie now
	zombieCount = zombieCount + 1
	zombieArray[zombieCount].lifeLeft = constants.zombieHealth
	zombieArray[zombieCount].targetType = "none"
	zombieArray[zombieCount].target = 0
	zombieArray[zombieCount].targetDist = 9999
	for i=1,#zombieArray do
		if zombieArray[i].target == bittenMil then
			zombieArray[i].target = 0
			zombieArray[i].targetDist = 9999
			zombieArray[i].targetType = "none"
			zombieArray[i].targetX = 0
			zombieArray[i].targetY = 0
		end
	end
	tempMilInfected = tempMilInfected + 1
	achMilInfections = achMilInfections + 1
end

function clickZombie ( event )
	table.remove(zombieArray, event.target.arrayNumber)
	zombieCount = zombieCount - 1
	tempLost = tempLost + 1
	achLost = achLost + 1
	for p=1,#militaryArray do
		if militaryArray[p].bittenBy == zedTarget then
			militaryArray[p].bittenBy = nil
			militaryArray[p].status = "healthy"
		end
		if militaryArray[p].target == zedTarget then
			militaryArray[p].target = 0
			militaryArray[p].targetDist = 9999
		end
	end
	return true
end

function killZombie ( zedTarget )
	table.remove(zombieArray, zedTarget)
	zombieCount = zombieCount - 1
	tempLost = tempLost + 1
	achLost = achLost + 1
	for p=1,#militaryArray do
		if militaryArray[p].bittenBy == zedTarget then
			militaryArray[p].bittenBy = nil
			militaryArray[p].status = "healthy"
		end
		if militaryArray[p].target == zedTarget then
			militaryArray[p].target = 0
			militaryArray[p].targetDist = 9999
		end
	end
	zedTarget = 0
end

function createRoom(init)
	detectLevel(true)
	-- add it to the roomArray
	for i=1,roomCount do
		roomArray[i] = {roomX[i], roomY[i], roomW[i], roomH[i]}
	end
end

function moveWorld(event)
    local xScroll, yScroll
    if event.phase == "moved" then
        xScroll=((event.xStart-event.x)*-1)*constants.scrollSpeed
        yScroll=((event.yStart-event.y)*-1)*constants.scrollSpeed
		--stop it from scrolling outside map
		if (xScroll+mapSize[1][1]) > 0 then
			xScroll = 0
		end
		if (yScroll+mapSize[1][2])-40 > 0 then
			yScroll = 0
		end
		if (mapSize[1][1]+xScroll) < (display.contentWidth-mapSize[1][3]) then
			xScroll = 0
			mapSize[1][1] = (display.contentWidth-mapSize[1][3])
		end
		if (mapSize[1][2]+yScroll) < (display.contentHeight-mapSize[1][4])-40 then
			yScroll = 0
			mapSize[1][2] = (display.contentHeight-mapSize[1][4])-40
		end
        --we have to move all the rooms
        for i=1,#roomArray do
            roomArray[i][1]=roomArray[i][1]+xScroll
            roomArray[i][2]=roomArray[i][2]+yScroll
        end
		--raise the roof
		for i=1,doorCount do
			doorX[i] = doorX[i] + xScroll
			doorY[i] = doorY[i] + yScroll
		end
		--now move the civilians
		for i=1,#civilianArray do
			civilianArray[i][1]=civilianArray[i][1]+xScroll
			civilianArray[i][2]=civilianArray[i][2]+yScroll
		end
		--move the zombies
		for i=1,#zombieArray do
			zombieArray[i][1]=zombieArray[i][1]+xScroll
			zombieArray[i][2]=zombieArray[i][2]+yScroll
		end
		--move the military
		for i=1,#militaryArray do
			militaryArray[i][1]=militaryArray[i][1]+xScroll
			militaryArray[i][2]=militaryArray[i][2]+yScroll
		end
		--and the map itself
		mapSize[1][1]=mapSize[1][1]+xScroll
		mapSize[1][2]=mapSize[1][2]+yScroll
    end
    return true
end

function findClosestZombie ( i, j )
	--compare distances to all zombie actors
	distX = civilianArray[i][1]-zombieArray[j][1]
	--no negative numbers please	
	if distX < 0 then
		distX = distX*-1
	end
	distY = civilianArray[i][2]-zombieArray[j][2]
	--no negative numbers please
	if distY < 0 then
		distY = distY*-1
	end
	distanceArray[j] = distX + distY
	--now we have the distance, see if it's the closest
	if distanceArray[j] < civilianArray[i].targetDist then
		civilianArray[i].targetType = "zombie"
		civilianArray[i].target = j
		civilianArray[i].targetDist = distanceArray[j]
		civilianArray[i].targetX = zombieArray[j][1]
		civilianArray[i].targetY = zombieArray[j][2]
	end
end

function findClosestDoor ( i, m )
	--compare distances to all zombie actors
	DistX = civilianArray[i][1]-doorArray[m].x
	--no negative numbers please	
	if DistX < 0 then
		DistX = DistX*-1
	end
	DistY = civilianArray[i][2]-doorArray[m].y
	--no negative numbers please
	if DistY < 0 then
		DistY = DistY*-1
	end
	distanceArray[m] = DistX + DistY
	--now we have the distance, see if it's the closest
	if distanceArray[m] < civilianArray[i].targetDist then
		civilianArray[i].targetDist = distanceArray[m]
		civilianArray[i].targetType = "door"
		civilianArray[i].target = m
		civilianArray[i].targetX = doorArray[m].x
		civilianArray[i].targetY = doorArray[m].y
	end
	if distanceArray[m] < doorDist then
		doorDist = distanceArray[m]
	end
end

function moveTowardsDoor ( i )
	newPosX = civilianArray[i][1]
	newPosY = civilianArray[i][2]
	movementX = civilianArray[i][1]-civilianArray[i].targetX
	movementY = civilianArray[i][2]-civilianArray[i].targetY
	if movementX < 0 then
		movementX = movementX*-1
	end
	if movementY < 0 then
		movementY = movementY*-1
	end
	if civilianArray[i][1] < doorArray[civilianArray[i].target].x then
		targetDirection = targetDirection + 2
	elseif civilianArray[i][1] > doorArray[civilianArray[i].target].x then
		targetDirection = targetDirection + 1
	end
	--see if it's up or down
	if civilianArray[i][2] < doorArray[civilianArray[i].target].y then
		targetDirection = targetDirection + 8
	elseif civilianArray[i][2] > doorArray[civilianArray[i].target].y then
		targetDirection = targetDirection + 4
	end	
	--now we have the direction! now we move towards the door
	if targetDirection == 1 then --door is to the right, move right
		newPosX = civilianArray[i][1] - 1
	elseif targetDirection == 2 then --door is to the left, move lefts
		newPosX = civilianArray[i][1] + 1
	elseif targetDirection == 4 then --guess idiot
		newPosY = civilianArray[i][2] - 1
	elseif targetDirection == 8 then --you're stupid
		newPosY = civilianArray[i][2] + 1
	elseif targetDirection == 5 then --5 would be up left
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY) < movementX then
					newPosX = civilianArray[i][1] - 1
				else
					newPosY = civilianArray[i][2] - 1
				end
			end
		end
		--correct so far
	elseif targetDirection == 6 then --up left
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY) < movementX then
					newPosX = civilianArray[i][1] + 1
				else
					newPosY = civilianArray[i][2] - 1
				end
			else
				if math.random(1, movementX+movementY) < movementY then
					newPosY = civilianArray[i][2] - 1
				else
					newPosX = civilianArray[i][1] + 1
				end
			end
		end
	elseif targetDirection == 9 then --down left
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY) < movementX then
					newPosX = civilianArray[i][1] - 1
				else
					newPosY = civilianArray[i][2] + 1
				end
			else
				if math.random(1, movementX+movementY) < movementY then
					newPosY = civilianArray[i][2] + 1
				else
					newPosX = civilianArray[i][1] - 1
				end
			end
		end
	elseif targetDirection == 10 then --down right
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY) < movementX then
					newPosX = civilianArray[i][1] + 1
				else
					newPosY = civilianArray[i][2] + 1
				end
			else
				if math.random(1, movementX+movementY) < movementY then
					newPosY = civilianArray[i][2] + 1
				else
					newPosX = civilianArray[i][1] + 1
				end
			end
		end
	end
	targetDirection = 0
	movementX = 0
	movementY = 0
end

function checkWalls ( i )
	--first check doors
	if 1==2 then
		--!!temp
	else
		if newPosX ~= civilianArray[i][1] then --start with moving X axis and checking left and right walls
			for k=1, roomCount do
				if (newPosX < rightWallArray[k][1]+5 and newPosX > rightWallArray[k][1]-5) then --check for right X wise
					if (newPosY > rightWallArray[k][2]-5 and newPosY < rightWallArray[k][4]+5) then --check for right wall Y wise
						--wall is hit
						newPosX = civilianArray[i][1] --stop civ from moving X wise
						if civilianArray[i][2] > zombieArray[civilianArray[i].target][2] then --zombie is at least slightly above
							newPosY = newPosY + 1
						else --!!nearest corner next
							newPosY = newPosY - 1
						end
						--now just to make sure we didn't hit another wall
						if (newPosY > upperWallArray[k][2]-5 and newPosY < upperWallArray[k][4]+5) then
							if (newPosX < upperWallArray[k][3]+5 and newPosX > upperWallArray[k][1]-5) then
								newPosY = civilianArray[i][2]
							end
						end
						if (newPosY > lowerWallArray[k][2]-5 and newPosY < lowerWallArray[k][4]+5) then
							if (newPosX < lowerWallArray[k][3]+5 and newPosX > lowerWallArray[k][1]-5) then
								newPosY = civilianArray[i][2]
							end
						end
					end
				elseif (newPosX < leftWallArray[k][1]+5 and newPosX > leftWallArray[k][1]-5) then --check for left X wise
					if (newPosY > leftWallArray[k][2]-5 and newPosY < leftWallArray[k][4]+5) then --check for left wall Y wise
						--wall is hit
						newPosX = civilianArray[i][1] --stop civ from moving X wise
						if civilianArray[i][2] > civilianArray[i].targetY then --zombie is at least slightly above
							newPosY = newPosY + 1
						else --!!nearest corner next
							newPosY = newPosY - 1
						end
						--now just to make sure we didn't hit another wall
						if (newPosY > upperWallArray[k][2]-5 and newPosY < upperWallArray[k][4]+5) then
							if (newPosX < upperWallArray[k][3]+5 and newPosX > upperWallArray[k][1]-5) then
								newPosY = civilianArray[i][2]
							end
						end
						if (newPosY > lowerWallArray[k][2]-5 and newPosY < lowerWallArray[k][4]+5) then
							if (newPosX < lowerWallArray[k][3]+5 and newPosX > lowerWallArray[k][1]-5) then
								newPosY = civilianArray[i][2]
							end
						end
					end	
				end
			end
		end
		if newPosY ~= civilianArray[i][2] then --check Y axis
			for k=1, roomCount do
				if (newPosY < upperWallArray[k][2]+5 and newPosY > upperWallArray[k][2]-5) then
					if (newPosX < upperWallArray[k][3]+5 and newPosX > upperWallArray[k][1]-5) then
						newPosY = civilianArray[i][2] --stop movement that way
					end
					if civilianArray[i][1] > zombieArray[civilianArray[i].target][1] then --zombie is at least slightly above
						newPosX = newPosX + 1
					else --!!nearest corner next
						newPosX = newPosX - 1
					end
					--now just to make sure we didn't hit another wall
					if (newPosX < rightWallArray[k][1]+5 and newPosX > rightWallArray[k][1]-5) then
						if (newPosY > rightWallArray[k][2]-5 and newPosY < rightWallArray[k][4]+5) then
							newPosX = civilianArray[i][1]
						end
					end
					if (newPosX < leftWallArray[k][1]+5 and newPosX > leftWallArray[k][1]-5) then
						if (newPosY > leftWallArray[k][2]-5 and newPosY < leftWallArray[k][4]+5) then
							newPosX = civilianArray[i][1]
						end
					end
				elseif (newPosY > lowerWallArray[k][2]-5 and newPosY < lowerWallArray[k][4]+5) then
					if (newPosX < lowerWallArray[k][3]+5 and newPosX > lowerWallArray[k][1]-5) then
						newPosY = civilianArray[i][2] --stop movement that way
					end
					if civilianArray[i][1] > zombieArray[civilianArray[i].target][1] then --zombie is at least slightly above
						newPosX = newPosX + 1
					else --!!nearest corner next
						newPosX = newPosX - 1
					end
					if (newPosX < rightWallArray[k][1]+5 and newPosX > rightWallArray[k][1]-5) then
						if (newPosY > rightWallArray[k][2]-5 and newPosY < rightWallArray[k][4]+5) then
							newPosX = civilianArray[i][1]
						end
					end
					if (newPosX < leftWallArray[k][1]+5 and newPosX > leftWallArray[k][1]-5) then
						if (newPosY > leftWallArray[k][2]-5 and newPosY < leftWallArray[k][4]+5) then
							newPosX = civilianArray[i][1]
						end
					end
				end
			end
		end
	end
end

function moveAwayFromZombie ( i )
	newPosX = civilianArray[i][1]
	newPosY = civilianArray[i][2]
	movementX = civilianArray[i][1]-civilianArray[i].targetX
	movementY = civilianArray[i][2]-civilianArray[i].targetY
	if movementX < 0 then
		movementX = movementX*-1
	end
	if movementY < 0 then
		movementY = movementY*-1
	end
	--first see if it's left or right
	--target direction is 1 for left, 2 for right, 4 for up and 8 for down
	--example, left and up would be 5	
	if civilianArray[i][1] < zombieArray[civilianArray[i].target][1] then
		targetDirection = targetDirection + 2
	elseif civilianArray[i][1] > zombieArray[civilianArray[i].target][1] then
		targetDirection = targetDirection + 1
	end
	--see if it's up or down
	if civilianArray[i][2] < zombieArray[civilianArray[i].target][2] then
		targetDirection = targetDirection + 8
	elseif civilianArray[i][2] > zombieArray[civilianArray[i].target][2] then
		targetDirection = targetDirection + 4
	end	
	--now we have the direction! now we move the OPPOSITE way
	if targetDirection == 1 then --zombie is to the left, move right !!or random up/down too
		newPosX = civilianArray[i][1] + 1
	elseif targetDirection == 2 then --zombie is to the right, move left !!or random up/down too
		newPosX = civilianArray[i][1] - 1
	elseif targetDirection == 4 then --guess
		newPosY = civilianArray[i][2] + 1
	elseif targetDirection == 8 then --guess
		newPosY = civilianArray[i][2] - 1
	elseif targetDirection == 5 then --5 would be up left
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY) < movementX then
					newPosX = civilianArray[i][1] + 1
				else
					newPosY = civilianArray[i][2] + 1
				end
			else
				if math.random(1, movementX+movementY) < movementY then
					newPosY = civilianArray[i][2] + 1
				else
					newPosX = civilianArray[i][1] + 1
				end
			end
		end
	elseif targetDirection == 6 then --up right
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY) < movementX then
					newPosX = civilianArray[i][1] - 1
				else
					newPosY = civilianArray[i][2] + 1
				end
			else
				if math.random(1, movementX+movementY) < movementY then
					newPosY = civilianArray[i][2] + 1
				else
					newPosX = civilianArray[i][1] - 1
				end
			end
		end
	elseif targetDirection == 9 then --down left
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY) < movementX then
					newPosX = civilianArray[i][1] + 1
				else
					newPosY = civilianArray[i][2] - 1
				end
			else
				if math.random(1, movementX+movementY) < movementY then
					newPosY = civilianArray[i][2] - 1
				else
					newPosX = civilianArray[i][1] + 1
				end
			end
		end
	elseif targetDirection == 10 then --down right
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY) < movementX then
					newPosX = civilianArray[i][1] - 1
				else
					newPosY = civilianArray[i][2] - 1
				end
			else
				if math.random(1, movementX+movementY) < movementY then
					newPosY = civilianArray[i][2] - 1
				else
					newPosX = civilianArray[i][1] - 1
				end
			end
		end
	end
	targetDirection = 0
	movementX = 0
	movementY = 0
end

function moveCivs( event )
	--first check if there even are zombies
	if zombieCount > 0 then
		for i=1, #civilianArray do
			if civilianArray[i].status == "bitten" then --first see if they're infected, because then they don't move
					--do nothing
			else 
				if civilianArray[i].currentRoom == 0 then --find closest door
					doorDist = 9999
					for m=1,#doorArray do
						findClosestDoor( i, m )
					end
				end
				if doorDist < 6 then
					civilianArray[i].targetDist = 9999
					civilianArray[i].targetType = "none"
					civilianArray[i].target = 0
					civilianArray[i].targetX = 0
					civilianArray[i].targetY = 0
				end
				for j=1,#zombieArray do
					findClosestZombie ( i, j ) --detect nearest zombie
				end	
				print(civilianArray[i].targetType, doorDist)
				--now we found the closest zombie and door. if zombie is more than 50 units away, then civilian won't move
				if civilianArray[i].targetDist > 50 then
					civilianArray[i].targetType = "none"
					civilianArray[i].target = 0
					civilianArray[i].targetDist = 9999
					civilianArray[i].targetX = 0
					civilianArray[i].targetY = 0
				elseif civilianArray[i].targetType == "door" then --move towards that door it saw
					moveTowardsDoor( i )
					--new direction set, check if the new positions hit a wall
					if doorDist > 10 then
						checkWalls( i )
					end
					--this is where we move the civilians to the new positions
					civilianArray[i][1] = newPosX
					civilianArray[i][2] = newPosY
				elseif civilianArray[i].targetType == "zombie" then
					--find zombie direction and run away
					moveAwayFromZombie( i )
					--check if the new positions hit a wall
					if doorDist > 10 then
						checkWalls( i )
					end
					--this is where we move the civilians to the new positions
					civilianArray[i][1] = newPosX
					civilianArray[i][2] = newPosY
				end
			end				
		--and reset these variables too thanks
		targetDirection = 0
		end
	end
end

function findClosestCiv ( i, j )
	for j = 1, #civilianArray do
		--compare distances to all civilian actors			
		distX = zombieArray[i][1]-civilianArray[j][1]
		--no negative numbers please	
		if distX < 0 then
			distX = distX*-1
		end
		distY = zombieArray[i][2]-civilianArray[j][2]
		--no negative numbers please
		if distY < 0 then
			distY = distY*-1
		end
		distanceArray[j] = distX + distY
		--now check if this one's the closest
		if distanceArray[j] < zombieArray[i].targetDist then
			zombieArray[i].targetDist = distanceArray[j]
			zombieArray[i].target = j
			zombieArray[i].targetType = "civ"
			zombieArray[i].targetX = civilianArray[j][1]
			zombieArray[i].targetY = civilianArray[j][2]
		end
	end
end

function findClosestMil ( i, j )
	if zombieArray[i].targetDist == 0 then
		zombieArray[i].targetDist = 9999
	end
	--compare distances to all military actors			
	DistX = zombieArray[i][1]-militaryArray[j][1]
	--no negative numbers please	
	if DistX < 0 then
		DistX = DistX*-1
	end
	DistY = zombieArray[i][2]-militaryArray[j][2]
	--no negative numbers please
	if DistY < 0 then
		DistY = DistY*-1
	end
	distanceArray[j] = DistX + DistY
	--now check if this one's the closest
	if distanceArray[j] < zombieArray[i].targetDist then
		zombieArray[i].targetDist = distanceArray[j]
		zombieArray[i].target = j
		zombieArray[i].targetType = "mil"
		zombieArray[i].targetX = militaryArray[j][1]
		zombieArray[i].targetY = militaryArray[j][2]
	end
end

function moveTowardsCiv ( i )
	newPosX = zombieArray[i][1]
	newPosY = zombieArray[i][2]
	movementX = zombieArray[i][1]-zombieArray[i].targetX
	movementY = zombieArray[i][2]-zombieArray[i].targetY
	if movementX < 0 then
		movementX = movementX*-1
	end
	if movementY < 0 then
		movementY = movementY*-1
	end
	if zombieArray[i][1] < zombieArray[i].targetX then
		targetDirection = targetDirection + 2
	elseif zombieArray[i][1] > zombieArray[i].targetX then
		targetDirection = targetDirection + 1
	end
	--see if it's up or down
	if zombieArray[i][2] > zombieArray[i].targetY then
		targetDirection = targetDirection + 4
	elseif zombieArray[i][2] < zombieArray[i].targetY then
		targetDirection = targetDirection + 8
	end
	--now move up or down depending on targetDirection
	if targetDirection == 1 then --it's left of the zombie, so move left
		newPosX = zombieArray[i][1] - 1
	elseif targetDirection == 2 then --right of the zombie, move right
		newPosX = zombieArray[i][1] + 1
	elseif targetDirection == 4 then --move up
		newPosY = zombieArray[i][2] - 1
	elseif targetDirection == 5 then --up left
		--see if it's further left than up
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY) < movementX then
					newPosX = zombieArray[i][1] - 1
				else
					newPosY = zombieArray[i][2] - 1
				end
			else
				if math.random(1, movementX+movementY) < movementY then
					newPosY = zombieArray[i][2] - 1
				else
					newPosX = zombieArray[i][1] - 1
				end
			end
		end
	elseif targetDirection == 6 then --up right
		--see if it's further right than up
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY ) < movementX then
					newPosX = zombieArray[i][1] + 1
				else
					newPosY = zombieArray[i][2] - 1
				end
			else
				if math.random(1, movementX+movementY) < movementY then
					newPosY = zombieArray[i][2] - 1
				else
					newPosX = zombieArray[i][1] + 1
				end
			end
		end
	elseif targetDirection == 8 then --DOWN NIGGA
		newPosY = zombieArray[i][2] + 1
	elseif targetDirection == 9 then --down left
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY) < movementX then
					newPosX = zombieArray[i][1] - 1
				else
					newPosY = zombieArray[i][2] + 1
				end
			else
				if math.random(1, movementX+movementY) < movementY then
					newPosY = zombieArray[i][2] + 1
				else
					newPosX = zombieArray[i][1] - 1
				end
			end
		end			
	elseif targetDirection == 10 then --down right
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY) < movementX then
					newPosX = zombieArray[i][1] + 1
				else
					newPosY = zombieArray[i][2] + 1
				end
			else
				if math.random(1, movementX+movementY) < movementY then
					newPosY = zombieArray[i][2] + 1
				else
					newPosX = zombieArray[i][1] + 1
				end
			end
		end
	end
	targetDirection = 0
	movementX = 0
	movementY = 0
end

function moveTowardsMil ( i )
	newPosX = zombieArray[i][1]
	newPosY = zombieArray[i][2]
	movementX = zombieArray[i][1]-zombieArray[i].targetX
	movementY = zombieArray[i][2]-zombieArray[i].targetY
	if movementX < 0 then
		movementX = movementX*-1
	end
	if movementY < 0 then
		movementY = movementY*-1
	end
	if zombieArray[i][1] < zombieArray[i].targetX then
		targetDirection = targetDirection + 2
	elseif zombieArray[i][1] > zombieArray[i].targetX then
		targetDirection = targetDirection + 1
	end
	--see if it's up or down
	if zombieArray[i][2] > zombieArray[i].targetY then
		targetDirection = targetDirection + 4
	elseif zombieArray[i][2] < zombieArray[i].targetY then
		targetDirection = targetDirection + 8
	end
	--now move up or down depending on targetDirection
	if targetDirection == 1 then --it's left of the zombie, so move left
		newPosX = zombieArray[i][1] - 1
	elseif targetDirection == 2 then --right of the zombie, move right
		newPosX = zombieArray[i][1] + 1
	elseif targetDirection == 4 then --move up
		newPosY = zombieArray[i][2] - 1
	elseif targetDirection == 5 then --up left
		--see if it's further left than up
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY) < movementX then
					newPosX = zombieArray[i][1] - 1
				else
					newPosY = zombieArray[i][2] - 1
				end
			else
				if math.random(1, movementX+movementY) < movementY then
					newPosY = zombieArray[i][2] - 1
				else
					newPosX = zombieArray[i][1] - 1
				end
			end
		end
	elseif targetDirection == 6 then --up right
		--see if it's further right than up
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY ) < movementX then
					newPosX = zombieArray[i][1] + 1
				else
					newPosY = zombieArray[i][2] - 1
				end
			else
				if math.random(1, movementX+movementY) < movementY then
					newPosY = zombieArray[i][2] - 1
				else
					newPosX = zombieArray[i][1] + 1
				end
			end
		end
	elseif targetDirection == 8 then --DOWN NIGGA
		newPosY = zombieArray[i][2] + 1
	elseif targetDirection == 9 then --down left
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY) < movementX then
					newPosX = zombieArray[i][1] - 1
				else
					newPosY = zombieArray[i][2] + 1
				end
			else
				if math.random(1, movementX+movementY) < movementY then
					newPosY = zombieArray[i][2] + 1
				else
					newPosX = zombieArray[i][1] - 1
				end
			end
		end			
	elseif targetDirection == 10 then --down right
		for j=1,2 do
			if movementX > movementY then
				if math.random(1, movementX+movementY) < movementX then
					newPosX = zombieArray[i][1] + 1
				else
					newPosY = zombieArray[i][2] + 1
				end
			else
				if math.random(1, movementX+movementY) < movementY then
					newPosY = zombieArray[i][2] + 1
				else
					newPosX = zombieArray[i][1] + 1
				end
			end
		end
	end
	targetDirection = 0
	movementX = 0
	movementY = 0
end

function checkWallsZed ( i )
	if zombieArray[i].targetType == "civ" then --it's targetting a civ
		if newPosX ~= zombieArray[i][1] then
			for k=1, roomCount do
				if (newPosX < rightWallArray[k][1]+5 and newPosX > rightWallArray[k][1]-5) then --check for right X wise
					if (newPosY > rightWallArray[k][2]-5 and newPosY < rightWallArray[k][4]+5) then --check for right wall Y wise
						--wall is hit
						newPosX = zombieArray[i][1] --stop civ from moving X wise
						if zombieArray[i][2] > civilianArray[zombieArray[i].target][2] then --zombie is at least slightly above
							newPosY = newPosY - 1
						else --!!nearest corner next
							newPosY = newPosY + 1
						end
						--now just to make sure we didn't hit another wall
						if (newPosY > upperWallArray[k][2]-5 and newPosY < upperWallArray[k][4]+5) then
							if (newPosX < upperWallArray[k][3]+5 and newPosX > upperWallArray[k][1]-5) then
								newPosY = zombieArray[i][2]
							end
						end
						if (newPosY > lowerWallArray[k][2]-5 and newPosY < lowerWallArray[k][4]+5) then
							if (newPosX < lowerWallArray[k][3]+5 and newPosX > lowerWallArray[k][1]-5) then
								newPosY = zombieArray[i][2]
							end
						end
					end
				elseif (newPosX < leftWallArray[k][1]+5 and newPosX > leftWallArray[k][1]-5) then --check for left X wise
					if (newPosY > leftWallArray[k][2]-5 and newPosY < leftWallArray[k][4]+5) then --check for left wall Y wise
						--wall is hit
						newPosX = zombieArray[i][1] --stop civ from moving X wise
						if zombieArray[i][2] > civilianArray[zombieArray[i].target][2] then --zombie is at least slightly above
							newPosY = newPosY - 1
						else --!!nearest corner next
							newPosY = newPosY + 1
						end
						--now just to make sure we didn't hit another wall
						if (newPosY > upperWallArray[k][2]-5 and newPosY < upperWallArray[k][4]+5) then
							if (newPosX < upperWallArray[k][3]+5 and newPosX > upperWallArray[k][1]-5) then
								newPosY = zombieArray[i][2]
							end
						end
						if (newPosY > lowerWallArray[k][2]-5 and newPosY < lowerWallArray[k][4]+5) then
							if (newPosX < lowerWallArray[k][3]+5 and newPosX > lowerWallArray[k][1]-5) then
								newPosY = zombieArray[i][2]
							end
						end
					end
				end	
			end
		end
		if newPosY ~= zombieArray[i][2] then --check Y axis
			for k=1, roomCount do
				if (newPosY < upperWallArray[k][2]+5 and newPosY > upperWallArray[k][2]-5) then
					if (newPosX < upperWallArray[k][3]+5 and newPosX > upperWallArray[k][1]-5) then
						newPosY = zombieArray[i][2] --stop movement that way
					end
					if zombieArray[i][1] > civilianArray[zombieArray[i].target][1] then --zombie is at least slightly right
						newPosX = newPosX - 1
					else --!!nearest corner next
						newPosX = newPosX + 1
					end
					--now just to make sure we didn't hit another wall
					if (newPosX < rightWallArray[k][1]+5 and newPosX > rightWallArray[k][1]-5) then
						if (newPosY > rightWallArray[k][2]-5 and newPosY < rightWallArray[k][4]+5) then
							newPosX = zombieArray[i][1]
						end
					end
					if (newPosX < leftWallArray[k][1]+5 and newPosY > leftWallArray[k][1]-5) then
						if (newPosX > leftWallArray[k][2]-5 and newPosY < leftWallArray[k][4]+5) then
							newPosX = zombieArray[i][1]
						end
					end
				elseif (newPosY > lowerWallArray[k][2]-5 and newPosY < lowerWallArray[k][4]+5) then
					if (newPosX < lowerWallArray[k][3]+5 and newPosX > lowerWallArray[k][1]-5) then
						newPosY = zombieArray[i][2] --stop movement that way
					end
					if zombieArray[i][1] > civilianArray[zombieArray[i].target][1] then --zombie is at least slightly right
						newPosX = newPosX - 1
					else --!!nearest corner next
						newPosX = newPosX + 1
					end
					if (newPosX < rightWallArray[k][1]+5 and newPosX > rightWallArray[k][1]-5) then
						if (newPosY > rightWallArray[k][2]-5 and newPosY < rightWallArray[k][4]+5) then
							newPosX = zombieArray[i][1]
						end
					end
					if (newPosX < leftWallArray[k][1]+5 and newPosX > leftWallArray[k][1]-5) then
						if (newPosY > leftWallArray[k][2]-5 and newPosY < leftWallArray[k][4]+5) then
							newPosX = zombieArray[i][1]
						end
					end
				end
			end
		end
	elseif zombieArray[i].targetType == "mil" then --targetting military
		if newPosX ~= zombieArray[i][1] then
			for k=1, roomCount do
				if (newPosX < rightWallArray[k][1]+5 and newPosX > rightWallArray[k][1]-5) then --check for right X wise
					if (newPosY > rightWallArray[k][2]-5 and newPosY < rightWallArray[k][4]+5) then --check for right wall Y wise
						--wall is hit
						newPosX = zombieArray[i][1] --stop civ from moving X wise
						if zombieArray[i][2] > militaryArray[zombieArray[i].target][2] then --zombie is at least slightly above
							newPosY = newPosY - 1
						else --!!nearest corner next
							newPosY = newPosY + 1
						end
						--now just to make sure we didn't hit another wall
						if (newPosY > upperWallArray[k][2]-5 and newPosY < upperWallArray[k][4]+5) then
							if (newPosX < upperWallArray[k][3]+5 and newPosX > upperWallArray[k][1]-5) then
								newPosY = zombieArray[i][2]
							end
						end
						if (newPosY > lowerWallArray[k][2]-5 and newPosY < lowerWallArray[k][4]+5) then
							if (newPosX < lowerWallArray[k][3]+5 and newPosX > lowerWallArray[k][1]-5) then
								newPosY = zombieArray[i][2]
							end
						end
					end
				elseif (newPosX < leftWallArray[k][1]+5 and newPosX > leftWallArray[k][1]-5) then --check for left X wise
					if (newPosY > leftWallArray[k][2]-5 and newPosY < leftWallArray[k][4]+5) then --check for left wall Y wise
						--wall is hit
						newPosX = zombieArray[i][1] --stop civ from moving X wise
						if zombieArray[i][2] > militaryArray[zombieArray[i].target][2] then --zombie is at least slightly above
							newPosY = newPosY - 1
						else --!!nearest corner next
							newPosY = newPosY + 1
						end
						--now just to make sure we didn't hit another wall
						if (newPosY > upperWallArray[k][2]-5 and newPosY < upperWallArray[k][4]+5) then
							if (newPosX < upperWallArray[k][3]+5 and newPosX > upperWallArray[k][1]-5) then
								newPosY = zombieArray[i][2]
							end
						end
						if (newPosY > lowerWallArray[k][2]-5 and newPosY < lowerWallArray[k][4]+5) then
							if (newPosX < lowerWallArray[k][3]+5 and newPosX > lowerWallArray[k][1]-5) then
								newPosY = zombieArray[i][2]
							end
						end
					end
				end	
			end
		end
		if newPosY ~= zombieArray[i][2] then --check Y axis
			for k=1, roomCount do
				if (newPosY < upperWallArray[k][2]+5 and newPosY > upperWallArray[k][2]-5) then
					if (newPosX < upperWallArray[k][3]+5 and newPosX > upperWallArray[k][1]-5) then
						newPosY = zombieArray[i][2] --stop movement that way
					end
					if zombieArray[i][1] > militaryArray[zombieArray[i].target][1] then --zombie is at least slightly right
						newPosX = newPosX - 1
					else --!!nearest corner next
						newPosX = newPosX + 1
					end
					--now just to make sure we didn't hit another wall
					if (newPosX < rightWallArray[k][1]+5 and newPosX > rightWallArray[k][1]-5) then
						if (newPosY > rightWallArray[k][2]-5 and newPosY < rightWallArray[k][4]+5) then
							newPosX = zombieArray[i][1]
						end
					end
					if (newPosX < leftWallArray[k][1]+5 and newPosY > leftWallArray[k][1]-5) then
						if (newPosX > leftWallArray[k][2]-5 and newPosY < leftWallArray[k][4]+5) then
							newPosX = zombieArray[i][1]
						end
					end
				elseif (newPosY > lowerWallArray[k][2]-5 and newPosY < lowerWallArray[k][4]+5) then
					if (newPosX < lowerWallArray[k][3]+5 and newPosX > lowerWallArray[k][1]-5) then
						newPosY = zombieArray[i][2] --stop movement that way
					end
					if zombieArray[i][1] > militaryArray[zombieArray[i].target][1] then --zombie is at least slightly right
						newPosX = newPosX - 1
					else --!!nearest corner next
						newPosX = newPosX + 1
					end
					if (newPosX < rightWallArray[k][1]+5 and newPosX > rightWallArray[k][1]-5) then
						if (newPosY > rightWallArray[k][2]-5 and newPosY < rightWallArray[k][4]+5) then
							newPosX = zombieArray[i][1]
						end
					end
					if (newPosX < leftWallArray[k][1]+5 and newPosX > leftWallArray[k][1]-5) then
						if (newPosY > leftWallArray[k][2]-5 and newPosY < leftWallArray[k][4]+5) then
							newPosX = zombieArray[i][1]
						end
					end
				end
			end
		end
	end
end

function moveZombies( event )
	--!!take all the civilians and move them, not doing that yet, need rooms and shit first
	--then move the zombies
	for i=1, #zombieArray do
		--detect closest civilian
		for j=1,#civilianArray do
			findClosestCiv( i, j )
		end
		--now see if there's a military closer
		for j=1,#militaryArray do
			findClosestMil( i, j )
		end
		--see which is closer
		if zombieArray[i].targetType == "civ" then
			--now if we're within 5 units or so we'll set the zombie to infect the civilian on a timer and prevent him from moving
			if zombieArray[i].targetDist < 10 then --circle size is 5, so this is obviously 10 for some reason? will have to change with pinch and zoom
				civilianArray[zombieArray[i].target].status = "bitten"
				infectBool = true --infectBool just stops the dude from moving
			end
			if infectBool == true then --civ is being eaten
				--do nothing
			else
				moveTowardsCiv( i )
				checkWallsZed( i )
				zombieArray[i][1] = newPosX
				zombieArray[i][2] = newPosY
			end
		elseif zombieArray[i].targetType == "mil" then --target military
			if zombieArray[i].targetDist < 10 then --circle size is 5, so this is obviously 10 for some reason? will have to change with pinch and zoom
				if #militaryArray > 0 then
					militaryArray[zombieArray[i].target].status = "bitten"
					militaryArray[zombieArray[i].target].bittenBy = i
				end
				infectBool = true --infectBool just stops the dude from moving
			end
			if infectBool == true then --mil is being eaten
				--do nothing
			else
				moveTowardsMil( i )
				checkWallsZed( i )
				zombieArray[i][1] = newPosX
				zombieArray[i][2] = newPosY
			end
		else
			--do nothing, everyone is dead
		end
		
		--and reset these variables too thanks
		infectBool = false
	end
end

function findClosestZombieMil ( i, j )
	--compare distances to all zombie actors
	distX = militaryArray[i][1]-zombieArray[j][1]
	--no negative numbers please	
	if distX < 0 then
		distX = distX*-1
	end
	distY = militaryArray[i][2]-zombieArray[j][2]
	--no negative numbers please
	if distY < 0 then
		distY = distY*-1
	end
	distanceArray[j] = distX + distY
	--now we have the distance, see if it's the closest
	if (distanceArray[j] < militaryArray[i].targetDist and zombieArray[j].currentRoom == militaryArray[i].currentRoom) then
		militaryArray[i].targetDist = distanceArray[j]
		militaryArray[i].target = j
	end
end

function milFire ( i, j )
	if zombieCount > 0 then
		for i=1,#militaryArray do
			if militaryArray[i].fireCounter >= 15 then
			--find closest zombie
				for j=1,#zombieArray do
					findClosestZombieMil ( i, j )
				end
				zedTarget = militaryArray[i].target
				if militaryArray[i].target > 0 then
					milLines[i] = {militaryArray[i][1], militaryArray[i][2], zombieArray[militaryArray[i].target][1], zombieArray[militaryArray[i].target][2]}
					if militaryArray[i].targetDist > 50 then --too far away, don't shoot
						--do nothing
					else --shoot the fucker
						milLines[i].fire = 1
						zombieArray[militaryArray[i].target].lifeLeft = zombieArray[militaryArray[i].target].lifeLeft - 10
						if zombieArray[militaryArray[i].target].lifeLeft < 1 then --turn into zombie
							killZombie( zedTarget )
						end
						militaryArray[i].fireCounter = 0
					end
				end
			end
			militaryArray[i].fireCounter = militaryArray[i].fireCounter + 1
		end
	end
end

function renderOut()
	local tempTime = system.getTimer()
	achTime = constants.timePlayed + (tempTime - startTime)
	--first clear your display
    for i=1, #world do
			world[i]:removeSelf()
			world[i]=nil
    end
	--now check to see if the people are about to move
	if moveCounter == 3	then --!! this is to see how many ticks we trigger this in or whatever
		moveZombies()
		eatCivs()
		moveCounter = 0
	else	
		moveCounter = moveCounter + 1
	end
	if moveCounterCiv == 2 then
		moveCivs()
		moveCounterCiv = 0
	else
		moveCounterCiv = moveCounterCiv + 1
	end
	--now military needs to fire
	milFire()
	--!!temporary random spawns for infinity mode
	if constants.currentLevel == 11 then
		if infCounter == randomSpawn then
			spawnRandom()
			infCounter = 0
			randomSpawn = math.random(30, 150)
			print("next civ in: ", randomSpawn)
		else
			infCounter = infCounter + 1
		end
		if milCounter == randomMilSpawn then
			spawnRandomMil()
			milCounter = 0
			randomMilSpawn = math.random(60, 300)
			print("next soldier in: ", randomMilSpawn)
		else
			milCounter = milCounter + 1
		end
	end
		
	--inserting the world map
	levelMap = display.newRect(mapSize[1][1]+(mapSize[1][3]/2),mapSize[1][2]+(mapSize[1][4]/2),mapSize[1][3],mapSize[1][4])
    levelMap.strokeWidth = 4
    levelMap:setFillColor(  1, 1, 1  )
    levelMap:setStrokeColor( 0.5, 0.5, 0.5 )
	levelMap.xScale = 1
    table.insert(world,levelMap)
	
    --now lets fill up that display
    for i=1,#roomArray do
        myRectangle = display.newRect(roomArray[i][1]+(roomArray[i][3]/2),roomArray[i][2]+(roomArray[i][4]/2),roomArray[i][3],roomArray[i][4])
        myRectangle.strokeWidth = 2
        myRectangle:setFillColor(  0.52, 0.81, 0.93  )
        myRectangle:setStrokeColor( 0 )
        table.insert(world,myRectangle)
		--wall array is start x, start y, end x, end y and length
		leftWallArray[i] = {roomArray[i][1], roomArray[i][2], roomArray[i][1], roomArray[i][2]+roomArray[i][4], roomArray[i][4]}
		rightWallArray[i] = {roomArray[i][1]+roomArray[i][3], roomArray[i][2], roomArray[i][1]+roomArray[i][3], roomArray[i][2]+roomArray[i][4], roomArray[i][4]}
		upperWallArray[i] = {roomArray[i][1], roomArray[i][2], roomArray[i][1]+roomArray[i][3], roomArray[i][2], roomArray[i][3]}
		lowerWallArray[i] = {roomArray[i][1], roomArray[i][2]+roomArray[i][4], roomArray[i][1]+roomArray[i][3], roomArray[i][2]+roomArray[i][4], roomArray[i][3]}
		leftWallArray[i].room = i
		rightWallArray[i].room = i
		upperWallArray[i].room = i
		lowerWallArray[i].room = i
		--[[print("left wall", leftWallArray[1][1], leftWallArray[1][2], leftWallArray[1][3], leftWallArray[1][4], leftWallArray[1][5], leftWallArray[i].room)
		print("right wall", rightWallArray[1][1], rightWallArray[1][2], rightWallArray[1][3], rightWallArray[1][4], rightWallArray[1][5], rightWallArray[i].room)
		print("upper wall", upperWallArray[1][1], upperWallArray[1][2], upperWallArray[1][3], upperWallArray[1][4], upperWallArray[1][5], upperWallArray[i].room)
		print("lower wall", lowerWallArray[1][1], lowerWallArray[1][2], lowerWallArray[1][3], lowerWallArray[1][4], lowerWallArray[1][5], lowerWallArray[i].room)]]--
    end
	
	--add the doors
	for i=1,doorCount do	
		if doorType[i] == "V" then --draw a vertical door
			doorArray[i] = display.newRect(doorX[i], doorY[i], 5, 20)
			doorArray[i].room = doorRoom[i]
			for j=1, roomCount do
				
				if (doorArray[i].x == leftWallArray[j][1] and doorArray[i].room == leftWallArray[j].room) then
					doorArray[i].wall = "left"
				end
				if doorArray[i].x == rightWallArray[j][1] and doorArray[i].room == rightWallArray[j].room then
					doorArray[i].wall = "right"
				end
			end
		else --draw a horizontal door
			doorArray[i] = display.newRect(doorX[i], doorY[i], 20, 5)
			doorArray[i].room = doorRoom[i]
			for j=1, roomCount do
				if (doorArray[i].y == upperWallArray[j][2] and doorArray[i].room == upperWallArray[j].room) then
					doorArray[i].wall = "upper"
				end
				if doorArray[i].y == lowerWallArray[j][2] and doorArray[i].room == lowerWallArray[j].room then
					doorArray[i].wall = "lower"
				end
			end
		end
		doorArray[i].strokeWidth = 0
		doorArray[i]:setFillColor( 0.6, 0.25, 0 )
		table.insert(world,doorArray[i])
	end
	
	--insert civilians
	for i=1,#civilianArray do
		civCircles[i] = display.newCircle(civilianArray[i][1], civilianArray[i][2],5)
		civCircles[i]:setFillColor( 0, 0, 1, 0.8 )
		civCircles[i]:addEventListener( "tap", clickCiv )
		civCircles[i].arrayNumber = i
		table.insert(world,civCircles[i])
		civilianArray[i].currentRoom = 0
		for j=1,#roomArray do
			if (civilianArray[i][1] > roomArray[j][1] and civilianArray[i][1] < roomArray[j][1]+roomArray[j][4]) then --civ is within x of room
				if (civilianArray[i][2] > roomArray[j][2] and civilianArray[i][1] < roomArray[j][2]+roomArray[j][4]) then --civ is within y of room
					civilianArray[i].currentRoom = j
				end
			end
		end
	end
	
	--give us some zombies nigga
	for i=1,#zombieArray do
		zombieCircles[i] = display.newCircle(zombieArray[i][1], zombieArray[i][2],5)
		zombieCircles[i]:setFillColor( 0.8, 0, 0, 0.8 )
		--!!temp added click to kill a zombie to test victory conditions
		zombieCircles[i]:addEventListener( "tap", clickZombie )
		zombieCircles[i].arrayNumber = i
		zombieArray[i].currentRoom = 0
		table.insert(world,zombieCircles[i])
		for j=1,#roomArray do
			if (zombieArray[i][1] > roomArray[j][1] and zombieArray[i][1] < roomArray[j][1]+roomArray[j][4]) then --zombie is within x of room
				if (zombieArray[i][2] > roomArray[j][2] and zombieArray[i][1] < roomArray[j][2]+roomArray[j][4]) then --zombie is within y of room
					zombieArray[i].currentRoom = j
				end
			end
		end
	end
	
	--and some military
	for i=1,#militaryArray do
		milCircles[i] = display.newCircle(militaryArray[i][1], militaryArray[i][2],5)
		milCircles[i]:setFillColor( 0, 0.5, 0.5, 0.8 )
		milCircles[i].arrayNumber = i
		militaryArray[i].currentRoom = 0
		table.insert(world,milCircles[i])
		for j=1,#roomArray do
			if (militaryArray[i][1] > roomArray[j][1] and militaryArray[i][1] < roomArray[j][1]+roomArray[j][4]) then --military is within x of room
				if (militaryArray[i][2] > roomArray[j][2] and militaryArray[i][1] < roomArray[j][2]+roomArray[j][4]) then --military is within y of room
					militaryArray[i].currentRoom = j
				end
			end
		end
		if constants.rangeOn == "Indicator On" then
			milRangeCircles[i] = display.newCircle(militaryArray[i][1], militaryArray[i][2],45)
			milRangeCircles[i]:setFillColor( 0.5, 0.5, 0.5, 0.2 )
			milRangeCircles[i].arrayNumber = i
			table.insert(world,milRangeCircles[i])
		end
		if milLines[i].fire == 1 then
			milLines[i] = display.newLine( milLines[i][1], milLines[i][2], milLines[i][3], milLines[i][4] )
			milLines[i]:setStrokeColor( 0, 0, 0 )
			table.insert(world,milLines[i])
			milLines[i].fire = 0
		end
	end
	--add the click counter
	local tempx, tempy
	if constants.counterLocation == "Bottom Right" then
		tempx = display.contentWidth-20
		tempy = display.contentHeight-20
	elseif constants.counterLocation == "Bottom Left" then
		tempx = 20
		tempy = display.contentHeight-20
	elseif constants.counterLocation == "Top Left" then
		tempx = 20
		tempy = 20
	elseif constants.counterLocation == "Top Right" then
		tempx = display.contentWidth-20
		tempy = 20
	end
	clickRect = display.newRect(tempx, tempy, 15, 15)
	clickRect:setFillColor( 1, 1, 1 )
	clickRect.strokeWidth = 1
	clickRect:setStrokeColor( 0.4, 0.4, 0.4)
	table.insert(world,clickRect)
	clickCounter = display.newText(zombieClicks, tempx, tempy, native.systemFont, 14)
	clickCounter:setFillColor( 0, 0, 0)
	clickCounter.align = "center" 
	table.insert(world,clickCounter)
	
	--add the level timer
	if constants.timerOn == "Timer Shown" then
		timeRect = display.newRect(display.contentCenterX, 20, 80, 25)
		timeRect:setFillColor( 1, 1, 1 )
		timeRect.strokeWidth = 2
		timeRect:setStrokeColor( 0, 0, 0)
		table.insert(world,timeRect)
		timeCounter = display.newText( string.format("%.3f",(system.getTimer()-startTime)*0.001), display.contentCenterX, 20, native.systemFont, 18 )
		timeCounter:setFillColor( 0, 0, 0)
		table.insert(world,timeCounter)
	end
	--check if there are any civilians or military left, if not then you've won, yay
	if #civilianArray + #militaryArray == 0 then
		constants.victory = 1
		endTime = system.getTimer()
		timer.performWithDelay( 200, endScene ) 
		Runtime:removeEventListener( "enterFrame" , renderOut)
	end
	--also check if there are no zombies left and no clicks left, meaning you lost you dick
	if zombieClicks+zombieCount == 0 then
		endTime = system.getTimer()
		timer.performWithDelay( 200, endScene )
		Runtime:removeEventListener( "enterFrame" , renderOut)
	end
	--and check for achievements
	checkAchievements()
	if displayAchievement == true then
		achRect = display.newRect(display.contentCenterX, display.contentHeight-25, 250, 40)
		achRect.strokeWidth = 4
		achRect:setFillColor(  1, 1, 1  )
		achRect:setStrokeColor( 0.5, 0.5, 0.5 )
		table.insert(world,achRect)
		local options = {
			text = achievementText,
			x = display.contentCenterX,
			y = display.contentHeight-20,
			width = 240,
			height = 35,
			fontSize = 12,
			align = "center"
		}
		tempAchText = display.newText( options )
		tempAchText:setFillColor( 0, 0, 0 )
		table.insert(world,tempAchText)
	else
		achRect = nil
		tempAchText = nil
	end
end

	--endscene() was one of my best ideas, it's so useful
function endScene()
	constants.levelTime = endTime - startTime
	constants.civsInfected = tempInfected
	constants.milInfected = tempMilInfected
	constants.zombiesLost = tempLost
	--update stuff on stats screen
	constants.totalInfections = constants.totalInfections + tempInfected
	constants.totalLost = constants.totalLost + tempLost
	constants.gamesPlayed = constants.gamesPlayed + 1
	constants.timePlayed = constants.timePlayed + constants.levelTime
	constants.totalMilInfections = constants.totalMilInfections + tempMilInfected
	tempLost = 0
	tempInfected = 0
	tempMilInfected = 0
	composer.gotoScene( "afterscreen" )
	return true
end

function scene:create( event )
    --init menu-specific variables and audio here
    --make sure to insert objects into sceneGroup
    --get our scene view
    local sceneGroup = self.view

end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    --"will" fires when the scene has been called but it's not on screen yet.
    if ( phase == "will" ) then
        --we position elements here, because we are re-entering the scene
		if constants.scrollSpeed == nil then
			constants.scrollSpeed = 0.05
		end
		createRoom(true)
		for i=1,#civilianArray do
			civilianArray[i].lifeLeft = constants.civHealth
			civilianArray[i].status = "healthy"
			civilianArray[i].targetType = "none"
			civilianArray[i].target = 0
			civilianArray[i].targetDist = 9999
		end
		for i=1,#militaryArray do
			militaryArray[i].lifeLeft = constants.milHealth
			militaryArray[i].status = "healthy"
			militaryArray[i].fireCounter = 0
			militaryArray[i].targetDist = 9999
			militaryArray[i].targetType = "none"
			milLines[i].fire = 0
		end
		display.setDefault( "background", 0, 0, 0 )
		zombieCount = 0
		startTime = system.getTimer()
		achInfections = tonumber(constants.totalInfections)
		achMilInfections = tonumber(constants.totalMilInfections)
		achLost = tonumber(constants.totalLost)
        --"did" fires when the scene is FULLY on the screen.
    elseif ( phase == "did" ) then
        --start runtime listeners like "enterFrame"
        --start timers, transitions, sprite animations.
        Runtime:addEventListener( "enterFrame" , renderOut)
        Runtime:addEventListener( "touch" , moveWorld)
		zombieArray = {}
		print("Scrollspeed: ",constants.scrollSpeed)
		print("Level: ",constants.currentLevel)
    end
	
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        --remove stuff initialized in the "did" phase of the show scene.
        --unallocate timers, transitions, sprite stuff.
        Runtime:removeEventListener( "touch" , moveWorld)
    for i=1, #world do
        world[i]:removeSelf()
        world[i]=nil
    end
	for i=1,#civilianArray do
		table.remove(civilianArray)
	end
	for i=1,#zombieArray do
		table.remove(zombieArray)
	end
	for i=1,#roomX do
		table.remove(roomX)
	end
	for i=1,#roomY do
		table.remove(roomY)
	end
	for i=1,#roomW do
		table.remove(roomW)
	end
	for i=1,#roomH do
		table.remove(roomH)
	end
	for i=1,#roomArray do
		table.remove(roomArray)
	end
	for i=1,#doorX do
		table.remove(doorX)
	end
	for i=1,#doorY do
		table.remove(doorY)
	end
	for i=1,#doorArray do
		table.remove(doorArray)
	end
	for i=1,#milLines do
		table.remove(milLines)
	end
	elseif ( phase == "did" ) then
        --not much to do here, except force removal of the scene after it transitions of screen for optimization.
    end
end

function scene:destroy( event )
    --dispose of all allocated variables and audio in the create function here
    local sceneGroup = self.view

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene