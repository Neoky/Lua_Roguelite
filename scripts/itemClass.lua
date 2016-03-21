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


----- Bass Class declaration -----

local ItemClass = {tag="item", passable=true, pushable=false};


function ItemClass:new (o) --constructor
	o = o or {};
	setmetatable(o, self);
	self.__index = self;
	return o;
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
function ItemClass:spawn(typeArg, fNumArg, mapArray, mapX, mapY, tileScale)
	self.type = typeArg;
	self.sheet = sheetList[typeArg];

	self.mapArray = mapArray;
	self.mapX = mapX;
	self.mapY = mapY;
	
	-- create enemy image on given tile location 
	self.shape = display.newImage( self.sheet, fNumArg );
	self.shape.x = mapArray[mapX][mapY].x;
	self.shape.y = mapArray[mapX][mapY].y;
	self.shape:scale(tileScale,tileScale);
	self.shape:toFront( );

	-- initialize properties based on item type
	self:setItemProperties();

	-- set object x,y coordinates for tile placement
	--self.x = mapArray[mapX][mapY].x;
	--self.y = mapArray[mapX][mapY].y;
end

------------------------
--Function:    
--Description: 
--  
--
--Arguments:
--
--Returns:
--  
------------------------
function ItemClass:setItemProperties()
	self.HP = 0;
	self.ATK = 0;
	self.key = "";

	if self.type == "potion" then self.health = 10;
	elseif self.type == "armor" then self.HP = 10;
	elseif self.type == "weapon" then self.ATK = 10;
	end
end

------------------------
--Function:    
--Description: 
--  
--
--Arguments:
--
--Returns:
--  
------------------------
function ItemClass:pickUp()
	return {self.type, self.health, self.HP, self.ATK};
end

------------------------
--Function:    
--Description: 
--  
--
--Arguments:
--
--Returns:
--  
------------------------
function ItemClass:remove(damage)
	print("[ItemClass:remove] entered for " .. self.type);

	if self.shape ~= nil then
		-- remove image
		self.shape:removeSelf();
		self.shape = nil;	

		-- clear item attributes from tile
		self.tag = "";
		self.passable = true;
	end
end




----- end Bass Class declaration -----




return ItemClass;