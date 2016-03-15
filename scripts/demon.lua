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
	sheet=EnemyTable.demon.sheet, HP=20, ATT=5} );

------------------------
--Function:    init
--Description: 
--  Initializes the class attributes
--
--Arguments:
--
--Returns:
--  
------------------------
function Demon:init (frameNumArg)
	self.frameNum = frameNumArg;
end

------------------------
--Function:    init
--Description: 
--  Initializes the class attributes
--
--Arguments:
--
--Returns:
--  
------------------------
function Demon:init (frameNumArg, movePatternArg)
	self.frameNum = frameNumArg;
	self.movePattern = movePatternArg;
end



----- end Demon Class declaration -----


return Demon;