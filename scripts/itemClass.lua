local ItemsTable = require("scripts.items");


--Array used to keep track of created image sheets, use the text strings when passing into functions
--  in order to get the correct image sheet
local sheetList = 
{
	["door"]    = ItemsTable.door.sheet,
	["decor"]   = ItemsTable.decor.sheet,
	["trap"]    = ItemsTable.trap.sheet,
	["armor"]   = ItemsTable.armor.sheet,
	["boot"]    = ItemsTable.boot.sheet,
	["chest"]   = ItemsTable.chest.sheet,
	["hat"]     = ItemsTable.hat.sheet,
	["key"]     = ItemsTable.key.sheet,
	["potion"]  = ItemsTable.potion.sheet,
	["shield"]  = ItemsTable.shield.sheet,
	["weapon"]  = ItemsTable.weapon.sheet,
};

-- Room boundaries
local MIN_X_POS = 1;
local MAX_X_POS = 13;
local MIN_Y_POS = 1;
local MAX_Y_POS = 9;


----- Base Class declaration -----

local ItemClass = {tag="item", power=0, passable=false, pushable=false, color="", xOrigin = nil, yOrigin = nil};


function ItemClass:new (o) --constructor
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
function ItemClass:init(typeArg, fNumArg, powerArg, mapArray, objArray, mapX, mapY, tileScale)
	self.tag = typeArg;
	self.frameNum = fNumArg;
	self.power = powerArg;
	self.mapArray = mapArray;
	self.objectArray = objArray;
	self.mapX = mapX;
	self.mapY = mapY;
	self.tileScale = tileScale;

	self.xOrigin = mapX;
	self.yOrigin = mapY;

	-- Populate attributes based on item type
	if self.tag == "potion" then self.power = 10;
	elseif self.tag == "armor" then self.power = 10;
	elseif self.tag == "weapon" then self.power = 10;
	elseif self.tag == "trap" then self.power = 10;
	elseif self.tag == "chestArmor" then
		-- assign chest contents and rename tag to generic 'chest'
		self.contents = "armor";
		self.tag = "chest";
	elseif self.tag == "chestWeapon" then
		-- assign chest contents and rename tag to generic 'chest'
		self.contents = "weapon";
		self.tag = "chest";
	elseif self.tag == "rkey" then
		-- assign key color and rename tag to generic 'key'
		self.color = "red";
		self.tag = "key";
	elseif self.tag == "gkey" then
		-- assign key color and rename tag to generic 'key'
		self.color = "green";
		self.tag = "key";
	elseif self.tag == "bkey" then
		-- assign key color and rename tag to generic 'key'
		self.color = "blue";
		self.tag = "key";
	end
end

------------------------
--Function:    spawn
--Description: 
--  Displays image of the item on the tile.
--
--Arguments:
--
--Returns:
--  
------------------------
function ItemClass:spawn()
	-- create item image on given tile location 
	self.shape = display.newImage( sheetList[self.tag], self.frameNum );
	self.shape.x = self.mapArray[self.mapX][self.mapY].x;
	self.shape.y = self.mapArray[self.mapX][self.mapY].y;
	self.shape:scale(self.tileScale,self.tileScale);
	self.shape:toFront( );

	-- for keys set the color to match the lock
	if self.tag == "key" then
		if self.color == "red" then self.shape:setFillColor(1,0,0,0.8);
		elseif self.color == "green" then self.shape:setFillColor(0,1,0,0.8);
		elseif self.color == "blue" then self.shape:setFillColor(0,0,1,0.8); 
		end
	elseif self.tag == "chest" and not self.contents then
		-- for an empty container (barrel), change the tag so the player 
		-- will not perform a chest interaction on the item
		self.tag = "barrel";
	end
end

------------------------
--Function:    move
--Description: 
--  Moves a pushable item based on direction of push from player.
--
--Arguments:
--  Player coordinates
--Returns:
--  true if the item was moved; false otherwise
------------------------
function ItemClass:move(pX, pY)
	currX, currY = self.mapX, self.mapY;
	newX, newY = currX, currY;

	-- verify item is pushable
	if self.pushable == false then
		print("Error: Item is not pushable!");
		return false;
	end

	-- determine direction of push based on player's location 
	if pX == (currX-1) then
		newX = newX + 1;  -- right
	elseif pX == (currX+1) then
		newX = newX - 1;  -- left
	elseif pY == (currY-1) then
		newY = newY + 1;  -- up
	elseif pY == (currY+1) then
		newY = newY - 1;  -- down
	else 
		print("Error: Invalid move for item");
		return false;
	end

	-- verify new location is within room boundaries
	if newX <= MIN_X_POS or newX >= MAX_X_POS then
		print("Error: cannot move item outside of room");
		return false;
	elseif newY <= MIN_Y_POS or newY >= MAX_Y_POS then
		print("Error: cannot move item outside of room");
		return false;
	end

	-- verify new location is empty
	if self.objectArray[newX][newY] then 
		print("Error: An object is in the item's way");
		return false;
	end

	-- move image
	self.mapX, self.mapY = newX, newY;
	self.shape.x = self.mapArray[self.mapX][self.mapY].x;
	self.shape.y = self.mapArray[self.mapX][self.mapY].y;

	-- move item in objectArray
	self.objectArray[newX][newY] = objectArray[currX][currY];
	self.objectArray[currX][currY] = nil;	

	return true;
end

------------------------
--Function:    remove
--Description: 
--  Removes the image of the item and removes item object from object 
--  array.
--
--Arguments:
--
--Returns:
--  
------------------------
function ItemClass:remove()
	--print("[ItemClass:remove] entered for " .. self.tag);
	if self.shape ~= nil then
		-- remove image from tile
		local sfx = audio.loadStream( "audio/pickup.wav" )
		audio.play( sfx, { channel=2, loops=0, fadein=0 } )
		self.shape:removeSelf();
		self.shape = nil;	
	end
	-- remove object from array
	self.objectArray[self.mapX][self.mapY] = nil;
end

------------------------
--Function:    openChest
--Description: 
--  Script to display the contents of the chest before removing the chest.
--
--Arguments:
--  
--Returns:
--  returns true if successfully opened chest and showed
--  contents; false otherwise
------------------------
function ItemClass:openChest()
	if self.tag ~= "chest" then
		print("Error: item is not a chest");
		return false;
	elseif not self.contents then
		print("Error: chest is empty");
		return false;
	end

	local chestItem;
	if self.contents == "armor" then
		chestItem = display.newImage( sheetList["armor"], 4 );
	elseif self.contents == "weapon" then
		chestItem = display.newImage( sheetList["weapon"], 2 );
	else
		print("Error: chest contains unknown contents");
		self.remove();  -- remove the chest
		return;
	end

	chestItem.x = mapArray[self.mapX][self.mapY].x;
	chestItem.y = mapArray[self.mapX][self.mapY].y-15;
	chestItem:scale(self.tileScale-1, self.tileScale-1);
	
	-- display contents and then remove contents and the chest
	local removeItem = function() chestItem:removeSelf(); self:remove(); end
	transition.to(chestItem, {y=chestItem.y-5, time=3000, onComplete=removeItem});

	return true;
end




----- end Base Class declaration -----





return ItemClass;