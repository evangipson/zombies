local composer = require( "composer" )
local constants = require( "constants" )
local scene = composer.newScene()
local widget = require( "widget" )
local menuLoop, startButton, optionsButton, title, menuLoopChannel
--==============
--USER FUNCTIONS
--==============
-- Functions to handle button events
local function handleStartEvent( event )
    if ( "ended" == event.phase ) then
        -- Assumes that "menu.lua" exists and is configured as a Composer scene
		--!!sometimes when start is clicked it also automatically clicks the tutorial button because it's in the same place
		--have to do something with that shit here
		composer.gotoScene( "chooselevel" )
    end
end

local function handleOptionsEvent( event )

    if ( "ended" == event.phase ) then
		-- Assumes that "menu.lua" exists and is configured as a Composer scene
		--?? do i need to remove this every time? if i don't, it doesn't go through the create thing and make buttons again...
		composer.gotoScene( "options" )
    end
end

local function loadGame()
	--to track which line of the file we're reading
	local lineNumber = 1
	--open the save file
	local file = io.open( constants.saveFile, "r")
	for line in file:lines() do
		--scrollSpeed is on the first line so read that first
		if lineNumber == 1 then
			constants.scrollSpeed = line
		end
		--then a boolean showing if you cleared levels 1-10
		if lineNumber == 2 then
			constants.levelCleared[1] = line
		end
		if lineNumber == 3 then
			constants.levelCleared[2] = line
		end
		if lineNumber == 4 then
			constants.levelCleared[3] = line
		end
		if lineNumber == 5 then
			constants.levelCleared[4] = line
		end
		if lineNumber == 6 then
			constants.levelCleared[5] = line
		end
		if lineNumber == 7 then
			constants.levelCleared[6] = line
		end
		if lineNumber == 8 then
			constants.levelCleared[7] = line
		end
		if lineNumber == 9 then
			constants.levelCleared[8] = line
		end
		if lineNumber == 10 then
			constants.levelCleared[9] = line
		end
		if lineNumber == 11 then
			constants.levelCleared[10] = line
		end
		if lineNumber == 12 then
			constants.levelCleared[11] = line
		end
		lineNumber = lineNumber + 1
	end
	io.close(file)
	--if there's no scrollSpeed in the save file (i.e. new save), set it to 0.05 (default)
	if constants.scrollSpeed == nil then
		constants.scrollSpeed = 0.05
	end
	--!!add somewhere to see if levels are cleared and unlock the next one etc
--	for i=1,10 do
--		print(constants.levelCleared[i])
--	end
end

--===============
--SCENE FUNCTIONS
--===============
function scene:create( event )
	--init menu-specific variables and audio here
	--make sure to insert objects into sceneGroup
	
	-- Load menu audio loop
	menuLoop = audio.loadStream( "spy.mp3" )
	display.setDefault( "background", 1, 1, 1 )
	
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
	
	--show the title
	title = display.newText( "Zenbies!", display.contentCenterX, display.contentCenterY-100, native.systemFont, 16 )
	title:setFillColor( 0, 0, 0 )	
				
	-- Create the start button
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
	
	-- create the options button
	optionsButton = widget.newButton
	{
		label = "button",
		onEvent = handleOptionsEvent,
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
		
		-- Center the buttons
		startButton.x = display.contentCenterX
		startButton.y = display.contentCenterY-40
		optionsButton.x = display.contentCenterX
		optionsButton.y = display.contentCenterY+40
		-- Change the buttons' label text
		startButton:setLabel( "Start" )
		optionsButton:setLabel( "Options" )
	
	loadGame()
	
	sceneGroup:insert(startButton)
	sceneGroup:insert(optionsButton)
	sceneGroup:insert(title)
	
	--"did" fires when the scene is FULLY
	--on the screen.		
    elseif ( phase == "did" ) then
		--start runtime listeners like "enterFrame"
		--start timers, transitions, sprite animations.
		print( "Hello World!" )
			
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
		startButton:removeSelf()
		optionsButton:removeSelf()
		title:removeSelf()
		--clean up audio variables
		--audio.stop(menuLoopChannel)
		--audio.dispose(menuLoop)
		--set each variable we are allocating to nil
		--to ensure proper cleanup
		startButton, optionsButton, title, menuLoop = nil
		
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