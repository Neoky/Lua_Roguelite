local ItemsTable = require("scripts.items");

--Array used to keep track of created image sheets, use the text strings when passing into functions
--  in order to get the correct image sheet
local sheetList = 
{
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
};


----- Base Class declaration -----

local ItemClass = {tag="item", power=0, passable=true, pushable=false};


function ItemClass:new (o) --constructor
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
function ItemClass:init(typeArg, fNumArg, mapArray, objArray, mapX, mapY, tileScale)
	self.tag = typeArg;
	self.frameNum = fNumArg;
	self.mapArray = mapArray;
	self.objectArray = objArray;
	self.mapX = mapX;
	self.mapY = mapY;
	self.tileScale = tileScale;

	if self.tag == "potion" then self.power = 10;
	elseif self.tag == "armor" then self.power = 10;
	elseif self.tag == "weapon" then self.power = 10;
	elseif self.tag == "trap" then self.power = 10;
	elseif self.tag == "decor" then self.pushable = true;
	end
end

------------------------
--Function:    spawn
--Description: 
--  
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
end

------------------------
--Function:    move
--Description: 
--  
--
--Arguments:
--
--Returns:
--  
------------------------
function ItemClass:move(pX, pY)
	currX, currY = self.mapX, self.mapY;
	newX, newY = currX, currY;

	if self.pushable == false then
		print("Item is not pushable!");
		return false;
	end

	if pX == (currX-1) then
		newX = newX + 1;
	elseif pX == (currX+1) then
		newX = newX - 1;
	elseif pY == (currY-1) then
		newY = newY + 1;
	elseif pY == (currY+1) then
		newY = newY - 1;
	else 
		print("INVALID move");
		return false;
	end

	-- verify new location is empty
	if self.objectArray[newX][newY] then 
		print("Item cannot be moved to new location");
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
--  
--
--Arguments:
--
--Returns:
--  
------------------------
function ItemClass:remove()
	print("[ItemClass:remove] entered for " .. self.tag);

	if self.tag == "trap" then
		return;  -- do not remove traps until player leaves room
	end

	if self.shape ~= nil then
		-- remove image from tile
		self.shape:removeSelf();
		self.shape = nil;	
	end
	-- remove object from array
	self.objectArray[self.mapX][self.mapY] = nil;
end




----- end Base Class declaration -----





return ItemClass;