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

------------------------
--Function:    init
--Description: 
--  Initializes the class ATKributes
--
--Arguments:
--
--Returns:
--  
------------------------
function Undead:init (frameNumArg)
	self.frameNum = frameNumArg;
end

------------------------
--Function:    init
--Description: 
--  Initializes the class ATKributes
--
--Arguments:
--
--Returns:
--  
------------------------
function Undead:init (frameNumArg, movePatternArg)
	self.frameNum = frameNumArg;
	self.movePattern = movePatternArg;
end



----- end Undead Class declaration -----


return Undead;