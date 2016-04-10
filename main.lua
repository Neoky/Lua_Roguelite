---------------
--File: main.lua
--
--Description:
--  Entry point for the application
---------------

-- auto starts background music.
-- comment out to remove music. sound fx will still play.
local music = require('scripts.music')


-- ssfx http://www.superflashbros.net/as3sfxr/

local composer = require("composer")
--composer.gotoScene( 'scripts.dungeon_01.scene01')
composer.gotoScene( 'scripts.title_screen')