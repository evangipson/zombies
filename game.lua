local composer = require( "composer" )
local constants = require("constants")
local scene = composer.newScene()
local world = {}
local roomArray={}
local roomCount, civCount
local moveWorld
local roomX={}
local roomY={}
local roomW={}
local roomH={}
local civilianArray = {}
local civCircles = {}
local zombieArray = {}
local zombieCircles = {}
local militaryArray = {}
local zombieClicks
local zombieCount = 0
local mapSize={}
local startTime, endTime
local tempInfected = 0
local tempLost = 0

--!!cannot run a second level after afterscreen
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
		--add civilian locations
		civCount = #constants.level0CivX
		for i=1,civCount do
			civilianArray[i]={constants.level0CivX[i],constants.level0CivY[i]}
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
		--add civilian locations
		civCount = #constants.level1CivX
		for i=1,civCount do
			civilianArray[i]={constants.level1CivX[i],constants.level1CivY[i]}
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
		--add civilian locations
		civCount = #constants.level2CivX
		for i=1,civCount do
			civilianArray[i]={constants.level2CivX[i],constants.level2CivY[i]}
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
		--add civilian locations
		civCount = #constants.level3CivX
		for i=1,civCount do
			civilianArray[i]={constants.level3CivX[i],constants.level3CivY[i]}
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
		--add civilian locations
		civCount = #constants.level4CivX
		for i=1,civCount do
			civilianArray[i]={constants.level4CivX[i],constants.level4CivY[i]}
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
		--add civilian locations
		civCount = #constants.level5CivX
		for i=1,civCount do
			civilianArray[i]={constants.level5CivX[i],constants.level5CivY[i]}
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
		--add civilian locations
		civCount = #constants.level6CivX
		for i=1,civCount do
			civilianArray[i]={constants.level6CivX[i],constants.level6CivY[i]}
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
		--add civilian locations
		civCount = #constants.level7CivX
		for i=1,civCount do
			civilianArray[i]={constants.level7CivX[i],constants.level7CivY[i]}
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
		--add civilian locations
		civCount = #constants.level8CivX
		for i=1,civCount do
			civilianArray[i]={constants.level8CivX[i],constants.level8CivY[i]}
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
		--add civilian locations
		civCount = #constants.level9CivX
		for i=1,civCount do
			civilianArray[i]={constants.level9CivX[i],constants.level9CivY[i]}
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
		--add civilian locations
		civCount = #constants.level10CivX
		for i=1,civCount do
			civilianArray[i]={constants.level10CivX[i],constants.level10CivY[i]}
		end
		--add the amount of click things
		zombieClicks = constants.level10Zombies
	end
	--temporary for infinity mode
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
		--add civilian locations
		civCount = #constants.level11CivX
		for i=1,civCount do
			civilianArray[i]={constants.level11CivX[i],constants.level11CivY[i]}
		end
		--add the amount of click things
		zombieClicks = constants.level11Zombies
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
		zombieClicks = zombieClicks - 1
		tempInfected = tempInfected + 1
	else
		print("nope lol")
	end
	return true
end

function killZombie ( event )
	table.remove(zombieArray, event.target.arrayNumber)
	zombieCount = zombieCount - 1
	tempLost = tempLost + 1
	return true
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
		--and the map itself
		mapSize[1][1]=mapSize[1][1]+xScroll
		mapSize[1][2]=mapSize[1][2]+yScroll
    end
    return true
end

function renderOut()
    --first clear your display
    for i=1, #world do
        world[i]:removeSelf()
        world[i]=nil
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
    end
	--insert civilians
	for i=1,#civilianArray do
		civCircles[i] = display.newCircle(civilianArray[i][1], civilianArray[i][2],5)
		civCircles[i]:setFillColor( 0, 0, 1, 0.8 )
		civCircles[i]:addEventListener( "tap", clickCiv )
		civCircles[i].arrayNumber = i
		table.insert(world,civCircles[i])
	end
	
	--give us some zombies nigga
	for i=1,#zombieArray do
		zombieCircles[i] = display.newCircle(zombieArray[i][1], zombieArray[i][2],5)
		zombieCircles[i]:setFillColor( 0.8, 0, 0, 0.8 )
		--!!temp added click to kill a zombie to test victory conditions
		zombieCircles[i]:addEventListener( "tap", killZombie )
		zombieCircles[i].arrayNumber = i
		table.insert(world,zombieCircles[i])
	end
	
	--add the click counter
	local tempx, tempy
	if constants.counterLocation == "Bottom Right" then
		tempx = display.contentWidth-20
		tempy = display.contentHeight-20
	end
	if constants.counterLocation == "Bottom Left" then
		tempx = 20
		tempy = display.contentHeight-20
	end
	if constants.counterLocation == "Top Left" then
		tempx = 20
		tempy = 20
	end
	if constants.counterLocation == "Top Right" then
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
end

	--endscene() was one of my best ideas, it's so useful
function endScene()
	constants.levelTime = endTime - startTime
	constants.civsInfected = tempInfected
	constants.zombiesLost = tempLost
	--update stuff on stats screen
	constants.totalInfections = constants.totalInfections + tempInfected
	constants.totalLost = constants.totalLost + tempLost
		print("templost", constants.totalLost, tempLost)
	constants.gamesPlayed = constants.gamesPlayed + 1
	constants.timePlayed = constants.timePlayed + constants.levelTime
	tempLost = 0
	tempInfected = 0
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
		display.setDefault( "background", 0, 0, 0 )
		zombieCount = 0
		startTime = system.getTimer()
        --"did" fires when the scene is FULLY on the screen.
    elseif ( phase == "did" ) then
        --start runtime listeners like "enterFrame"
        --start timers, transitions, sprite animations.
        Runtime:addEventListener( "enterFrame" , renderOut)
        Runtime:addEventListener( "touch" , moveWorld)
        --add runtime listeners for everything in world
        --[[for i=1,#world do
            world[i]:addEventListener("touch",getInfo)
        end]]--
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