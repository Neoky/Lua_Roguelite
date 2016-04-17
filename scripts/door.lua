local ItemsTable = require("scripts.items");

--Array used to keep track of created image sheets, use the text strings when passing into functions
--  in order to get the correct image sheet
local sheetList = 
{
	["door"]   = ItemsTable.door.sheet,
};


local Door = {tag="door", toScene = nil, toX = nil, toY = nil, passable=true, locked = false, color = nil, tileScale = 1};

function Door:new (o) --constructor
	o = o or {};
	setmetatable(o, self);
	self.__index = self;
	return o;
end


function Door:spawn(frameNum, mapX, mapY, mapArray, toScene, toX, toY, color, tileScale)
	self.tag = "door"

	self.mapArray = mapArray
	self.mapX = mapX
	self.mapY = mapY

	self.frame = frameNum
	self.toScene = toScene
	self.toX = toX
	self.toY = toY

	self.color = color

	self.tileScale = tileScale


	-- create image on given tile location 
	self.shape = display.newImage( sheetList["door"], frameNum )
	self.shape.x = mapArray[mapX][mapY].x
	self.shape.y = mapArray[mapX][mapY].y
	self.shape:scale(tileScale,tileScale)
	self.shape:toFront( )

	-- initialize properties based on item type
	if(self.color ~= nil) then
		self:addLock(color)
	end

end


function Door:addLock(color)

	self.locked = true
	self.passable = false

	self.lock = display.newImage( sheetList["door"], 6 )
	self.lock.x = self.shape.x
	self.lock.y = self.shape.y

	self.lock:scale(self.tileScale, self.tileScale)

	if(color == "green") then
		self.lock:setFillColor( 0, 1, 0)
	elseif(color == "red") then
		self.lock:setFillColor( 1, 0, 0)
	elseif(color == "blue") then
		self.lock:setFillColor( 0, 0, 1)
	end


	self.lock:toFront()
end


function Door:removeLock()
	self.locked = false
	self.passable = true

	self.lock:removeSelf()
end



return Door