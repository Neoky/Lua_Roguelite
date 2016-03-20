---------------
--File: demon.lua
--
--Description:
--  This file holds ...
---------------

local EnemyTable = require("scripts.enemy");


----- Demon Class declaration -----

local EnemyClass = require("scripts.enemyClass");
Demon = EnemyClass:new( {type="demon", movePATKern="STAND", 
	sheet=EnemyTable.demon.sheet, HP=20, ATK=5} );

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
function Demon:init (frameNumArg)
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
function Demon:init (frameNumArg, movePATKernArg)
	self.frameNum = frameNumArg;
	self.movePATKern = movePATKernArg;
end



----- end Demon Class declaration -----


return Demon;