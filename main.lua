---------------
--File: main.lua
--
--Description:
--  Entry point for the application
---------------

-- delete previous save data at game start.
local player = require('scripts.player')
player.delete()

-- auto starts background music.
-- comment out to remove music. sound fx will still play.
local music = require('scripts.music')


-- ssfx http://www.superflashbros.net/as3sfxr/

local composer = require("composer")
--composer.gotoScene( 'scripts.dungeon_01.scene01')
composer.gotoScene( 'scripts.title_screen')