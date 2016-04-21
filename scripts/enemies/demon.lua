---------------
--File: demon.lua
--
--Description:
--  This file holds the the enemy subclass for a demon
---------------

local ItemsTable = require("scripts.items");

local IMAGE_WIDTH = 16;
local IMAGE_HEIGHT = 16;

local sheetOptions = {
	frames = {
		{ x = 0.1, y = 0.5, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- green dragon 1
        { x = 0.1, y = 144, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- green dragon 2
		{ x = 0.1, y = 16, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- red demon 1
        { x = 0.1, y = 160, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- red demon 2
	}
};

local enemySheet = graphics.newImageSheet( "images/Characters/DemonCombined.png", 
	sheetOptions );

-- Create animation sequence for animation
local enemySeqData = {
    {name = "greenDragon", frames={1,2}, time=1000},
    {name = "redDemon", frames={3,4}, time=1000},
}


----- Demon Class declaration -----

local EnemyClass = require("scripts.enemyClass");

--[[
  Enemy variables:
    type = specific type of enemy
    movePattern = movement pattern to be performed by enemy
    sspriteSheet = image sheet
    spriteSeqData = sequence for sprite
    wpnFrameNum = frame number to use from weapon image sheet
    HP = hit points
    ATK = attack points
]]--
Demon = EnemyClass:new( {type="demon", movePattern="STAND", 
	spriteSheet=enemySheet, spriteSeqData=enemySeqData, wpnSheet=ItemsTable.weaponLng.sheet, wpnFrameNum=1, 
	HP=20, ATK=5} );



----- end Demon Class declaration -----


return Demon;