---------------
--File: pest.lua
--
--Description:
--  This file holds ...
---------------

local ItemsTable = require("scripts.items");

local IMAGE_WIDTH = 16;
local IMAGE_HEIGHT = 16;

sheetOptions = {
	frames = {
		{ x = 80, y = 16, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- fly
		{ x = 47.5, y = 32, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- scorpion
		{ x = 48, y = 64, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- ant
		{ x = 0, y = 144, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- spider
	}
};

enemySheet = graphics.newImageSheet( "images/Characters/Pest0.png", 
	sheetOptions );


----- Pest Class declaration -----

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
Pest = EnemyClass:new( {type="pest", movePattern="RANDOM", 
	sheet=enemySheet, wpnSheet=ItemsTable.ammo.sheet, wpnFrameNum=1,
	HP=5, ATK=1} );



----- end Pest Class declaration -----


return Pest;