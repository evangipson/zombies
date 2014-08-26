local composer = require( "composer" )
local constants = require( "constants" )
local scene = composer.newScene()
local widget = require( "widget" )
local menuLoop, menuLoopChannel, title
local imageArray={}
local nameArray={}
local levelpic={}
local levelTitle={}
local moveImages
--local xMomentum = 0

--??i don't know if we can do this in a loop with concatenating i to "level" and ".png"
--!!need to add infinite mode here too
imageArray[1]="level0.png"
imageArray[2]="level1.png"
imageArray[3]="level2.png"
imageArray[4]="level3.png"
imageArray[5]="level4.png"
imageArray[6]="level5.png"
imageArray[7]="level6.png"
imageArray[8]="level7.png"
imageArray[9]="level8.png"
imageArray[10]="level9.png"
imageArray[11]="level10.png"
imageArray[12]="leveli.png"

levelTitle[1] = "Tutorial"
levelTitle[2] = "Patient Zero"
levelTitle[3] = "Contamination"
levelTitle[4] = "Contagion"
levelTitle[5] = "Infection"
levelTitle[6] = "Outbreak"
levelTitle[7] = "Infestation"
levelTitle[8] = "Pandemic"
levelTitle[9] = "Onslaught"
levelTitle[10] = "Epidemic"
levelTitle[11] = "Apocalypse"
levelTitle[12] = "Infinite mode"

--==============
--USER FUNCTIONS
--==============
--function momentumMove( event )
	--check to see if we're going left or right
--	if xMomentum < 0 then
--		for i=1,11 do
--			levelpic[i].x = levelpic[i].x-100
--			nameArray[i].x = nameArray[i].x-100
--		end
--	end
--	if xMomentum > 0 then
--		for i=1,11 do
--			levelpic[i].x = levelpic[i].x-(xMomentum/10)
--			nameArray[i].x = nameArray[i].x-(xMomentum/10)
--		end
--	end
--end

function moveImages( event )
    local xScroll
	if event.phase == "moved" then
		xScroll=((event.xStart-event.x)*-1)*0.015
		if levelpic[12].x+xScroll > display.contentCenterX then
			xScroll = 0
			levelpic[12].x = display.contentCenterX
		end
		if levelpic[11].x+xScroll < display.contentCenterX then
			xScroll = 0
			levelpic[11].x=display.contentCenterX
		end
		for i=1,12 do
			levelpic[i].x = levelpic[i].x+xScroll
			nameArray[i].x = nameArray[i].x+xScroll
			--??insert the performWithDelay timer here maybe?
		end
--		xMomentum = xMomentum+xScroll
	end
--	if event.phase == "ended" then
--		print(xMomentum)
		--check to see if we're going left or right		
--		if xMomentum < 0 then --we're going left
--			for i=1,(xMomentum*-1) do
--				timer.performWithDelay ((i*-1)*1000, momentumMove, 0)
--				print(xMomentum*-1)
--				xMomentum=xMomentum+1
--			end
--			xMomentum = 0
			--while xMomentum < 0 do
				--timer.performWithDelay( 100, momentumMove, xMomentum/10 )
				--momentumMove()
				--print(xMomentum)
			--end
--		end
--		if xMomentum > 0 then --we're going right
--		while xMomentum > 0 do
--				timer.performWithDelay( 100, momentumMove, xMomentum/10 )
--				xMomentum = xMomentum-10
--				if xMomentum < 0 then
--					xMomentum = 0
--				end
--			end
--		end
--		print(xMomentum)
--	end
	return true
end

local function clickLevel( event )
	constants.currentLevel = event.target.name
	if event.target.alpha == 1 then
		composer.gotoScene( "game" )
	end
end

--===============
--SCENE FUNCTIONS
--===============
function scene:create( event )
	--init menu-specific variables and audio here
	--make sure to insert objects into sceneGroup
	
	-- Load menu audio loop
	menuLoop = audio.loadStream( "spy.mp3" )
	--!!change this color after we change the level images
	display.setDefault( "background", 0, 1, 1 )
	
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
    
	--"will" fires when the scene has been called
	--but it's not on screen yet.
    if ( phase == "will" ) then
	--we position elements here, because we are 
	--re-entering the scene
	title = display.newText("Choose level", display.contentCenterX, display.contentCenterY-(display.contentHeight/2)+40)
	title:setFillColor( 0, 0, 0)
	--add infinite mode pic
	levelpic[12] = display.newImage(imageArray[12], display.contentCenterX-150, display.contentCenterY)
	nameArray[12] = display.newText(levelTitle[12], display.contentCenterX-150, display.contentCenterY+80)
	nameArray[12]:setFillColor( 0, 0, 0)
	levelpic[12]:addEventListener( "tap", clickLevel )
	levelpic[12].name = 11
	if constants.levelCleared[11] == "false" then
			levelpic[12].alpha = 0.4
			nameArray[12].alpha = 0.4
	end
	--add tutorial pic
	levelpic[1] = display.newImage(imageArray[1], display.contentCenterX, display.contentCenterY)
	nameArray[1] = display.newText(levelTitle[1], display.contentCenterX, display.contentCenterY+80)
	nameArray[1]:setFillColor( 0, 0, 0)
	levelpic[1]:addEventListener( "tap", clickLevel )
	levelpic[1].name = 0
	--add the other level pics
	for i = 2, 11 do
		--??need to fix the "i*X" thing here to make sure it covers all resolutions. or do we?
		levelpic[i] = display.newImage( imageArray[i], (display.contentCenterX+i*150)-150, display.contentCenterY)
		levelpic[i]:addEventListener( "tap", clickLevel )
		levelpic[i].name = i-1
		nameArray[i] = display.newText( levelTitle[i], (display.contentCenterX+i*150)-150, display.contentCenterY+80)
		nameArray[i]:setFillColor( 0, 0, 0)
		--grey them out if user is not yet at that level
		if constants.levelCleared[i-1] == "false" then
			levelpic[i].alpha = 0.4
			nameArray[i].alpha = 0.4
		end
	end	
	
	Runtime:addEventListener( "touch" , moveImages)
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
		for i = 1,11 do
			levelpic[i]:removeSelf()
			nameArray[i]:removeSelf()
		end
		Runtime:removeEventListener( "touch" , moveImages)
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