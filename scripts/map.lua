---------------
--File: Map.lua
--
--Description:
--  This file holds all of the map generation functionality that can be 
--  used when creating the levels in the game
---------------
local Player = require("scripts.player");
local Arrows = require("scripts.arrows");
local ItemsTable = require("scripts.items");

local ItemClass = require("scripts.itemClass");
local DemonClass = require("scripts.enemies.demon");
local UndeadClass = require("scripts.enemies.undead");
local PestClass = require("scripts.enemies.pest");

--local File = require('scripts.saveGame')

local Map = {player={}, arrows={}, upArrow={},rightArrow={},downArrow={},leftArrow={},mapArray={}, objectArray={}}

--local player;

local xx = display.contentWidth
local yy = display.contentHeight

--16:9 aspect ratio is the default screen size
local roomWidth = 80/5 - 3 --Width = 13//Subtract 3 for Info screen on right side
local roomHeight = 45/5 --Height = 9

local sizeX = ( display.actualContentWidth  / roomWidth)
local sizeY = ( display.actualContentHeight / roomHeight)

--Set up Information View
local hpText = nil
local atkText = nil
local keysText = nil
local rKeyText = nil
local gKeyText = nil
local bKeyText = nil


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

local grayWallSheet = graphics.newImageSheet( "images/Objects/Wall.png", wOptions )

--[[
--Set up movement arrows (and other icons)
local iOptions =
{
	frames = {
		{ x = 16,  y =  0,  width = 16, height = 16}, -- Arrow
	}
};

local iconSheet = graphics.newImageSheet( "images/Commissions/Icons.png", iOptions )
]]--


--Array used to keep track of created image sheets, use the text strings when passing into functions
--  in order to get the correct image sheet
local sheetList = 
{
		["tile"]   = tileSheet,
		["grayWall"]   = grayWallSheet, 
		["door"]   = ItemsTable.door.sheet,
		["decor"]  = ItemsTable.decor.sheet,
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

local upArrow    = nil
local downArrow  = nil
local leftArrow  = nil
local rightArrow = nil

local defaultWalls = nil
local defaultTile = nil

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
--[[function Map:makeRoom(topDoor, leftDoor, rightDoor, bottomDoor)
	
	mapArray = {}
	local doorSheet = sheetList["door"];
	local wallSheet = sheetList["grayWall"]

	for i=1, roomWidth do

		mapArray[i] = {}

	    for j=1, roomHeight do
	        --Top row
	        if j == 1 then
	        	--Top Left Corner
	        	if i == 1 then 
	        		tile = display.newImage (wallSheet, 1)
	        	--Top Right Corner
	        	elseif i == roomWidth then
	        		tile = display.newImage (wallSheet, 3)
	       		else
		        	--Check for door
		        	if(topDoor == true) and (i == math.ceil(roomWidth/2)) then
		        		tile = display.newImage (doorSheet, doorFrame)
		        		tile.passable = true 
		        	else
		        		tile = display.newImage (wallSheet, 2)
		        	end	       			
	       		end

	        --Left side
	        elseif i == 1 then
	        	--Bottom left corner
	        	if j == roomHeight then
	        		tile = display.newImage (wallSheet, 5)
	        	else
		        	--Check for door
		        	if(leftDoor == true) and (j == math.ceil(roomHeight/2)) then
		        		tile = display.newImage (doorSheet, doorFrame)
		        		tile.passable = true 
		        	else
		        		tile = display.newImage (wallSheet, 4)
		        	end 
		        end

	       --Right side
	        elseif i == roomWidth  then
	        	--Bottom right corner
	        	if j == roomHeight then
	        		tile = display.newImage (wallSheet, 6)
	        	else
		        	--Check for door
		        	if(rightDoor == true) and (j == math.ceil(roomHeight/2)) then
		        		tile = display.newImage (doorSheet, doorFrame)
		        		tile.passable = true 
		        	else
		        		tile = display.newImage (wallSheet, 4)
		        	end
	       		end

	       	--Bottom Row
	        elseif j == roomHeight then
		        --Check for door
		        if(bottomDoor == true) and (i == math.ceil(roomWidth/2)) then
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

	        -- Change all the above wall tiles to non-passable
	        if tile.passable == nil then
	        	tile.passable = true
	        end

	        tile:scale (tileScale, tileScale)

	        tile.x = tileSize/2 + tileSize*i - tileSize
			tile.y = tileSize/2 + tileSize*j - tileSize

			mapArray[i][j] = tile
	    end
	end

	self.mapArray = mapArray
	
	--Create empty objectArray
	objectArray = {}
	for i=1, roomWidth do
		objectArray[i] = {}
	    for j=1, roomHeight do
	    	objectArray[i][j] = nil
	    end
	end

	self.objectArray = objectArray

	return mapArray
end]]

function Map:makeRoom(tileNum, walls)
	
	mapArray = {}

	self.defaultTile = tileNum
	self.defaultWalls = sheetList[walls] 
	wallSheet = sheetList[walls]

	for i=1, roomWidth do

		mapArray[i] = {}

	    for j=1, roomHeight do
	        --Top row
	        if j == 1 then
	        	--Top Left Corner
	        	if i == 1 then 
	        		tile = display.newImage (wallSheet, 1)
	        	--Top Right Corner
	        	elseif i == roomWidth then
	        		tile = display.newImage (wallSheet, 3)
	       		else
		        	tile = display.newImage (wallSheet, 2)
	       		end

	        --Left side
	        elseif i == 1 then
	        	--Bottom left corner
	        	if j == roomHeight then
	        		tile = display.newImage (wallSheet, 5)
	        	else
		        	tile = display.newImage (wallSheet, 4)
		        end

	       --Right side
	        elseif i == roomWidth  then
	        	--Bottom right corner
	        	if j == roomHeight then
	        		tile = display.newImage (wallSheet, 6)
	        	else
		        	tile = display.newImage (wallSheet, 4)
	       		end

	       	--Bottom Row
	        elseif j == roomHeight then

		        tile = display.newImage (wallSheet, 2)

	       	--Normal tiles
	        else
	        	tile = display.newImage (tileSheet, tileNum)
	        	tile.passable = true  
	        end

	        -- Change all the above wall tiles to non-passable
	        if tile.passable == nil then
	        	tile.passable = false
	        end

	        tile:scale (tileScale, tileScale)

	        tile.x = tileSize/2 + tileSize*i - tileSize
			tile.y = tileSize/2 + tileSize*j - tileSize

			mapArray[i][j] = tile
	    end
	end

	self.mapArray = mapArray
	
	--Create empty objectArray
	objectArray = {}
	for i=1, roomWidth do
		objectArray[i] = {}
	    for j=1, roomHeight do
	    	objectArray[i][j] = nil
	    end
	end

	self.objectArray = objectArray

	return mapArray
end



function Map:getObjectArray()
	return self.objectArray
end

------------------------
--Function:    swapTile
--Description: 
--  Swaps out a floor tile with a different floor tile
--
--Arguments:
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

	mapArray[xVal][yVal]:removeSelf()
	mapArray[xVal][yVal] = nil
	mapArray[xVal][yVal] = newTile
	mapArray[xVal][yVal]:scale(tileScale, tileScale)

	return mapArray[xVal][yVal]
end


------------------------
--Function:    placeObject
--Description: 
--  Places an object on top of a tile on the map
--
--Arguments:
--  objectType - object type - Specifies what the object is that is being added
--  tileSheet  - String      - String used to specify tilesheet to use
--  frameNum   - integer     - Specifies frame to pull from tilesheet
--  xVal       - integer     - x value for tile
--  yVal       - integer     - y value for tile
--  passable   - boolean     - specifies if the tile is passable
--  pushable   - boolean     - specifies if the tile is pushable
--
--Returns:
--  The object that has been placed
------------------------
function Map:placeObject(objectType, tileSheet, frameNum, xVal, yVal, passable, pushable)
	
	local newObject = nil;

	if(objectType == "enemy") then

		-- check for enemy objects
		if ( tileSheet == "pest" ) then 
			newObject = PestClass:new();
			newObject:init( frameNum, "RANDOM" );  -- initialize enemy attributes 
		elseif ( tileSheet == "undead" ) then
			newObject = UndeadClass:new();
			newObject:init( frameNum, "RANDOM" );  -- initialize enemy attributes 
		elseif ( tileSheet == "demon" ) then
			newObject = DemonClass:new();
			newObject:init( frameNum, "STAND" );  -- initialize enemy attributes 
		end
		
		if ( newObject ~= nil ) then
			-- create image of enemy on tile
			newObject:spawn( mapArray, xVal, yVal, tileScale );
			
			--- TEST JB : add touch listener to test enemy movement
			local function touchListener(event)
				if (event.phase == "began") then
					newObject:move();
				end
			end
			newObject.shape:addEventListener("touch", touchListener);
			---
		end

	elseif(objectType == "item") then

		-- create item class object
		newObject = ItemClass:new();
		newObject:spawn(tileSheet, frameNum, mapArray, xVal, yVal, tileScale);

		return newObject;

	elseif(objectType == "door") then
		--Need to remove wall tile and replace it with a tile to put the door on.
		Map:swapTile( tileSheet, self.defaultTile, xVal, yVal, true)

		newObject = display.newImage( sheetList[tileSheet], frameNum) 
		newObject.x = mapArray[xVal][yVal].x
		newObject.y = mapArray[xVal][yVal].y

		newObject.passable = passable
		newObject.pushable = pushable

		newObject:scale(tileScale,tileScale)

		newObject:toFront( )

		-- set object tag to tile
		newObject.tag = tileSheet;

	elseif(objectType == "object") then
		--TODO:Create Object class object here instead of this
		-- This is currently a catch-all for all objects we haven't classified yet (Pushable stuff, spike pits, immovable scenery, etc.)

		newObject = display.newImage( sheetList[tileSheet], frameNum) 
		newObject.x = mapArray[xVal][yVal].x
		newObject.y = mapArray[xVal][yVal].y

		newObject.passable = passable
		newObject.pushable = pushable

		newObject:scale(tileScale,tileScale)

		newObject:toFront( )

		-- set object tag to tile
		newObject.tag = tileSheet;

	else
		print("Could not find matching type for object at " .. xVal .. "," .. yVal)
	end
	
	--TODO: Should probably throw some exception here if this returns nil
	return newObject
end

------------------------
--Function:    buildMap
--Description: 
--  Builds a map over the default map based on a user-specified list
--
--Arguments:
--  creatorList - info Array - Array listing tiles to replace in the map
--
--Returns:
--  The array of map tiles for the level
------------------------
function Map:buildMap(creatorList)

	for i = 1, #creatorList do 
		x = creatorList[i][3]
		y = creatorList[i][4]

		self.mapArray[x][y] = Map:swapTile(  
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
--  objectList  - info Array - Array listing objects to place in the map
--
--Returns:
--  The array of map tiles for the level
------------------------
function Map:fillMap(objectList)

	for i = 1, #objectList do 
		x = objectList[i][4]
		y = objectList[i][5]

		self.objectArray[x][y] = Map:placeObject(
			objectList[i][1],  
			objectList[i][2],
			objectList[i][3],
			objectList[i][4],
			objectList[i][5])
	end

	return objectArray
	
end

function Map:generateMap(defaultTile, defaultWall, creatorList, objectList)

	Map:makeRoom(defaultTile, defaultWall)
	Map:buildMap(creatorList)
	Map:fillMap(objectList)

	return self.mapArray
end

------------------------
--Function:    updateInfoScreen
--Description: 
--  Updates the information that shows important player status
------------------------
function Map:updateInfoScreen()

	if(hpText == nil) then 	
		hpText = display.newText ( 
		{
			text="HP: ", 
			x = xx-125, 
			y = 100, 
			fontSize = 30
		});
	end

	if(atkText == nil) then 	
		atkText = display.newText ( 
		{
			text="Atk: ", 
			x = xx - 185, 
			y = hpText.y + 50, 
			fontSize = 30
		});
	end

	if(keysText == nil) then 	
		keysText = display.newText ( 
		{
			text="Keys Collected ", 
			x = xx - 120, 
			y = atkText.y + 70, 
			fontSize = 30
		});
	end

	if(rKeyText == nil) then 	
		rKeyText = display.newText ( 
		{
			text="Red: ", 
			x = keysText.x + 40, 
			y = keysText.y + 60, 
			fontSize = 30
		});

		rKeyText.anchorX = 1
		rKeyText.anchorY = 1
	end

	if(gKeyText == nil) then 	
		gKeyText = display.newText ( 
		{
			text="Green: ", 
			x = rKeyText.x, 
			y = rKeyText.y + 35, 
			fontSize = 30
		});

		gKeyText.anchorX = 1
		gKeyText.anchorY = 1
	end

	if(bKeyText == nil) then 	
		bKeyText = display.newText ( 
		{
			text="Blue: ", 
			x = gKeyText.x, 
			y = gKeyText.y + 35, 
			fontSize = 30
		});

		bKeyText.anchorX = 1
		bKeyText.anchorY = 1
	end

	--This is acutal update part
	hpText.text = "HP: " .. self.player.hpCur .. " / " .. self.player.hpMax
	atkText.text = "ATK: " .. self.player.attack

	rKeyText.text = "Red: " .. self.player.rKey
	gKeyText.text = "Green: " .. self.player.gKey
	bKeyText.text = "Blue: " .. self.player.bKey
	
	--File.saveTable(self, "myTable.json", system.DocumentsDirectory)
end

------------------------
--Function:    placePlayer
--Description: 
--  Places a player character on the map
--
--Arguments:
--  tileSheet - String     - String used to specify tilesheet to use
--  frameNum  - integer    - Specifies frame to pull from tilesheet
--  xVal      - integer    - x value to place character at
--  yVal      - integer    - y value to place character at
--
--Returns:
--  The object representing the character
------------------------
function Map:placePlayer(tileSheet, frameNum, xVal, yVal)
	--TODO: Need to pass player data to this function when placing between scene transitions
	self.player = Player:new({hpCur=100, hpMax=100, attack=2, keys=0, rKey=0, gKey=0, bKey=0, xPos=xVal, yPos=yVal, map=self, tileSheet=tileSheet})
	self.player:spawn()
	self.player:move(xVal, yVal)
	self.player.body:scale(tileScale,tileScale)
	self.player.body:toFront()

	--player = self.player;
	--self:setArrows(xVal, yVal)

	print(self.arrows)
	local arrows = Arrows:new({player=self.player, map=self})
	print(self.arrows)
	arrows:setArrows(xVal, yVal)

	objectArray[xVal][yVal] = self.player

	self:updateInfoScreen()

	return self.player;
end

function Map:enemyTurn()
	-- Logic and function calls for enemy movement goes here.
end

return Map
