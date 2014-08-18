-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- we will require composer, because we have different scenes.
local composer = require( "composer" )
-- Code to initialize your app

-- Assumes that "menu.lua" exists and is configured as a Composer scene
composer.gotoScene( "menu", "fade" )