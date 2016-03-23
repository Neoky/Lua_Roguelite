---------------
--File: pest.lua
--
--Description:
--  This file holds ...
---------------

local EnemyTable = require("scripts.enemy");


----- Pest Class declaration -----

local EnemyClass = require("scripts.enemyClass");
Pest = EnemyClass:new( {type="pest", movePattern="RANDOM", 
	sheet=EnemyTable.pest.sheet, HP=5, ATK=1} );



----- end Pest Class declaration -----


return Pest;