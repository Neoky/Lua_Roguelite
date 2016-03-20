---------------
--File: pest.lua
--
--Description:
--  This file holds ...
---------------

local EnemyTable = require("scripts.enemy");


----- Pest Class declaration -----

local EnemyClass = require("scripts.enemyClass");
Pest = EnemyClass:new( {type="pest", movePATKern="RANDOM", 
	sheet=EnemyTable.pest.sheet, HP=5, ATK=1} );

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
function Pest:init (frameNumArg)
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
function Pest:init (frameNumArg, movePATKernArg)
	self.frameNum = frameNumArg;
	self.movePATKern = movePATKernArg;
end



----- end Pest Class declaration -----


return Pest;