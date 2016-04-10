---------------
--File: undead.lua
--
--Description:
--  This file holds ...
---------------

local ItemsTable = require("scripts.items");

local IMAGE_WIDTH = 16;
local IMAGE_HEIGHT = 16;

local sheetOptions = {
	frames = {
		{ x = 80, y = 16.0, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- mummy 1
		{ x = 80, y = 177.0, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- mummy 2
		{ x = 0.5, y = 32, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- white skeleton 1
		{ x = 0.5, y = 193, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- white skeleton 2
		{ x = 32.5, y = 32, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- green skeleton 1
		{ x = 32.5, y = 193, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- green skeleton 2
		{ x = 31, y = 63.5, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- white ghost 1
		{ x = 31, y = 225, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- white ghost 2
		{ x = -1, y = 96.5, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- dementor 1
		{ x = -2, y = 257, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- dementor 2
	}
};

local enemySheet = graphics.newImageSheet( "images/Characters/UndeadCombined.png", 
	sheetOptions );

-- Create animation sequence for animation
local enemySeqData = {
	{name = "mummy", frames={1,2}, time=1000},
	{name = "whiteSkeleton", frames={3,4}, time=1000},
	{name = "greenSkeleton", frames={5,6}, time=1000},
	{name = "whiteGhost", frames={7,8}, time=1000},
	{name = "dementor", frames={9,10}, time=1000},
}


----- Undead Class declaration -----

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
Undead = EnemyClass:new( {type="undead", movePattern="RANDOM", 
	spriteSheet=enemySheet, spriteSeqData=enemySeqData, wpnSheet=ItemsTable.weaponLng.sheet, wpnFrameNum=2,
	HP=10, ATK=3} );



----- end Undead Class declaration -----


return Undead;