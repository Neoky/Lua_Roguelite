---------------
--File: enemyMovement.lua
--
--Description:
--  This file holds ...
---------------

-- Room boundaries
local MIN_X_POS = 1;
local MAX_X_POS = 12;
local MIN_Y_POS = 1;
local MAX_Y_POS = 8;

local DOWN  = "down";
local LEFT  = "left";
local UP    = "up";
local RIGHT = "right";



local EnemyMovement = {type="STAND", mapArray={}, lastMove="INVALID", 
	minX=MIN_X_POS, maxX=MAX_X_POS,
	minY=MIN_Y_POS, maxY=MAX_Y_POS};


function EnemyMovement:new (o) --constructor
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
function EnemyMovement:init(typeArg, mapArrayArg, x, y, objArrayArg)
	--print("[EnemyMovement:init] entered with type = " .. typeArg);
	self.type = typeArg;  -- movement pattern (PATROL, RANDOM, etc.)
	self.mapArray = mapArrayArg;  -- save reference to room map
	self.objectArray = objArrayArg;

	-- initialize attributes for patrol movements
	if self.type == "PATROL_HORZ" then
		self.lastMove = LEFT;

		-- set x coordinate boundaries
		self.minX = math.max( MIN_X_POS, (x-3) );
		self.maxX = math.min( MAX_X_POS, (x+3) );
	elseif self.type == "PATROL_VERT" then
		self.lastMove = UP;

		-- set y coordinate boundaries
		self.minY = math.max( MIN_Y_POS, (y-3) );
		self.maxY = math.min( MAX_Y_POS, (y+3) );
	end
end

------------------------
--Function:    setType
--Description: 
--  Sets the movement pattern
--
--Arguments:
--
--Returns:
--  
------------------------
function EnemyMovement:setType(arg)
	---print("[EnemyMovement:setType] entered with type = " .. arg);
	self.type = arg;

	-- reset attributes
	if self.type == "PATROL_HORZ" then
		-- set x coordinate boundaries
		self.minX = math.max( MIN_X_POS, (x-3) );
		self.maxX = math.min( MAX_X_POS, (x+3) );
	elseif self.type == "PATROL_VERT" then
		-- set y coordinate boundaries
		self.minY = math.max( MIN_Y_POS, (y-3) );
		self.maxY = math.min( MAX_Y_POS, (y+3) );
	else
		lastMove  ="INVALID";
		self.minX = MIN_X_POS;
		self.maxX = MAX_X_POS;
		self.minY = MIN_Y_POS;
		self.maxY = MAX_Y_POS;
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
function EnemyMovement:playerLocalSearch(enemyX, enemyY, playerX, playerY)
	--print("[EnemyMovement:playerLocalSearch] entered");

	if playerX == enemyX and playerY == (enemyY+1) then
		return true;
	elseif playerX == (enemyX-1) and playerY == enemyY then
		return true;
	elseif playerX == enemyX and playerY == (enemyY-1) then
		return true;
	elseif playerX == (enemyX+1) and playerY == enemyY then
		return true;
	end

	return false;
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
function EnemyMovement:playerDistantSearch(enemyX, enemyY, playerX, playerY)
	--print("[EnemyMovement:playerDistantSearch] entered");
	newX, newY = 0, 0;

	if playerX == enemyX and playerY == (enemyY+2) then
		newX, newY = enemyX, (enemyY+1);
	elseif playerX == (enemyX-2) and playerY == enemyY then
		newX, newY = (enemyX-1), enemyY;
	elseif playerX == enemyX and playerY == (enemyY-2) then
		newX, newY = enemyX, (enemyY-1);
	elseif playerX == (enemyX+2) and playerY == enemyY then
		newX, newY = (enemyX+1), enemyY;
	else return false;
	end


	if self.mapArray[newX][newY].passable == false then
		print("Cannot move to player because tile is not passable");
		return false; -- tile is not passable by enemy
	elseif self.objectArray[newX][newY] ~= nil then
		print("Cannot move to player because object is in way");
		return false; -- something is already on the tile btw the player and enemy
	end

	return true, newX, newY;
end

------------------------
--Function:    getRandomNextMove
--Description: 
--  Randomly determines the next move for the enemy
--
--Arguments:
--
--Returns:
--  
------------------------
function EnemyMovement:getRandomNextMove(x, y)
	--print("[EnemyMovement:getRandomNextMove] entered");
	local movesArray = {};
	local newX, newY = x, y;

	-- check all valid moves
	if ( self.mapArray[x][y+1].passable == true and 
		 self.objectArray[x][y+1] == nil and
	     (y+1) < self.maxY ) then
		table.insert(movesArray, DOWN);
	end
	if ( self.mapArray[x-1][y].passable == true and 
		 self.objectArray[x-1][y] == nil and
	     (x-1) > self.minX ) then
		table.insert(movesArray, LEFT);
	end
	if ( self.mapArray[x][y-1].passable == true and 
		 self.objectArray[x][y-1] == nil and
	     (y-1) > self.minY ) then
		table.insert(movesArray, UP);
	end
	if ( self.mapArray[x+1][y].passable == true and 
		 self.objectArray[x+1][y] == nil and
	     (x+1) < self.maxX ) then
		table.insert(movesArray, RIGHT);
	end

	if #movesArray == 0 then
		return false, x, y; -- no valid moves available
	end

	-- randomly select a valid move
	local nextMove = movesArray[ math.random(#movesArray) ];

	if DOWN == nextMove then
		newY = y+1;
	elseif LEFT == nextMove then
		newX = x-1;
	elseif UP == nextMove then
		newY = y-1;
	elseif RIGHT == nextMove then
		newX = x+1;
	end

	self.lastMove = nextMove;  -- save last move

	-- return coordinates for next move
	return true, newX, newY;
end

------------------------
--Function:    getPatrolHorzNextMove
--Description: 
--  Determines the next enemy move based on a horizontal patrol
--  pattern
--
--Arguments:
--
--Returns:
--  
------------------------
function EnemyMovement:getPatrolHorzNextMove(x, y)
	--print("[EnemyMovement:getPatrolHorzNextMove] entered");
	local moveLeft, moveRight = false, false;
	local newX, newY = x, y;
	local nextMove = "INVALID";

	-- check all valid moves
	if ( self.mapArray[x-1][y].passable == true and
		 self.objectArray[x-1][y] == nil and  
	     (x-1) > self.minX ) then
		moveLeft = true;
	end
	if ( self.mapArray[x+1][y].passable == true and 
		 self.objectArray[x+1][y] == nil and
	     (x+1) < self.maxX ) then
		moveRight = true;
	end

	if not moveLeft and not moveRight then
		return false, x, y;  -- no valid moves available
	elseif moveLeft and self.lastMove == LEFT then
		nextMove = LEFT;
	elseif moveRight and self.lastMove == RIGHT then
		nextMove = RIGHT;
	elseif moveLeft then nextMove = LEFT;
	elseif moveRight then nextMove = RIGHT;
	else return false, x, y;
	end

	if LEFT == nextMove then
		newX = x-1;
	elseif RIGHT == nextMove then
		newX = x+1;
	end

	self.lastMove = nextMove;  -- save last move

	-- return coordinates for next move
	return true, newX, newY;
end

------------------------
--Function:    getPatrolVertNextMove
--Description: 
--  Determines the next enemy move based on a vertical patrol
--  pattern
--
--Arguments:
--
--Returns:
--  
------------------------
function EnemyMovement:getPatrolVertNextMove(x, y)
	--print("[EnemyMovement:getPatrolVertNextMove] entered");
	local moveDown, moveUp = false, false;
	local newX, newY = x, y;
	local nextMove = "INVALID";

	-- check all valid moves for enemy
	if ( self.mapArray[x][y-1].passable == true and
		 self.objectArray[x][y-1] == nil and 
	     (y-1) > self.minY ) then
		moveUp = true;
	end
	if ( self.mapArray[x][y+1].passable == true and 
		 self.objectArray[x][y+1] == nil and
	     (y+1) < self.maxY ) then
		moveDown = true;
	end

	if not moveDown and not moveUp then
		return false, x, y;  -- no valid moves available
	elseif moveDown and self.lastMove == DOWN then
		nextMove = DOWN;
	elseif moveUp and self.lastMove == UP then
		nextMove = UP;
	elseif moveDown then nextMove = DOWN;
	elseif moveUp then nextMove = UP;
	else return false, x, y;
	end

	if DOWN == nextMove then
		newY = y+1;
	elseif UP == nextMove then
		newY = y-1;
	end

	self.lastMove = nextMove;  -- save last move

	-- return coordinates for next move
	return true, newX, newY;
end

------------------------
--Function:    getNextMove
--Description: 
--  Determines the next enemy move based on the movement pattern 
--  of the enemy
--
--Arguments:
--
--Returns:
--  
------------------------
function EnemyMovement:getNextMove(x, y, playerX, playerY)
	local foundPlayer = false;

	-- first look at neighboring tiles for player
	foundPlayer = self:playerLocalSearch(x, y, playerX, playerY);
	if foundPlayer == true then
		return "ATTACK", x, y; -- stay in current tile and attack player
	end

	if self.type ~= "STAND" then
		-- moving enemies can look at distant tiles for player
		foundPlayer, newX, newY = self:playerDistantSearch(x, y, playerX, playerY);
		if foundPlayer == true then
			print("[EnemyMovement:getNextMove] going into SEEK mode");
			self:setType("SEEK");
			return true, newX, newY;
		elseif self.type == "SEEK" then
			-- somehow lost player during SEEK mode so return to RANDOM mode
			print("[EnemyMovement:getNextMove] returning to RANDOM mode");
			self:setType("RANDOM");
		end
	end

	if self.type == "RANDOM" then
		return self:getRandomNextMove(x, y);
	elseif self.type == "PATROL_HORZ" then
		return self:getPatrolHorzNextMove(x, y);
	elseif self.type == "PATROL_VERT" then
		return self:getPatrolVertNextMove(x, y);
	end

	return "TRUE", x, y;  -- no movement
end



return EnemyMovement;