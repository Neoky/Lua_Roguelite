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
	sheet=EnemyTable.pest.sheet, HP=5, ATT=1} );

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
function Pest:init (frameNumArg)
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
function Pest:init (frameNumArg, movePatternArg)
	self.frameNum = frameNumArg;
	self.movePattern = movePatternArg;
end



----- end Pest Class declaration -----


return Pest;