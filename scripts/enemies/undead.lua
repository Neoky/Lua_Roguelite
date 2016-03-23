---------------
--File: undead.lua
--
--Description:
--  This file holds ...
---------------

local EnemyTable = require("scripts.enemy");


----- Undead Class declaration -----

local EnemyClass = require("scripts.enemyClass");
Undead = EnemyClass:new( {type="undead", movePattern="RANDOM", 
	sheet=EnemyTable.undead.sheet, HP=10, ATK=3} );



----- end Undead Class declaration -----


return Undead;