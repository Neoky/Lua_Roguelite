---------------
--File: pest.lua
--
--Description:
--  This file holds the the enemy subclass for a pest
---------------

local ItemsTable = require("scripts.items");

local IMAGE_WIDTH = 16;
local IMAGE_HEIGHT = 16;

local sheetOptions = {
	frames = {
		{ x = 80, y = 16, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- fly 1
		{ x = 80, y = 191, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- fly 2
		{ x = 47.5, y = 32, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- scorpion 1
		{ x = 47.5, y = 206, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- scorpion 2
		{ x = 48, y = 64, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- ant 1
		{ x = 48, y = 238, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- ant 2
		{ x = 0, y = 144, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- spider 1
		{ x = 0, y = 318, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- spider 2
	}
};

local enemySheet = graphics.newImageSheet( "images/Characters/PestCombined.png", 
	sheetOptions );

-- Create animation sequence for animation
local enemySeqData = {
	{name = "fly", frames={1,2}, time=1000},
	{name = "scorpion", frames={3,4}, time=1000},
	{name = "ant", frames={5,6}, time=1000},
	{name = "spider", frames={7,8}, time=1000},
}


----- Pest Class declaration -----

local EnemyClass = require("scripts.enemyClass");

--[[
  Enemy variables:
    type = specific type of enemy
    movePattern = movement pattern to be performed by enemy
    spriteSheet = image sheet
    spriteSeqData = sequence for sprite
    wpnSheet = weapon image sheet
    wpnFrameNum = frame number to use from weapon image sheet
    HP = hit points
    ATK = attack points
]]--
Pest = EnemyClass:new( {type="pest", movePattern="RANDOM", 
	spriteSheet=enemySheet, spriteSeqData=enemySeqData, wpnSheet=ItemsTable.ammo.sheet, wpnFrameNum=1,
	HP=5, ATK=1} );



----- end Pest Class declaration -----


return Pest;