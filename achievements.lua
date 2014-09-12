local composer = require( "composer" )
local constants = require( "constants" )
local scene = composer.newScene()
local widget = require( "widget" )
local menuLoop, menuLoopChannel, title
local scrollView
local achPage = 1
local achLocation = {0, -480}
local imageArray = {}
local achPic = {}
local achieveCount = constants.achCount

--==============
--USER FUNCTIONS
--==============
local function clickAchievement( event )
local achText
--scrollView:setIsLocked( true )
	if (constants.achSecret[event.target.name] == 1 and constants.achUnlocked[event.target.name] == "false") then
		achText = "Achievement locked\n\nThis one's a secret!"
	else
		achText = constants.achArray[event.target.name].."\n".."\n"..constants.achArrayDesc[event.target.name]
	end
	
local options = {
	text = achText,
	x = display.contentCenterX,
	y = display.contentCenterY+30,
	width = 350,
	height = 200,
	fontSize = 16,
	align = "center"
}
	
	
	tempRect = display.newRect( display.contentCenterX, display.contentCenterY, 400, 200 )
	tempRect:setFillColor( 1, 1, 1 )
	tempRect.strokeWidth = 3
	tempRect:setStrokeColor( 0, 0, 0)
	tempText = display.newText( options )
	tempText:setFillColor( 0, 0, 0 )
	
	closeButton = widget.newButton
	{
		label = "Close",
		onEvent = handleCloseEvent,
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
	closeButton.x = display.contentCenterX
	closeButton.y = display.contentCenterY+60
	for i=1,achieveCount do
		achPic[i]:removeEventListener( "tap", clickAchievement )
	end
	return true
end

local function handleBackEvent( event )
    if ( "ended" == event.phase ) then
        -- Assumes that "menu.lua" exists and is configured as a Composer scene
		composer.gotoScene( "menu" )
    end
	return true
end

function handleCloseEvent ( event )
	if ( "ended" == event.phase ) then
		tempRect:removeSelf()
		tempText:removeSelf()
		closeButton:removeSelf()
		timer.performWithDelay( 1, addBackListeners )
	end
	--	scrollView:setIsLocked( false )
	return true
end

function addBackListeners ( event )
	for i=1,achieveCount do
		achPic[i]:addEventListener( "tap", clickAchievement )
	end
end

function scrollListener ( event )
local xScroll
	if event.xStart ~= nil then
		xScroll=((event.xStart-event.x))
	end
	if ( "ended" == event.phase ) then
		if xScroll > 100 then --we went right i think
			achPage = achPage + 1
		elseif xScroll < -100 then --we went left
			achPage = achPage - 1
		end
		if achPage < 1 then
			achPage = 1
		end
		if achPage > 2 then
			achPage = 2
		end
		scrollView:scrollToPosition
		{
			x = achLocation[achPage],
			time = 150
		}
	end
end
--===============
--SCENE FUNCTIONS
--===============
function scene:create( event )
	--init menu-specific variables and audio here
	--make sure to insert objects into sceneGroup
	
	-- Load menu audio loop
	--menuLoop = audio.loadStream( "spy.mp3" )
	display.setDefault( "background", 1, 1, 1 )

	--========
	--EXAMPLE
	--========
	--local background = display.newImage( "background.png" )
    --sceneGroup:insert( background )
	
	--get our scene view
    local sceneGroup = self.view
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    constants.currentLevel = 0
	--"will" fires when the scene has been called but it's not on screen yet.
    if ( phase == "will" ) then
	--we position elements here, because we are re-entering the scene
		--??i don't know if we can do this in a loop with concatenating i to "level" and ".png"

scrollView = widget.newScrollView
{
	left = 0,
	top = 0,
	width = display.contentWidth,
	height = display.contentHeight,
	bottomPadding = 50,
	id = "levelScroller",
	horizontalScrollDisabled = false,
	verticalScrollDisabled = true,
	listener = scrollListener,
	backgroundColor = { 1, 1, 1 }
}
scrollView:setScrollWidth( display.contentWidth*2 )

	for i=1,achieveCount do
		imageArray[i] = "crown.png" --!!add different pics for different achievements later
	end
	local temp = 0
	local xColumn = (display.contentWidth/5)-15
	local xRow = (display.contentHeight/4)-20
	--page 1
	for row=1,4 do
		for column=1,5 do
			temp = temp + 1
			achPic[temp] = display.newImage(imageArray[temp], xColumn*column, xRow*row)
			achPic[temp].name = temp
			achPic[temp]:addEventListener( "tap", clickAchievement )
			scrollView:insert(achPic[temp])
			if constants.achUnlocked[temp] == "false" then
				achPic[temp].alpha = 0.4
			end
		end
	end
	--page 2
	for row=1,4 do
		for column=1,5 do
			temp = temp + 1
			if temp < (achieveCount + 1) then
				achPic[temp] = display.newImage(imageArray[temp], (xColumn*column)+display.contentWidth, (xRow*row))
				achPic[temp].name = temp
				achPic[temp]:addEventListener( "tap", clickAchievement )
				scrollView:insert(achPic[temp])
				if constants.achUnlocked[temp] == "false" then
					achPic[temp].alpha = 0.4
				end
			end
		end
	end
	backButton = widget.newButton
	{
		label = "Back",
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
	
	backButton.x = display.contentCenterX
	backButton.y = display.contentHeight-30
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
		scrollView:removeSelf()
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