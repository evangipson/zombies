local composer = require( "composer" )
local constants = require( "constants" )
local scene = composer.newScene()
local widget = require( "widget" )
local menuLoop, backButton, counterButton, sliderCircle, speedText, menuLoopChannel, tempSpeed
local sliderSize = {}
local circleX = 0

sliderSize[1] = {400,10}
--==============
--USER FUNCTIONS
--==============
-- Function to handle button events

local function handleCounterEvent( event )

    if ( "ended" == event.phase ) then
        if constants.counterLocation == "Bottom Right" then
			constants.counterLocation = "Bottom Left"
		elseif constants.counterLocation == "Bottom Left" then
			constants.counterLocation = "Top Left"
		elseif constants.counterLocation == "Top Left" then
			constants.counterLocation = "Top Right"
		elseif constants.counterLocation == "Top Right" then
			constants.counterLocation = "Bottom Right"
		end
    end
	counterButton:setLabel( constants.counterLocation )
	saveSettings()
	return true
end

local function handleBackEvent( event )

    if ( "ended" == event.phase ) then
        -- Assumes that "menu.lua" exists and is configured as a Composer scene
		composer.gotoScene( "menu" )
    end
end

local function handleTimerEvent( event )

    if ( "ended" == event.phase ) then
		if constants.timerOn == "Timer Shown" then
			constants.timerOn = "Timer Hidden"
			saveSettings()
			timerButton:setLabel( constants.timerOn )
		else
			constants.timerOn = "Timer Shown"
			saveSettings()
			timerButton:setLabel( constants.timerOn )
		end
    end
	return true
end

local function sliderSlide( event )
	if event.phase == "began" then
		circleX = event.xStart
		sliderCircle.x = event.xStart
	local leftside = (display.contentWidth-sliderSize[1][1])/2
	local newSpeed = math.round((sliderCircle.x-leftside)/(sliderSize[1][1]/10))
	if newSpeed < 1 then
		newSpeed = 1
	end
	constants.scrollSpeed = newSpeed/100
	speedText.text = "Scroll speed: "..newSpeed
	saveSettings()
	elseif event.phase == "moved" then
		circlexScroll=((event.xStart-event.x)/1)
		sliderCircle.x = circleX-circlexScroll
	--now add some math to change the scrollspeed
	local leftside = (display.contentWidth-sliderSize[1][1])/2
	local newSpeed = math.round((sliderCircle.x-leftside)/(sliderSize[1][1]/10))
	if newSpeed < 1 then
		newSpeed = 1
	end
	constants.scrollSpeed = newSpeed/100
	speedText.text = "Scroll speed: "..newSpeed
	saveSettings()
	return true
	end
end

function saveSettings()
	local file = io.open( constants.saveFile, "w")
		file:write( constants.scrollSpeed, "\n" )
		for i=1,11 do
			file:write( constants.levelCleared[i], "\n" )
		end
		file:write( constants.counterLocation, "\n")
		file:write( constants.timerOn, "\n")
		file:write( constants.totalInfections, "\n")
		file:write( constants.totalLost, "\n")
		file:write( constants.gamesPlayed, "\n")
		file:write( constants.timePlayed, "\n")
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
    
	--"will" fires when the scene has been called but it's not on screen yet.
    if ( phase == "will" ) then
		--we position elements here, because we are re-entering the scene
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
		font = native.systemFont,
		cornerRadius = 10,
		fillColor = { default={ 0.8, 0.8, 0.8, 1 }, over={ 0.4, 0.4, 0.4, 0.4 } },
		strokeColor = { default={ 0, 0, 0, 1 }, over={ 0, 0, 0, 1 } },
		labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
		strokeWidth = 2
	}
	--show the sensitivity slider
		sliderRect = display.newRoundedRect(display.contentCenterX,display.contentCenterY-20,sliderSize[1][1],sliderSize[1][2],5)
	    sliderRect.strokeWidth = 1
        sliderRect:setFillColor(  0.5, 0.5, 0.5  )
        sliderRect:setStrokeColor( 0 )
		sliderRect:addEventListener( "touch", sliderSlide )
		
	--add the circle thing
		sliderCircle = display.newCircle(display.contentCenterX,display.contentCenterY-20,10)
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
	
	--and the speed thing
	speedText = display.newText ("Scroll speed: "..tempSpeed, display.contentCenterX, display.contentCenterY-40, native.systemFont, 16 )
	speedText:setFillColor( 0, 0, 0 )
	counterText = display.newText ("Infection counter location:", display.contentCenterX, display.contentCenterY-125, native.systemFont, 16 )
	counterText:setFillColor( 0, 0, 0 )
	
	timerButton = widget.newButton
	{
		label = "button",
		onEvent = handleTimerEvent,
		emboss = false,
		--properties for a rounded rectangle button...
		shape="roundedRect",
		width = 200,
		height = 40,
		font = native.systemFont,
		cornerRadius = 10,
		fillColor = { default={ 0.8, 0.8, 0.8, 1 }, over={ 0.4, 0.4, 0.4, 0.4 } },
		strokeColor = { default={ 0, 0, 0, 1 }, over={ 0, 0, 0, 1 } },
		labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
		strokeWidth = 2
	}
	
	counterButton = widget.newButton
	{
		label = constants.counterLocation,
		onEvent = handleCounterEvent,
		emboss = false,
		--properties for a rounded rectangle button...
		shape="roundedRect",
		width = 200,
		height = 40,
		font = native.systemFont,
		cornerRadius = 10,
		fillColor = { default={ 0.8, 0.8, 0.8, 1 }, over={ 0.4, 0.4, 0.4, 0.4 } },
		strokeColor = { default={ 0, 0, 0, 1 }, over={ 0, 0, 0, 1 } },
		labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
		strokeWidth = 2	
	}

		-- Center the buttons
		backButton.x = display.contentCenterX
		backButton.y = display.contentCenterY+100
		timerButton.x = display.contentCenterX
		timerButton.y = display.contentCenterY+30
		counterButton.x = display.contentCenterX
		counterButton.y = display.contentCenterY-90
		-- Change the buttons' label text
		backButton:setLabel( "Back" )
		timerButton:setLabel( constants.timerOn )
		
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
		timerButton:removeSelf()
		counterButton:removeSelf()
		counterText:removeSelf()
		--clean up audio variables
		--audio.stop(menuLoopChannel)
		--audio.dispose(menuLoop)
		--set each variable we are allocating to nil
		--to ensure proper cleanup
		backButton, sliderRect, sliderCircle, speedText, timerButton, counterText, counterButton = nil
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