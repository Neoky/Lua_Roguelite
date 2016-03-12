---------------
--File: enemyClass.lua
--
--Description:
--  This file holds ...
---------------

local EnemyTable = require("enemy");
local EnemyMovement = require("enemyMovement");

local MIN_X_POS = 0;
local MAX_X_POS = 15;
local MIN_Y_POS = 0;
local MAX_Y_POS = 8;


----- Bass Class declaration -----

local EnemyClass = {tag="enemy", movePattern="STAND", HP=10, DAM=3, 
	passable=false, pushable=false};


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
function EnemyClass:init (typeArg, frameNumArg, movePatternArg)
	self.type = typeArg;
	self.frameNum = frameNumArg;
	self.movePattern = movePatternArg;

	-- populate enemy attributes
	local enemyAttrs = nil;
	if (typeArg == "demon") then
		enemyAttrs = EnemyTable.demon;
	elseif (typeArg == "undead") then
		enemyAttrs = EnemyTable.undead;
	elseif (typeArg == "pest") then
		enemyAttrs = EnemyTable.pest;
	else
		print("[EnemyClass:init] Received unexpected enemy type!");
		return;
	end

	self.sheet = enemyAttrs.sheet;
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
function EnemyClass:spawn(mapArray, mapX, mapY, tileScale)
	self.mapArray = mapArray;
	self.mapX = mapX;
	self.mapY = mapY;
	
	-- create enemy image on given tile location 
	self.shape = display.newImage( self.sheet, self.frameNum );
	self.shape.x = mapArray[mapX][mapY].x;
	self.shape.y = mapArray[mapX][mapY].y;
	self.shape:scale(tileScale,tileScale);
	self.shape:toFront( );

	-- set object x,y coordinates for tile placement
	self.x = mapArray[mapX][mapY].x;
	self.y = mapArray[mapX][mapY].y;

	-- initialize movement manager
	self.moveMgr = EnemyMovement:new( );
	self.moveMgr:init( self.movePattern, mapArray, mapX, mapY );
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

		-- clear enemy attributes from tile
		self.tag = "";
		self.passable = true;
	end
end

------------------------
--Function:    playerLocalSearch
--Description: 
--  Searches the neighboring tiles for the player
--
--Arguments:
--
--Returns:
--  
------------------------
function EnemyClass:playerLocalSearch()
	--print("[EnemyClass:playerLocalSearch] entered");

	if ( self.mapArray[self.mapX][self.mapY+1].tag == "player" ) then
		return true, self.mapX, (self.mapY+1);
	elseif ( self.mapArray[self.mapX-1][self.mapY].tag == "player" ) then
		return true, (self.mapX-1), self.mapY;
	elseif ( self.mapArray[self.mapX][self.mapY-1].tag == "player" ) then
		return true, self.mapX, (self.mapY-1);
	elseif ( self.mapArray[self.mapX+1][self.mapY].tag == "player" ) then
		return true, (self.mapX+1), self.mapY;
	end

	return false, 0, 0;
end

------------------------
--Function:    playerDistantSearch
--Description: 
--  Searches the distant tiles for the player
--
--Arguments:
--
--Returns:
--  
------------------------
function EnemyClass:playerDistantSearch()
	--print("[EnemyClass:playerDistantSearch] entered");

	if ( self.mapY+2 < MAX_Y_POS and 
		 self.mapArray[self.mapX][self.mapY+2].tag == "player" ) then
		return true, self.mapX, (self.mapY+2);
	elseif ( self.mapX-2 > MIN_X_POS and
			 self.mapArray[self.mapX-2][self.mapY].tag == "player" ) then
		return true, (self.mapX-2), self.mapY;
	elseif ( self.mapY-2 > MIN_Y_POS and
		     self.mapArray[self.mapX][self.mapY-2].tag == "player" ) then
		return true, self.mapX, (self.mapY-2);
	elseif ( self.mapX+2 < MAX_X_POS and 
			 self.mapArray[self.mapX+2][self.mapY].tag == "player" ) then
		return true, (self.mapX+2), self.mapY;
	end

	return false, 0, 0;
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
function EnemyClass:move()
	--print("[EnemyClass:move] entered for " .. self.type);

	-- look around for player in nearby tile
	local foundPlayer = false;

	-- first look at neighboring tiles
	foundPlayer, targetX, targetY = self:playerLocalSearch();
	if foundPlayer == true then
		--print("[EnemyClass:move] Discovered target at local position: " .. targetX .. "," .. targetY);
		-- attack target
		self:attack(targetX, targetY);
		return;
	else
		-- look at distant tiles for the player
		foundPlayer, targetX, targetY = self:playerDistantSearch();
		if foundPlayer == true then
			--print("[EnemyClass:move] Discovered target at distant position: " .. targetX .. "," .. targetY);
		end
	end


	-- get next valid move for enemy
	validMove, newX, newY = self.moveMgr:getNextMove( self.mapX, self.mapY );

	if false == validMove then
		print("[EnemyClass:move] Cannot move from current position!");
		return;
	elseif newX == self.mapX and newY == self.mapY then
		print("[EnemyClass:move] Standing in current position");
		return;
	end

	-- Reset current tile attributes before moving enemy to next tile. This will allow 
	-- the enemy and other dynamic entities to enter the tile after the enemy moves.
	self.mapArray[self.mapX][self.mapY].passable = true;
	self.mapArray[self.mapX][self.mapY].tag = "";
	
	-- move enemy to new tile location 
	print("[EnemyClass:move] Moving from " .. self.mapX .. "," .. self.mapY .. " to " .. newX .. "," .. newY);
	self.mapX, self.mapY = newX, newY;
	self.shape.x = mapArray[self.mapX][self.mapY].x;
	self.shape.y = mapArray[self.mapX][self.mapY].y;
end

------------------------
--Function:    attack
--Description: 
--  Performs an attack on a target in a nearby tile
--
--Arguments:
--
--Returns:
--  
------------------------
function EnemyClass:attack(targetX, targetY)
	print("[EnemyClass:attack] entered for " .. self.type);
	self.mapArray[targetX][targetY]:hit(self.DAM);
end

------------------------
--Function:    hit
--Description: 
--  Called when the enemy has been attacked
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