---------------
--File: undead.lua
--
--Description:
--  This file holds ...
---------------

local ItemsTable = require("scripts.items");

local IMAGE_WIDTH = 16;
local IMAGE_HEIGHT = 16;

sheetOptions = {
	frames = {
		{ x = 80, y = 16, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- mummy
		{ x = 0.5, y = 32, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- white skeleton
		{ x = 32.5, y = 32, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- green skeleton
		{ x = 31, y = 63, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- white ghost
		{ x = -1, y = 96.5, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- dementor
	}
};

enemySheet = graphics.newImageSheet( "images/Characters/Undead0.png", 
	sheetOptions );


----- Undead Class declaration -----

local EnemyClass = require("scripts.enemyClass");

--[[
  Enemy variables:
    type = specific type of enemy
    movePattern = movement pattern to be performed by enemy
    sheet = image sheet
    wpnSheet = weapon image sheet
    wpnFrameNum = frame number to use from weapon image sheet
    HP = hit points
    ATK = attack points
]]--
Undead = EnemyClass:new( {type="undead", movePattern="RANDOM", 
	sheet=enemySheet, wpnSheet=ItemsTable.weaponLng.sheet, wpnFrameNum=2,
	HP=10, ATK=3} );



----- end Undead Class declaration -----


return Undead;