local composer = require( "composer" )
local constants = require("constants")
local scene = composer.newScene()
local world = {}
mRand = math.random
local roomArray={}
local roomCount
local moveWorld
local player,playerX,playerY
local roomX={}
local roomY={}
local roomW={}
local roomH={}

--this function will create a room
--there will be 2 different applications:
--1) initial room creation
--2) everytime the player chooses to leave a room
function detectLevel()
	--check which level player is on and set room variables accordingly
	if constants.currentLevel == 0 then
		roomCount = #constants.level0RoomX
		for i=1,roomCount do
			roomX[i] = constants.level0RoomX[i]
			roomY[i] = constants.level0RoomY[i]
			roomW[i] = constants.level0RoomW[i]
			roomH[i] = constants.level0RoomH[i]
		end
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
        --now we can move the player
        playerX = playerX + xScroll
        playerY = playerY + yScroll
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
	
    --let's put the player in the room here
    player = display.newRect(playerX,playerY,10,10)
    player:setFillColor(  0.22, 0.51, 0.63  )
    table.insert(world,player)
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

    --set player's initial position
    playerX = display.contentCenterX
    playerY = display.contentCenterX

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
        print("In game.")
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
