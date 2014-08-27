local composer = require( "composer" )
local constants = require("constants")
local scene = composer.newScene()
local world = {}
mRand = math.random
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

--this function will create a room
--there will be 2 different applications:
--1) initial room creation
--2) everytime the player chooses to leave a room
function detectLevel()
	--check which level player is on and set room variables accordingly
	if constants.currentLevel == 0 then
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
	
	end
	if constants.currentLevel == 2 then
	
	end
	if constants.currentLevel == 3 then
	
	end
	if constants.currentLevel == 4 then
	
	end
	if constants.currentLevel == 5 then
	
	end
	if constants.currentLevel == 6 then
	
	end
	if constants.currentLevel == 7 then
	
	end
	if constants.currentLevel == 8 then
	
	end
	if constants.currentLevel == 9 then
	
	end
	if constants.currentLevel == 10 then
	
	end
end

function clickCiv( event )
	if zombieClicks > 0 then
		--the zombie will be inserted in the next slot in the array, so the zombie count + 1.
		--event.target.arrayNumber is given to the civilians when the map is drawn and is their unique identifier.
		--add civilian to zombie array
		--!!why won't the circles change?!
		print(event.target.arrayNumber)
		--civCircles[1]:setFillColor( 0.4, 1, 1 )
		--civCircles[event.target.arrayNumber]:removeEventListener( "tap", clickCiv )
		zombieArray[zombieCount+1] = {civilianArray[event.target.arrayNumber][1],civilianArray[event.target.arrayNumber][2]}
		--remove it from civilian table
		table.remove(civilianArray, event.target.arrayNumber)
		--increase zombiecount because there's a zombie now
		zombieCount = zombieCount+1
		--this is just test output
		print(zombieArray[1][1],zombieArray[1][2])
		if zombieCount > 1 then
		print(zombieArray[2][1],zombieArray[2][2])
		end
		if zombieCount > 2 then
		print(zombieArray[3][1],zombieArray[3][2])
		end
		print(zombieCount)
		zombieClicks = zombieClicks - 1
		drawZombies()
	else
		print("nope lol")
	end
	return true
end

function drawZombies()
	for i=1,#zombieArray do
		zombieCircles[i] = display.newCircle(zombieArray[i][1], zombieArray[i][2],5)
		zombieCircles[i]:setFillColor( 0.8, 0, 0, 0.8 )
		zombieCircles[i].arrayNumber = i
		print("there's a zombie")
	end
end

function createRoom(init)
	detectLevel()
	--!!case level is 0 then level 0 room count etc below... same for levelSize
	-- add it to the roomArray
	for i=1,roomCount do
		roomArray[i] = {roomX[i], roomY[i], roomW[i], roomH[i]}
	end
	
	--enter this rect in an array for
    --safekeeping afterwards
    --local rectX,rectY
    --if(init==true) then
    --    rectX = display.contentCenterX
    --    rectY = display.contentCenterY
    --else
        --we better get the player's position
        --and then generate the room based on that!
    --end
    --local rectW = mRand(5,10)*10
    --local rectH = mRand(5,10)*10
    --roomArray[roomCount] = {rectX,rectY,rectW,rectH}
    --roomCount=roomCount+1
end

function moveWorld(event)
    local xScroll, yScroll

    if event.phase == "moved" then
        xScroll=((event.xStart-event.x)*-1)*constants.scrollSpeed
        yScroll=((event.yStart-event.y)*-1)*constants.scrollSpeed
		--stop it from scrolling outside map
		if (xScroll+constants.levelSize[1][1]) > 0 then
			xScroll = 0
		end
		if (yScroll+constants.levelSize[1][2])-40 > 0 then
			yScroll = 0
		end
		if (constants.levelSize[1][1]+xScroll) < (display.contentWidth-constants.levelSize[1][3]) then
			xScroll = 0
			constants.levelSize[1][1] = (display.contentWidth-constants.levelSize[1][3])
		end
		if (constants.levelSize[1][2]+yScroll) < (display.contentHeight-constants.levelSize[1][4])-40 then
			yScroll = 0
			constants.levelSize[1][2] = (display.contentHeight-constants.levelSize[1][4])-40
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
		--!!circles stay outside the map and i have no idea why
		end

		--and the map itself
		constants.levelSize[1][1]=constants.levelSize[1][1]+xScroll
		constants.levelSize[1][2]=constants.levelSize[1][2]+yScroll
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
	local levelMap = display.newRect(constants.levelSize[1][1]+(constants.levelSize[1][3]/2),constants.levelSize[1][2]+(constants.levelSize[1][4]/2),constants.levelSize[1][3],constants.levelSize[1][4])
    levelMap.strokeWidth = 4
    levelMap:setFillColor(  1, 1, 1  )
    levelMap:setStrokeColor( 0.5, 0.5, 0.5 )
	levelMap.xScale = 1
    table.insert(world,levelMap)
	
    --now lets fill up that display
    for i=1,#roomArray do
        local myRectangle = display.newRect(roomArray[i][1]+(roomArray[i][3]/2),roomArray[i][2]+(roomArray[i][4]/2),roomArray[i][3],roomArray[i][4])
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
	end
	--add the click counter	
	clickRect = display.newRect(display.contentWidth-10, display.contentHeight-20, 15, 15)
	clickRect:setFillColor( 1, 1, 1 )
	clickRect.strokeWidth = 1
	clickRect:setStrokeColor( 0.4, 0.4, 0.4)
	clickCounter = display.newText(zombieClicks, display.contentWidth-10, display.contentHeight-20, native.systemFont, 14)
	clickCounter:setFillColor( 0, 0, 0)
end

function scene:create( event )
    --init menu-specific variables and audio here
    --make sure to insert objects into sceneGroup
    --========
    --EXAMPLE
    --========
    --local background = display.newImage( "background.png" )
    --sceneGroup:insert( background )

    --we don't have any rooms yet
    --so, let's tell our program to create
    --one room.
    -- roomCount = 1

    --create initial room
    createRoom(true)

    --get our scene view
    local sceneGroup = self.view

end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    --"will" fires when the scene has been called
    --but it's not on screen yet.
    if ( phase == "will" ) then
        --we position elements here, because we are
        --re-entering the scene
		if constants.scrollSpeed == nil then
			constants.scrollSpeed = 0.05
		end
		display.setDefault( "background", 0, 0, 0 )
        --"did" fires when the scene is FULLY
        --on the screen.
    elseif ( phase == "did" ) then
        --start runtime listeners like "enterFrame"
        --start timers, transitions, sprite animations.
        Runtime:addEventListener( "enterFrame" , renderOut)
        Runtime:addEventListener( "touch" , moveWorld)
        --add runtime listeners for everything in world
        for i=1,#world do
            --world[i]:addEventListener("touch",getInfo)
        end
		print("Scrollspeed: ",constants.scrollSpeed)
		print("Level: ",constants.currentLevel)
    end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        --remove stuff initialized in the
        --"did" phase of the show scene.
        --unallocate timers, transitions, sprite stuff.
        Runtime:removeEventListener( "enterFrame" , renderOut)
        Runtime:removeEventListener( "touch" , moveWorld)
		
    elseif ( phase == "did" ) then
        --not much to do here, except force removal of
        --the scene after it transitions of screen for optimization.
    end

end

function scene:destroy( event )
    --dispose of all allocated variables and audio
    --in the create function here
    local sceneGroup = self.view

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
