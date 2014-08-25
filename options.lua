local composer = require( "composer" )
local constants = require( "constants" )
local scene = composer.newScene()
local widget = require( "widget" )
local menuLoop, backButton, sliderCircle, speedText, menuLoopChannel, tempSpeed
local sliderSize = {}
local circleX = 0

sliderSize[1] = {400,10}
--==============
--USER FUNCTIONS
--==============
-- Function to handle button events
local function handleBackEvent( event )

    if ( "ended" == event.phase ) then
        -- Assumes that "menu.lua" exists and is configured as a Composer scene
		composer.gotoScene( "menu" )
    end
end

local function handleStartEvent( event )

    if ( "ended" == event.phase ) then
        -- Assumes that "menu.lua" exists and is configured as a Composer scene
		composer.gotoScene( "game" )
    end
end

local function sliderSlide( event )
	if event.phase == "began" then
		circleX = event.xStart
		sliderCircle.x = event.xStart
	elseif event.phase == "moved" then
		circlexScroll=((event.xStart-event.x)/1)
		sliderCircle.x = circleX-circlexScroll
	--now add some math to change the scrollspeed
	local leftside = (display.contentWidth-sliderSize[1][1])/2
	--local middle = sliderSize[1][1]/2+leftside
	--print(display.contentWidth, leftside, middle, (sliderCircle.x-leftside))
	local newSpeed = math.round((sliderCircle.x-leftside)/(sliderSize[1][1]/10))
	if newSpeed < 1 then
		newSpeed = 1
	end
	constants.scrollSpeed = newSpeed/100
	speedText.text = newSpeed
	saveSettings()
	return true
	end
end

function saveSettings()
	local file = io.open( constants.saveFile, "w")
		file:write( constants.scrollSpeed, "\n" )
		for i=1,10 do
			file:write( constants.levelCleared[i], "\n" )
		end
	io.close( file )
end

--===============
--SCENE FUNCTIONS
--===============
function scene:create( event )
	--init menu-specific variables and audio here
	--make sure to insert objects into sceneGroup
	if constants.scrollSpeed == nil then 
		constants.scrollSpeed = 0.05
	end

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
	tempSpeed = constants.scrollSpeed*100	
		
			-- Create the back button
	backButton = widget.newButton
	{
		label = "button",
		onEvent = handleBackEvent,
		emboss = false,
		--properties for a rounded rectangle button...
		shape="roundedRect",
		width = 200,
		height = 40,
		cornerRadius = 10,
		fillColor = { default={ 0.8, 0.8, 0.8, 1 }, over={ 0.4, 0.4, 0.4, 0.4 } },
		strokeColor = { default={ 0, 0, 0, 1 }, over={ 0, 0, 0, 1 } },
		labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
		strokeWidth = 2
	}
	--show the sensitivity slider
		sliderRect = display.newRoundedRect(display.contentCenterX,display.contentCenterY-40,sliderSize[1][1],sliderSize[1][2],5)
	    sliderRect.strokeWidth = 1
        sliderRect:setFillColor(  0.5, 0.5, 0.5  )
        sliderRect:setStrokeColor( 0 )
		sliderRect:addEventListener( "touch", sliderSlide )
		
	--add the circle thing
		sliderCircle = display.newCircle(display.contentCenterX,display.contentCenterY-40,10)
		sliderCircle:setFillColor( 0.5 )
		sliderCircle.strokeWidth = 2
		sliderCircle:setStrokeColor( 0, 0, 0 )
		sliderCircle.id = sliderCircle
	--set it to be on the slider depending on what the scrollspeed is set to
		local leftside = (display.contentWidth-sliderSize[1][1])/2
		sliderCircle.x = leftside+((constants.scrollSpeed*100)-1)*45
		if constants.scrollSpeed == "0.05" then
			sliderCircle.x = display.contentCenterX
		end
		print(constants.scrollSpeed)
	
	--and the speed thing
	speedText = display.newText (tempSpeed, display.contentCenterX, display.contentCenterY-70)
	speedText:setFillColor( 0, 0, 0 )
	
	--!! TEMP BUTTON FOR THE GAME START
	startButton = widget.newButton
	{
		label = "button",
		onEvent = handleStartEvent,
		emboss = false,
		--properties for a rounded rectangle button...
		shape="roundedRect",
		width = 200,
		height = 40,
		cornerRadius = 10,
		fillColor = { default={ 0.8, 0.8, 0.8, 1 }, over={ 0.4, 0.4, 0.4, 0.4 } },
		strokeColor = { default={ 0, 0, 0, 1 }, over={ 0, 0, 0, 1 } },
		labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
		strokeWidth = 2
	}
		
		-- Center the button
		backButton.x = display.contentCenterX
		backButton.y = display.contentCenterY+40
		-- Change the button's label text
		backButton:setLabel( "Back" )
		
		startButton.x = display.contentCenterX
		startButton.y = display.contentCenterY+100
		startButton:setLabel( "Start" )
		
	--"did" fires when the scene is FULLY
	--on the screen.
    elseif ( phase == "did" ) then
		--start runtime listeners like "enterFrame"
		--start timers, transitions, sprite animations.
			
		-- Play the background music on channel 1, loop infinitely, and fade in over 5 seconds 
		--menuLoopChannel = audio.play( menuLoop, { channel=1, loops=-1, fadein=100 } )
    end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
		--remove stuff initialized in the 
		--"did" phase of the show scene.
		--unallocate timers, transitions, sprite stuff.
		backButton:removeSelf()
		sliderRect:removeSelf()
		sliderCircle:removeSelf()
		speedText:removeSelf()
		startButton:removeSelf()
		--clean up audio variables
		--audio.stop(menuLoopChannel)
		--audio.dispose(menuLoop)
		--set each variable we are allocating to nil
		--to ensure proper cleanup
		backButton, sliderRect, sliderCircle, speedText, startButton = nil
		
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