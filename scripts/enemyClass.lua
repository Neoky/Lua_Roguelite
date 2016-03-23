---------------
--File: enemyClass.lua
--
--Description:
--  This file holds ...
---------------

local EnemyTable = require("scripts.enemy");
local EnemyMovement = require("scripts.enemyMovement");

local MIN_X_POS = 0;
local MAX_X_POS = 12;
local MIN_Y_POS = 0;
local MAX_Y_POS = 8;


----- Bass Class declaration -----

-- HP = hit points
-- ATK = attack points
local EnemyClass = {tag="enemy", moved=false, mapArray={}, movePattern="STAND", HP=10, ATK=3, 
	passable=true, pushable=false};


function EnemyClass:new (o) --constructor
	o = o or {};
	setmetatable(o, self);
	self.__index = self;
	return o;
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
function EnemyClass:init (frameNumArg, movePatternArg, mapArrayArg, mapX, mapY, tileScale, objArray)
	self.frameNum = frameNumArg;
	self.movePattern = movePatternArg;

	self.mapArray = mapArrayArg;
	self.mapX = mapX;
	self.mapY = mapY;
	self.tileScale = tileScale;
	self.objectArray = objArray;
end

------------------------
--Function:    spawn
--Description: 
--  Creates image of enemy on tile
--
--Arguments:
--
--Returns:
--  
------------------------
function EnemyClass:spawn()
	-- create enemy image on given tile location 
	self.shape = display.newImage( self.sheet, self.frameNum );
	self.shape.x = self.mapArray[self.mapX][self.mapY].x;
	self.shape.y = self.mapArray[self.mapX][self.mapY].y;
	self.shape:scale(self.tileScale,self.tileScale);
	self.shape:toFront( );

	-- initialize movement manager
	self.moveMgr = EnemyMovement:new( );
	self.moveMgr:init( self.movePattern, self.mapArray, self.mapX, self.mapY, self.objectArray );
end

------------------------
--Function:    remove
--Description: 
--  Removes the image of the enemy
--
--Arguments:
--
--Returns:
--  
------------------------
function EnemyClass:remove ()
	--print("[EnemyClass:remove] entered for " .. self.type);
	if self.shape ~= nil then
		-- remove image
		self.shape:removeSelf();
		self.shape = nil;	
	end
	self.objectArray[self.mapX][self.mapY] = nil;
end



------------------------
--Function:    move
--Description: 
--  Moves the enemy to another tile based on its movement type
--
--Arguments:
--
--Returns:
--  
------------------------
function EnemyClass:move(playerX, playerY)
	print("[EnemyClass:move] entered for " .. self.type .. " with player pos " .. playerX .. "," .. playerY);

	local validMove = "FALSE";
	local newX, newY = 0, 0;

	-- get next valid move for enemy
	validMove, newX, newY = self.moveMgr:getNextMove( self.mapX, self.mapY, playerX, playerY );

	if "ATTACK" == validMove and self.objectArray[playerX][playerY] ~= nil then
		print("Enemy is attacking player with ATK " .. self.ATK .. "!");
		-- perform attack
		player = self.objectArray[playerX][playerY];
		player:reduceHP(self.ATK);
		return validMove, newX, newY;
	elseif "FALSE" == validMove then
		print("[EnemyClass:move] Cannot move from current position for " .. self.type .. "!");
		return "FALSE", 0, 0;
	elseif newX == self.mapX and newY == self.mapY then
		-- enemy has not moved from current position
		print("[EnemyClass:move] Standing in current position for " .. self.type);
		return "FALSE", 0, 0;
	end
	
	-- move enemy image to new tile location 
	print("[EnemyClass:move] Moving from " .. self.mapX .. "," .. self.mapY .. " to " .. newX .. "," .. newY .. " for " .. self.type);
	self.mapX, self.mapY = newX, newY;
	self.shape.x = mapArray[self.mapX][self.mapY].x;
	self.shape.y = mapArray[self.mapX][self.mapY].y;
	return "TRUE", newX, newY;
end

------------------------
--Function:    Attack
--Description: 
--  Performs an Attack on a target in a nearby tile
--
--Arguments:
--
--Returns:
--  
------------------------
function EnemyClass:attack(targetX, targetY)
	print("[EnemyClass:attack] entered for " .. self.type);
	self.mapArray[targetX][targetY]:hit(self.ATK);
end

------------------------
--Function:    hit
--Description: 
--  Called when the enemy has been Attacked
--
--Arguments:
--
--Returns:
--  
------------------------
function EnemyClass:hit(damage)
	print("[EnemyClass:hit] entered for " .. self.type);

	self.HP = self.HP - damage;
	if self.HP <= 0 then
		print("Enemy died!");
		self:remove();
	end
end

----- end Bass Class declaration -----




return EnemyClass;