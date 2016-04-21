---------------
--CS 571 Final Project
--Title: Tale of the Rogue
--
--File: main.lua
--
--Description:
--  Entry point for the application
--
--Project Approach:
--  This game is a turn-based dungeon crawler game based off of roguelikes such as Nethack and adventure games like The Legend of Zelda. 
--  The approach to the game was to create a series of rooms that the player could traverse to pick up items and fight monsters. 
--  Rooms are created through map generation where all the user needs to do is give the map class for the current scene a list of 
--  tiles or objects to place on or in the map. The maps are made up of two layers: One thats holds the floor and wall information
--  and another that holds the information about objects in the room. The player, monsters, items, and other decor items are kept
--  through this object layer. 
--
--  The Player moves through the room user tappable arrows. After the arrows are tapped, the game checks to see if the player
--  should be interacting with something (fighting a monster, picking up an item, pushing something). After the player has 
--  moved, then all the enemies currently in the room get to move. This guarantees that the player can get the jump on enemies
--  if he/she plans accordingly. It also ensures that the player and the enemies can't occupy the same tile. 
--
--  Each room is connected to another rooms. For each scene, a list of what items and enemies are in that room is kept. When
--  moving between room, the list is referenced to see what items and enemies still need to be placed for that room. Any items
--  that have been collected or monsters that have been killed will not be placed if the player has already done so when 
--  he/she had been in the room previously. 
--
--  The player wants to collect keys and items to get further in the game, eventually facing the final boss of the dungeon and
--  escaping to freedom. The player needs to be careful though. Fighting enemies gives no real reward and death is permanent, so it
--  may be in the player's best interest to find ways around fighting if necessary and get to the exit in one piece!
--
--  For more information on the design of the game, please refer to final project report.
--
--Credits:
--Programming:
--  Jonathan Bryant
--  Marting Cox
--  Steven Muller
--Graphics:
--  DawnLike Tile Set by DragonDePlatino/DawnBringer @ OpenGameArt.org
--Music:
--  Jay Man @ https://ourmusicbox.com/
--Sound Effects:
--  Generated from www.superflashbros.net/as3sfxr/
--Save Game functionality:
--  https://github.com/robmiracle/Simple-Table-Load-Save-Functions-for-Corona-SDK 
---------------

-- auto starts background music.
-- comment out to remove music. sound fx will still play.
local music = require('scripts.music')


-- ssfx http://www.superflashbros.net/as3sfxr/

local composer = require("composer")
composer.gotoScene( 'scripts.title_screen')