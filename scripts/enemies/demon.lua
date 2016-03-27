---------------
--File: demon.lua
--
--Description:
--  This file holds ...
---------------

local ItemsTable = require("scripts.items");

local IMAGE_WIDTH = 16;
local IMAGE_HEIGHT = 16;

sheetOptions = {
	frames = {
		{ x = 0.1, y = 0.5, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- green dragon
		{ x = 0.1, y = 16, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- red demon
	}
};

enemySheet = graphics.newImageSheet( "images/Characters/Demon0.png", 
	sheetOptions );


----- Demon Class declaration -----

local EnemyClass = require("scripts.enemyClass");
Demon = EnemyClass:new( {type="demon", movePattern="STAND", 
	sheet=enemySheet, wpnSheet=ItemsTable.weaponLng.sheet, wpnFrameNum=1, 
	HP=20, ATK=5} );



----- end Demon Class declaration -----


return Demon;