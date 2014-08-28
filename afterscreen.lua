local composer = require( "composer" )
local constants = require( "constants" )
local scene = composer.newScene()
local widget = require( "widget" )
local endText, timeText

--==============
--USER FUNCTIONS
--==============
local function handleMenuEvent( event )
    if ( "ended" == event.phase ) then
        -- Assumes that "menu.lua" exists and is configured as a Composer scene
		--have to do something with that shit here
		composer.gotoScene( "menu" )
    end
	return true
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
	
	--get our scene view
    local sceneGroup = self.view

end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
	local tempText
    display.setDefault( "background", 1, 1, 1 )
	
	--"will" fires when the scene has been called but it's not on screen yet.
    if ( phase == "will" ) then
		--we position elements here, because we are re-entering the scene
		--check which level you cleared and unlocks the next one
	if constants.victory == 1 then
		tempText = "Level complete!"
		if constants.currentLevel < 11 then
			constants.levelCleared[constants.currentLevel+1] = "true"
		end
	else
		tempText = "Level failed."
	end
	endText = display.newText(tempText, display.contentCenterX, 20, native.systemFont, 16 )
	endText:setFillColor( 0, 0, 0 )
	
	--add time elapsed
	timeText = display.newText("Time elapsed: "..(constants.levelTime/1000).." seconds", display.contentCenterX, 60, native.systemFont, 16 )
	timeText:setFillColor( 0, 0, 0 )
	
	--add civs infected
	infText = display.newText("Civilians infected: "..constants.civsInfected, display.contentCenterX, 90, native.systemFont, 16 )
	infText:setFillColor( 0, 0, 0 )
	
	--add zombies lost
	lostText = display.newText("Zombies lost: "..constants.zombiesLost, display.contentCenterX, 120, native.systemFont, 16 )
	lostText:setFillColor( 0, 0, 0 )
	
	--update stats
	saveSettings()
	
	menuButton = widget.newButton
	{
		label = "Main Menu",
		onEvent = handleMenuEvent,
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
		
		--center buttons
		menuButton.x = display.contentCenterX
		menuButton.y = display.contentCenterY+60
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
		menuButton:removeSelf()
		endText:removeSelf()
		constants.currentLevel = 0
		timeText:removeSelf()
		infText:removeSelf()
		lostText:removeSelf()
		constants.civsInfected = 0		
		constants.zombiesLost = 0
		--clean up audio variables
		--audio.stop(menuLoopChannel)
		--audio.dispose(menuLoop)
		--set each variable we are allocating to nil
		--to ensure proper cleanup
	
		
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