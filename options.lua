local composer = require( "composer" )
local constants = require( "constants" )
local scene = composer.newScene()
local widget = require( "widget" )
local menuLoop, backButton, title, menuLoopChannel
local sliderSize = {}

sliderSize[1] = {400,10}
--==============
--USER FUNCTIONS
--==============
-- Function to handle button events
local function handleBackEvent( event )

    if ( "ended" == event.phase ) then
        -- Assumes that "menu.lua" exists and is configured as a Composer scene
		-- ??do i need to remove this every time? if i don't, it doesn't go through the create thing and make buttons again...
		composer.gotoScene( "menu" )
    end
end

--moving the slider
function sliderCircle:touch ( event )
	if event.phase == "began" then
		--self.markX = self.x -- store x location of object
		--self.markY = self.y -- store y location of object
	elseif event.phase == "moved" then
		--local x = (event.x - event.xStart) + self.markX
		--local y = (event.y - event.yStart) + self.markY
	--self.x, self.y = x, y -- move object based on calculations above

	return true
	end
end

--===============
--SCENE FUNCTIONS
--===============
function scene:create( event )
	--init menu-specific variables and audio here
	--make sure to insert objects into sceneGroup
	if constants.scrollSpeed == nil then 
		constants.scrollSpeed = 0.01
	end
	local tempSpeed = constants.scrollSpeed *100
	print(tempSpeed)
	-- Create the start button
	backButton = widget.newButton
	{
		label = "button",
		onEvent = handleBackEvent,
		emboss = false,
		--properties for a rounded rectangle button...
		shape="roundedRect",
		width = 200,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 1, 1, 0.4 } },
		strokeColor = { default={ 1, 0.4, 0, 1 }, over={ 0.8, 0.8, 1, 1 } },
		strokeWidth = 0
	}
	--show the sensitivity slider
	local sliderRect = display.newRoundedRect(display.contentCenterX,display.contentCenterY-40,sliderSize[1][1],sliderSize[1][2],5)
	    sliderRect.strokeWidth = 1
        sliderRect:setFillColor(  0.4, 0.4, 0.4  )
        sliderRect:setStrokeColor( 0 )
		
	--add the circle thing
	local sliderCircle = display.newCircle(display.contentCenterX,display.contentCenterY-40,10)
		sliderCircle:setFillColor( 0.5 )
		sliderCircle.strokeWidth = 5
		sliderCircle:setStrokeColor( 1, 0, 0 )
	--========
	--EXAMPLE
	--========
	--local background = display.newImage( "background.png" )
    --sceneGroup:insert( background )
	
	--get our scene view
    local sceneGroup = self.view
	sceneGroup:insert(backButton)
	sceneGroup:insert(sliderRect)
	sceneGroup:insert(sliderCircle)
    
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    
	--"will" fires when the scene has been called
	--but it's not on screen yet.
    if ( phase == "will" ) then
		--we position elements here, because we are 
		--re-entering the scene
		
		-- Center the button
		backButton.x = display.contentCenterX
		backButton.y = display.contentCenterY+40
		-- Change the button's label text
		backButton:setLabel( "Back" )
		
		
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
		--clean up audio variables
		--audio.stop(menuLoopChannel)
		--audio.dispose(menuLoop)
		--set each variable we are allocating to nil
		--to ensure proper cleanup
		backButton, sliderRect, sliderCircle = nil
		
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
sliderCircle:addEventListener( "touch", sliderCircle )

return scene