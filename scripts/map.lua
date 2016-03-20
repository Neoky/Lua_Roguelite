---------------
--File: Map.lua
--
--Description:
--  This file holds all of the map generation functionality that can be 
--  used when creating the levels in the game
---------------
local Player = require("scripts.player")
local ItemsTable = require("scripts.items");

local DemonClass = require("scripts.demon");
local UndeadClass = require("scripts.undead");
local PestClass = require("scripts.pest");

local Map = {player={}, upArrow={},rightArrow={},downArrow={},leftArrow={},mapArray={}}

local player;

local xx = display.contentWidth
local yy = display.contentHeight

--16:9 aspect ratio is the default screen size (Maybe change this?)
local Nboxes = 80/5
local Mboxes = 45/5

local sizeX = ( display.actualContentWidth  / Nboxes)
local sizeY = ( display.actualContentHeight / Mboxes)

--Set up floor tiles
local tOptions =
{
	frames = {
		{ x =   0,   y =  0,  width = 16, height = 16}, --brown block
		{ x =  80,   y = 32,  width = 16, height = 16}, --grey block		
	}
}

local tileSheet = graphics.newImageSheet( "images/Objects/Tile.png", tOptions )

--Set up walls
local wOptions =
{
	frames = {
		{ x =  0,  y = 48,  width = 16, height = 16}, --top left corner		
		{ x = 16,  y = 48,  width = 16, height = 16}, --top/bottom wall
		{ x = 32,  y = 48,  width = 16, height = 16}, --top right corner
		{ x =  0,  y = 64,  width = 16, height = 16}, --side wall
		{ x =  0,  y = 80,  width = 16, height = 16}, --bottom left corner	
		{ x = 32,  y = 80,  width = 16, height = 16}, --bottom right corner
	}
};

local wallSheet = graphics.newImageSheet( "images/Objects/Wall.png", wOptions )

--Set up player character
local pOptions =
{
	frames = {
		{ x =  16,  y =  48,  width = 16, height = 16}, -- Knight Dude
	}
};

local playerSheet = graphics.newImageSheet( "images/Characters/Player0.png", pOptions )

--Set up movement arrows (and other icons)
local iOptions =
{
	frames = {
		{ x = 16,  y =  0,  width = 16, height = 16}, -- Arrow
	}
};

local iconSheet = graphics.newImageSheet( "images/Commissions/Icons.png", iOptions )


--Array used to keep track of created image sheets, use the text strings when passing into functions
--  in order to get the correct image sheet
local sheetList = 
{
		["tile"]   = tileSheet,
		["wall"]   = wallSheet, 
		["door"]   = ItemsTable.door.sheet,
		["decor"]  = ItemsTable.decor.sheet,
		["player"] = playerSheet,
		["trap"]   = ItemsTable.trap.sheet,
		["armor"]  = ItemsTable.armor.sheet,
		["boot"]  = ItemsTable.boot.sheet,
		["chestClosed"]  = ItemsTable.chestClosed.sheet,
		["chestOpen"]  = ItemsTable.chestOpen.sheet,
		["hat"]  = ItemsTable.hat.sheet,
		["key"]  = ItemsTable.key.sheet,
		["potion"]  = ItemsTable.potion.sheet,
		["shield"]  = ItemsTable.shield.sheet,
		["weapon"]  = ItemsTable.weapon.sheet,
}


local tileScale = 5
local tileSize  = 16 * tileScale

doorFrame = 1
tileFrame = 1


function Map:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end


------------------------
--Function:    makeRoom
--Description: 
--  Creates a default room with walls on all 4 sides and blank tiles in the middle
--  Will also create doors if specified
--
--Arguments:
--  topDoor    - boolean  - Used to create door on top wall
--  leftDoor   - boolean  - Used to create door on left wall
--  rightDoor  - boolean  - Used to create door on right wall
--  bottomDoor - boolean  - Used to create door on bottom wall
--
--Returns:
--  A map array of the tiles that make up the created room
------------------------ 
function Map:makeRoom(topDoor, leftDoor, rightDoor, bottomDoor)
	
	mapArray = {}
	local doorSheet = sheetList["door"];

	for i=0, Nboxes-1 do

		mapArray[i] = {}

	    for j=0, Mboxes-1 do

	        --Top row
	        if j == 0 then
	        	--Top Left Corner
	        	if i == 0 then 
	        		tile = display.newImage (wallSheet, 1)
	        	--Top Right Corner
	        	elseif i == Nboxes-1 then
	        		tile = display.newImage (wallSheet, 3)
	       		else
		        	--Check for door
		        	if(topDoor == true) and (i == math.floor(Nboxes/2)) then
		        		tile = display.newImage (doorSheet, doorFrame)
		        		tile.passable = true 
		        	else
		        		tile = display.newImage (wallSheet, 2)
		        	end	       			
	       		end

	        --Left side
	        elseif i == 0 then
	        	--Bottom left corner
	        	if j == Mboxes -1 then
	        		tile = display.newImage (wallSheet, 5)
	        	else
		        	--Check for door
		        	if(leftDoor == true) and (j == math.floor(Mboxes/2)) then
		        		tile = display.newImage (doorSheet, doorFrame)
		        		tile.passable = true 
		        	else
		        		tile = display.newImage (wallSheet, 4)
		        	end 
		        end

	       --Right side
	        elseif i == Nboxes-1  then
	        	--Bottom right corner
	        	if j == Mboxes -1 then
	        		tile = display.newImage (wallSheet, 6)
	        	else
		        	--Check for door
		        	if(rightDoor == true) and (j == math.floor(Mboxes/2)) then
		        		tile = display.newImage (doorSheet, doorFrame)
		        		tile.passable = true 
		        	else
		        		tile = display.newImage (wallSheet, 4)
		        	end
	       		end

	       	--Bottom Row
	        elseif j == Mboxes-1 then
		        --Check for door
		        if(bottomDoor == true) and (i == math.floor(Nboxes/2)) then
		        	tile = display.newImage (doorSheet, doorFrame)
		        	tile.passable = true 
		        else
		        	tile = display.newImage (wallSheet, 2)
		        end

	       	--Normal tiles
	        else
	        	tile = display.newImage (tileSheet, tileFrame)
	        	tile.passable = true  
	        end

	        if tile.passable == nil then
	        	tile.passable = false
	        end

	        tile:scale (tileScale, tileScale)

	        tile.x = tileSize/2 + tileSize*i
			tile.y = tileSize/2 + tileSize*j   

			mapArray[i][j] = tile

	    end
	end
	self.mapArray=mapArray
	return mapArray
end

------------------------
--Function:    swapTile
--Description: 
--  Swaps out a floor tile with a different floor tile
--
--Arguments:
--  mapArray  - tile Array - Array that stores the level map
--  tileSheet - String     - String used to specify tilesheet to use
--  frameNum  - integer    - Specifies frame to pull from tilesheet
--  xVal      - integer    - x value for tile
--  yVal      - integer    - y value for tile
--  passable  - boolean    - specifies if the tile is passable
--
--Returns:
--  A tile that has been swapped out
------------------------
function Map:swapTile(tileSheet, frameNum, xVal, yVal, passable)

	newTile = display.newImage( sheetList[tileSheet], frameNum)

	newTile.x = mapArray[xVal][yVal].x
	newTile.y = mapArray[xVal][yVal].y
	newTile.passable = passable


	mapArray[xVal][xVal] = newTile
	mapArray[xVal][xVal]:scale(tileScale, tileScale)

	return mapArray[xVal][yVal]
end


------------------------
--Function:    placeObject
--Description: 
--  Places an object on top of a tile on the map
--
--Arguments:
--  mapArray  - tile Array - Array that stores the level map
--  tileSheet - String     - String used to specify tilesheet to use
--  frameNum  - integer    - Specifies frame to pull from tilesheet
--  xVal      - integer    - x value for tile
--  yVal      - integer    - y value for tile
--  passable  - boolean    - specifies if the tile is passable
--  pushable  - boolean    - specifies if the tile is pushable
--
--Returns:
--  The object that has been placed
------------------------
function Map:placeObject(tileSheet, frameNum, xVal, yVal, passable, pushable)
	local newEnemyObj = nil;

	-- check for enemy objects
	if ( tileSheet == "pest" ) then 
		newEnemyObj = PestClass:new();
		newEnemyObj:init( frameNum, "RANDOM" );  -- initialize enemy attributes 
	elseif ( tileSheet == "undead" ) then
		newEnemyObj = UndeadClass:new();
		newEnemyObj:init( frameNum, "RANDOM" );  -- initialize enemy attributes 
	elseif ( tileSheet == "demon" ) then
		newEnemyObj = DemonClass:new();
		newEnemyObj:init( frameNum, "STAND" );  -- initialize enemy attributes 
	end
	
	if ( newEnemyObj ~= nil ) then
		-- create image of enemy on tile
		newEnemyObj:spawn( mapArray, xVal, yVal, tileScale );
		
		--- TEST JB : add touch listener to test enemy movement
		local function touchListener(event)
			if (event.phase == "began") then
				newEnemyObj:move();
			end
		end
		newEnemyObj.shape:addEventListener("touch", touchListener);
		---

		return newEnemyObj;
	end

	newObject = display.newImage( sheetList[tileSheet], frameNum) 
	newObject.x = mapArray[xVal][yVal].x
	newObject.y = mapArray[xVal][yVal].y

	newObject.passable = passable
	newObject.pushable = pushable

	newObject:scale(tileScale,tileScale)

	newObject:toFront( )

	-- set object tag to tile
	newObject.tag = tileSheet;

	return newObject
end

------------------------
--Function:    buildMap
--Description: 
--  Builds a map over the default map based on a user-specified list
--
--Arguments:
--  mapArray    - tile Array - Array that stores the level map
--  creatorList - info Array - Array listing tiles to replace in the map
--
--Returns:
--  The array of map tiles for the level
------------------------
function Map:buildMap(creatorList)

	for i = 1, #creatorList do 
		x = creatorList[i][3]
		y = creatorList[i][4]

		mapArray[x][y] = Map:swapTile(  
			creatorList[i][1],
			creatorList[i][2],
			x,
			y,
			creatorList[i][5])
	end

	return mapArray
end


------------------------
--Function:    fillMap
--Description: 
--  Place objects on the map based on a user-specified list
--
--Arguments:
--  mapArray    - tile Array - Array that stores the level map
--  objectList  - info Array - Array listing objects to place in the map
--
--Returns:
--  The array of map tiles for the level
------------------------
function Map:fillMap(objectList)

	for i = 1, #objectList do 
		x = objectList[i][3]
		y = objectList[i][4]

		mapArray[x][y] = Map:placeObject(  
			objectList[i][1],
			objectList[i][2],
			x,
			y,
			objectList[i][5],
			objectList[i][6])
	end

	return mapArray
	
end


------------------------
--Function:    placePlayer
--Description: 
--  Places a player character on the map
--
--Arguments:
--  mapArray  - tile Array - Array that stores the level map
--  tileSheet - String     - String used to specify tilesheet to use
--  frameNum  - integer    - Specifies frame to pull from tilesheet
--  xVal      - integer    - x value to place character at
--  yVal      - integer    - y value to place character at
--
--Returns:
--  The object representing the character
------------------------
function Map:placePlayer(tileSheet, frameNum, xVal, yVal)

	self.player = Player:new({hpCur=100, hpMax=100, attack=2, keys=0, rKey=0, gKey=0, bKey=0, xPos=xVal, yPos=yVal, map=self, tileSheet=tileSheet})
	self.player:spawn()
	self.player:move(xVal, yVal)
	self.player.body:scale(tileScale,tileScale)
	self.player.body:toFront()

	player = self.player;
	self:setArrows(xVal, yVal)

	return player;
end


------------------------
--Function:    setArrows
--Description: 
--  Places arrows around the player character. Will only place the arrow if the 
--  tile is something the player can pass through
--
--Arguments:
--  mapArray  - tile Array - Array that stores the level map
--  xVal      - integer    - x value for player
--  yVal      - integer    - y value for player
--
--Returns:
--  Nothing
------------------------
function Map:setArrows(xVal, yVal)
	upArrow    = nil
	downArrow  = nil
	leftArrow  = nil
	rightArrow = nil

	if mapArray[xVal][yVal-1].passable == true then

		upArrow = display.newImage( iconSheet, 1)
		upArrow.x = mapArray[xVal][yVal-1].x
		upArrow.y = mapArray[xVal][yVal-1].y
		upArrow.xVal, upArrow.yVal = xVal, yVal-1

		upArrow:toFront()

		upArrow:scale( tileScale, tileScale )
		self.upArrow = upArrow

		--TODO: Create tap event here for movement
	end

	if mapArray[xVal][yVal+1].passable == true then
		downArrow = display.newImage( iconSheet, 1) 

		downArrow.x = mapArray[xVal][yVal+1].x
		downArrow.y = mapArray[xVal][yVal+1].y
		downArrow.xVal, downArrow.yVal = xVal, yVal+1

		downArrow:rotate( 180 )

		downArrow:toFront()

		downArrow:scale( tileScale, tileScale )
		self.downArrow = downArrow
		
		--TODO: Create tap event here for movement
	end

	if mapArray[xVal-1][yVal].passable == true then
		leftArrow = display.newImage( iconSheet, 1) 

		leftArrow.x = mapArray[xVal-1][yVal].x
		leftArrow.y = mapArray[xVal-1][yVal].y
		leftArrow.xVal, leftArrow.yVal = xVal-1, yVal

		leftArrow:rotate( -90 )

		leftArrow:toFront()

		leftArrow:scale( tileScale, tileScale )
		self.leftArrow = leftArrow

		--TODO: Create tap event here for movement		
	end

	if mapArray[xVal+1][yVal].passable == true then
		rightArrow = display.newImage( iconSheet, 1) 

		rightArrow.x = mapArray[xVal+1][yVal].x
		rightArrow.y = mapArray[xVal+1][yVal].y
		rightArrow.xVal, rightArrow.yVal = xVal+1, yVal

		rightArrow:rotate( 90 )

		rightArrow:toFront()

		rightArrow:scale( tileScale, tileScale )
		self.rightArrow = rightArrow

		--TODO: Create tap event here for movement		
	end

	--local params = {x=rightArrow.x,y=leftArrow.y}

end

return Map
