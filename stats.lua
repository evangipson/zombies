local composer = require( "composer" )
local constants = require( "constants" )
local scene = composer.newScene()
local widget = require( "widget" )
local tempTime, tempSecond, tempMinute, tempHour, tempDay
local tempRect, tempText, okButton

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

function handleResetEvent ( event )
    if ( "ended" == event.phase ) then
		tempRect = display.newRect( display.contentCenterX, display.contentCenterY, 400, 200 )
		tempRect:setFillColor( 1, 1, 1 )
		tempRect.strokeWidth = 3
		tempRect:setStrokeColor( 0, 0, 0)
		tempText = display.newText( "Coming soon", display.contentCenterX, display.contentCenterY, native.systemFont, 20 )
		
		okButton = widget.newButton
		{
			label = "Ok",
			onEvent = handleOkEvent,
			emboss = false,
			--properties for a rounded rectangle button...
			shape="roundedRect",
			width = 60,
			height = 30,
			font = native.systemFont,
			cornerRadius = 10,
			fillColor = { default={ 0.8, 0.8, 0.8, 1 }, over={ 0.4, 0.4, 0.4, 0.4 } },
			strokeColor = { default={ 0, 0, 0, 1 }, over={ 0, 0, 0, 1 } },
			labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
			strokeWidth = 2
		}
		tempText:setFillColor( 0, 0, 0 )
		
		okButton.x = display.contentCenterX
		okButton.y = display.contentCenterY+40
		
	end
	return true
end

function handleOkEvent ( event )
    if ( "ended" == event.phase ) then
		tempRect:removeSelf()
		tempText:removeSelf()
		okButton:removeSelf()
	end
	return true
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

function calcTime()
	tempTime = constants.timePlayed

	--first see how many days and remove that
	tempDay = tempTime/(1000*60*60*24)
	if tempDay > 1 then 
		--round down to whole days
		tempDay = math.floor(tempDay)
		--remove days from the time
		tempTime = tempTime - (tempDay*(24*60*60*1000))
	else 
		tempDay = 0
	end
	
	--then we do hours
	tempHour = tempTime/(60*60*1000)	
	if tempHour > 1 then 
		--round down to whole hours
		tempHour = math.floor(tempHour)
		--remove hours from the time
		tempTime = tempTime - (tempHour*(60*60*1000))
	else
		tempHour = 0
	end
	
	--minutes
	tempMinute = tempTime/(60*1000)
	if tempMinute > 1 then 
		--round down to whole minutes
		tempMinute = math.floor(tempMinute)
		--remove minutes from the time
		tempTime = tempTime - (tempMinute*(60*1000))
	else
		tempMinute = 0
	end
	
	--now do seconds
	tempSecond = tempTime/1000
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
	
    display.setDefault( "background", 1, 1, 1 )
	
	calcTime()
	
	--"will" fires when the scene has been called but it's not on screen yet.
    if ( phase == "will" ) then
		--we position elements here, because we are re-entering the scene
		--check which level you cleared and unlocks the next one
		
		--add all the stats stuff
		totalGamesText = display.newText( "Games played: "..constants.gamesPlayed, display.contentCenterX, display.contentCenterY-120, native.systemFont, 16 )
		totalGamesText:setFillColor ( 0, 0, 0 )
		
		totalTimeText = display.newText( "Time played: "..tempDay.."d, "..tempHour.."h, "..tempMinute.."m, "..tempSecond.."s", display.contentCenterX, display.contentCenterY-90, native.systemFont, 16 )
		totalTimeText:setFillColor ( 0, 0, 0 )
		
		totalInfText = display.newText( "Total infected: "..constants.totalInfections, display.contentCenterX, display.contentCenterY-60, native.systemFont, 16 )
		totalInfText:setFillColor ( 0, 0, 0 )
		
		totalLostText = display.newText( "Total zombies lost: "..constants.totalLost, display.contentCenterX, display.contentCenterY-30, native.systemFont, 16 )
		totalLostText:setFillColor ( 0, 0, 0 )
		
		--add the return to menu button
	menuButton = widget.newButton
	{
		label = "Menu",
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
	resetButton = widget.newButton
	{
		label = "Reset Statistics",
		onEvent = handleResetEvent,
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
	
		resetButton.x = display.contentCenterX
		resetButton.y = display.contentCenterY+20
		menuButton.x = display.contentCenterX
		menuButton.y = display.contentCenterY+80
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
		totalInfText:removeSelf()
		totalLostText:removeSelf()
		totalGamesText:removeSelf()
		totalTimeText:removeSelf()
		resetButton:removeSelf()
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