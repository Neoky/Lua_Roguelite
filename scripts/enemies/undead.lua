---------------
--File: undead.lua
--
--Description:
--  This file holds ...
---------------

local EnemyTable = require("scripts.enemy");


----- Undead Class declaration -----

local EnemyClass = require("scripts.enemyClass");
Undead = EnemyClass:new( {type="undead", movePATKern="RANDOM", 
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
function Undead:init (frameNumArg, movePATKernArg)
	self.frameNum = frameNumArg;
	self.movePATKern = movePATKernArg;
end



----- end Undead Class declaration -----


return Undead;