local composer = require( "composer" )
local constants = require( "constants" )
local scene = composer.newScene()
local widget = require( "widget" )
local endText, timeText, milText
local isUnlocked = 0
local displayAchievement = false
local achTimer

--==============
--USER FUNCTIONS
--==============
function checkAchievements ( event )
	if (constants.victory == 1 and constants.currentLevel == 1 and constants.achUnlocked[1] == "false") then
		constants.achUnlocked[1] = "true"
		isUnlocked = 1
		constants.level6achCleared = 0
	end
	if (constants.victory == 1 and constants.currentLevel == 2 and constants.achUnlocked[2] == "false") then
		constants.achUnlocked[2] = "true"
		isUnlocked = 2
		constants.level6achCleared = 0
	end
	if (constants.victory == 1 and constants.currentLevel == 3 and constants.achUnlocked[3] == "false") then
		constants.achUnlocked[3] = "true"
		isUnlocked = 3
		constants.level6achCleared = 0
	end
	if (constants.victory == 1 and constants.currentLevel == 4 and constants.achUnlocked[4] == "false") then
		constants.achUnlocked[4] = "true"
		isUnlocked = 4
		constants.level6achCleared = 0
	end
	if (constants.victory == 1 and constants.currentLevel == 5 and constants.achUnlocked[5] == "false") then
		constants.achUnlocked[5] = "true"
		isUnlocked = 5
		constants.level6achCleared = 0
	end
	if (constants.victory == 1 and constants.currentLevel == 6 and constants.achUnlocked[6] == "false") then
		constants.achUnlocked[6] = "true"
		isUnlocked = 6
	end
	if (constants.victory == 1 and constants.currentLevel == 7 and constants.achUnlocked[7] == "false") then
		constants.achUnlocked[7] = "true"
		isUnlocked = 7
		constants.level6achCleared = 0
	end
	if (constants.victory == 1 and constants.currentLevel == 8 and constants.achUnlocked[8] == "false") then
		constants.achUnlocked[8] = "true"
		isUnlocked = 8
		constants.level6achCleared = 0
	end
	if (constants.victory == 1 and constants.currentLevel == 9 and constants.achUnlocked[9] == "false") then
		constants.achUnlocked[9] = "true"
		isUnlocked = 9
		constants.level6achCleared = 0
	end
	if (constants.victory == 1 and constants.currentLevel == 10 and constants.achUnlocked[10] == "false") then
		constants.achUnlocked[10] = "true"
		isUnlocked = 10
		constants.level6achCleared = 0
	end
	--check secret level 6 achievement
	if (constants.victory == 1 and constants.currentLevel == 6) then
		constants.level6achCleared = constants.level6achCleared + 1
		if constants.level6achCleared == 3 then
			constants.achUnlocked[39] = "true"
			isUnlocked = 39
		end
	end
	--check for games played achievements
	if (constants.gamesPlayed == 1 and constants.achUnlocked[40] == "false") then
		constants.achUnlocked[40] = "true"
		isUnlocked = 40
	end
	if (constants.gamesPlayed == 10 and constants.achUnlocked[41] == "false") then
		constants.achUnlocked[41] = "true"
		isUnlocked = 41
	end
	if (constants.gamesPlayed == 50 and constants.achUnlocked[42] == "false") then
		constants.achUnlocked[42] = "true"
		isUnlocked = 42
	end
	if (constants.gamesPlayed == 100 and constants.achUnlocked[43] == "false") then
		constants.achUnlocked[43] = "true"
		isUnlocked = 43
	end
	if (constants.gamesPlayed == 250 and constants.achUnlocked[44] == "false") then
		constants.achUnlocked[44] = "true"
		isUnlocked = 44
	end
	if (constants.gamesPlayed == 500 and constants.achUnlocked[45] == "false") then
		constants.achUnlocked[45] = "true"
		isUnlocked = 45
	end
	if isUnlocked > 0 then
		achPopUp( isUnlocked )
	end
end

function achPopUp ( isUnlocked )
	displayAchievement = true
	achievementText = "Achievement unlocked!\n"..constants.achArray[isUnlocked]
	achTimer = timer.performWithDelay( 3000, achPopDown )
end

function achPopDown ( event )
	if (displayAchievement == true and achRect ~= nil) then
		displayAchievement = false
		achRect:removeSelf()
		tempAchText:removeSelf()
	end
end

function handleMenuEvent( event )
    if ( "ended" == event.phase ) then
        -- Assumes that "menu.lua" exists and is configured as a Composer scene
		--have to do something with that shit here
		constants.currentLevel = 0
		if displayAchievement == true then
			timer.cancel( achTimer )
			achRect:removeSelf()
			tempAchText:removeSelf()
			displayAchievement = false
		end
		composer.gotoScene( "menu" )
    end
	return true
end

function handleContinueEvent( event )
    if ( "ended" == event.phase ) then
		if constants.victory == 1 then
			constants.currentLevel = constants.currentLevel + 1
			if constants.currentLevel > 11 then
				constants.currentLevel = 11
			end
		end
        -- Assumes that "menu.lua" exists and is configured as a Composer scene
		--have to do something with that shit here
		if displayAchievement == true then
			timer.cancel( achTimer )
			achRect:removeSelf()
			tempAchText:removeSelf()
			displayAchievement = false
		end
		composer.gotoScene( "game" )
    end
	return true
end

function saveSettings()
	local file = io.open( constants.saveFile, "w")
		file:write( constants.scrollSpeed, "\n" )
		for i=1,11 do
			file:write( constants.levelCleared[i], "\n" )
		end
		file:write( constants.counterLocation, "\n" )
		file:write( constants.timerOn, "\n" )
		file:write( constants.totalInfections, "\n" )
		file:write( constants.totalLost, "\n" )
		file:write( constants.gamesPlayed, "\n" )
		file:write( constants.timePlayed, "\n" )
		for i=1,constants.achCount do
			file:write( constants.achUnlocked[i], "\n" )
		end
		file:write( constants.totalMilInfections, "\n" )
		file:write( constants.rangeOn, "\n" )
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
	--first check achievements
	checkAchievements()
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
	
	--add military infected
	milText = display.newText("Miltary infected: "..constants.milInfected, display.contentCenterX, 120, native.systemFont, 16 )
	milText:setFillColor( 0, 0, 0 )
	
	--add zombies lost
	lostText = display.newText("Zombies lost: "..constants.zombiesLost, display.contentCenterX, 150, native.systemFont, 16 )
	lostText:setFillColor( 0, 0, 0 )
	
	--update stats
	saveSettings()
	
	continueButton = widget.newButton
	{
		label = "Main Menu",
		onEvent = handleContinueEvent,
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
		if constants.victory == 1 then
			continueButton:setLabel("Next level")
		else
			continueButton:setLabel("Retry")
		end
		--center buttons
		continueButton.x = display.contentCenterX
		continueButton.y = display.contentCenterY+60
		menuButton.x = display.contentCenterX
		menuButton.y = display.contentCenterY+120
	
	if displayAchievement == true then
		achRect = display.newRect(display.contentCenterX, display.contentHeight-25, 250, 40)
		achRect.strokeWidth = 4
		achRect:setFillColor(  1, 1, 1  )
		achRect:setStrokeColor( 0.5, 0.5, 0.5 )
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
	end
	
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
		timeText:removeSelf()
		infText:removeSelf()
		milText:removeSelf()
		lostText:removeSelf()
		continueButton:removeSelf()
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