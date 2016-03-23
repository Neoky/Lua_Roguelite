---------------
--File: demon.lua
--
--Description:
--  This file holds ...
---------------

local EnemyTable = require("scripts.enemy");


----- Demon Class declaration -----

local EnemyClass = require("scripts.enemyClass");
Demon = EnemyClass:new( {type="demon", movePattern="STAND", 
	sheet=EnemyTable.demon.sheet, HP=20, ATK=5} );



----- end Demon Class declaration -----


return Demon;