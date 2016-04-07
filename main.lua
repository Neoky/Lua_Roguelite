---------------
--File: main.lua
--
--Description:
--  Entry point for the application
---------------

local player = require('scripts.player')
player.delete()

local composer = require("composer")
composer.gotoScene( 'scripts.dungeon_01.scene01')
--composer.gotoScene( 'scripts.title_screen')