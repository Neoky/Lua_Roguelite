---------------
--File: enemyClass.lua
--
--Description:
--  This file holds ...
---------------

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
--  Initializes the class attributes.
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
--  Creates image of enemy on tile and initializes movement.
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
--  Removes the image of the enemy and removes enemy object from object 
--  array.
--
--Arguments:
--
--Returns:
--  
------------------------
function EnemyClass:remove ()
	--print("[EnemyClass:remove] entered for " .. self.type);
	if self.shape ~= nil then
		-- remove image from tile
		self.shape:removeSelf();
		self.shape = nil;	
	end
	-- remove object from array
	self.objectArray[self.mapX][self.mapY] = nil;
end



------------------------
--Function:    move
--Description: 
--  Performs the next move for the enemy.
--
--Arguments:
--  Player coordinates
--Returns:
--  
------------------------
function EnemyClass:move(playerX, playerY)
	--print("[EnemyClass:move] entered for " .. self.type .. " with player pos " .. playerX .. "," .. playerY);

	local nextMove = "FALSE";
	local newX, newY = 0, 0;

	if self.moved == true then 
		return;  -- enemy has already moved during current turn
	end

	-- get next move for enemy
	nextMove, newX, newY = self.moveMgr:getNextMove( self.mapX, self.mapY, playerX, playerY );

	-- set flag so enemy is only moved once per turn
	self.moved = true;  

	if "ATTACK" == nextMove and self.objectArray[playerX][playerY] ~= nil then
		print("Enemy is attacking player with ATK " .. self.ATK .. "!");
		-- perform attack
		player = self.objectArray[playerX][playerY];
		player:reduceHP(self.ATK);
		return;
	elseif "FALSE" == nextMove then
		print("Error: Enemy cannot move from current position for " .. self.type .. "!");
		return;
	elseif newX == self.mapX and newY == self.mapY then
		-- enemy is standing in current position
		return;
	end
	
	-- move enemy image to new tile location 
	oldX, oldY = self.mapX, self.mapY
	print("[EnemyClass:move] Moving " .. self.type .. " from " .. oldX .. "," .. oldY .. " to " .. newX .. "," .. newY);
	self.mapX, self.mapY = newX, newY;
	self.shape.x = mapArray[self.mapX][self.mapY].x;
	self.shape.y = mapArray[self.mapX][self.mapY].y;

	-- update enemy location in object array if enemy moved
	self.objectArray[newX][newY] = objectArray[oldX][oldY];
	self.objectArray[oldX][oldY] = nil;	
end

------------------------
--Function:    hit
--Description: 
--  Called when the enemy has been attacked.
--
--Arguments:
--
--Returns:
--  
------------------------
function EnemyClass:hit(damage)
	print("Enemy has been hit with damage " .. damage);

	self.HP = self.HP - damage;
	if self.HP <= 0 then
		print("Enemy died!");
		self:remove();
	end
end

----- end Bass Class declaration -----




return EnemyClass;