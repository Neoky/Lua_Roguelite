
--[[ Player variables ------------------
hpCur - is the player's current HP.
hpMax - used to make sure that HP restore items do not over fill player's hp.
attack - amount of damage the player does per attack.
keys={} - used to store generic keys
rgbKeys - each one is used to store the amount of special keys in the game.
xPos and yPos - hopefully be used store map postion.
map={} - The map should be the parent of the player, so I want to store it to reference it.
]]--------------------------------------

Player = {tag="player", hpCur=100, hpMax=100, attack=2, keys=0, rKey=0, gKey=0, bKey=0, xPos=1, yPos=1, map={}, tileSheet={}}

local spriteOpt =
{
	frames = {
		{ x = 16, y = 48, width = 16, height = 16}, --1 warrior1
		{ x = 144, y = 48, width = 16, height = 16}, --2 warrior2
	}
};
local spriteSheet = graphics.newImageSheet( "images/Characters/PlayerCombined.png", spriteOpt );

-- Create animation sequence for animation
local spriteSeqData = {
	{name = "warrior", frames={1,2}, time=1000},
}

function Player:new(o)
	setmetatable(o, self);
	self.__index = self;
	return o;
end

function Player:spawn()
	self.body = display.newSprite(spriteSheet, spriteSeqData);
	self.body:setSequence("warrior")
	self.body.pp = self;
	self.body.tag = "player";
	self.body.x = xPos;
	self.body.y = yPos;
	self.hpCur = hpCur;
	--self.map = map;
	--physics.addBody( self.body, "kinematic" );
	return self.body
end

function Player:reduceHP(d)
	if d > self.hpCur then
		self.hpCur = 0
		return 0
	else
		self.hpCur = self.hpCur - d
		return self.hpCur
	end
end

function Player:restoreHP(d)
	if self.hpCur + d > self.hpMax then
		self.hpCur = self.hpMax
		return self.hpMax
	else
		self.hpCur = self.hpCur + d
		return self.hpCur
	end
end

function Player:move(xPos, yPos)
	if self.map.mapArray then
		--Save this to update the current map's objectArray
		previousX = self.xPos
		previousY = self.yPos

		-- Move Player object
		self.xPos, self.yPos = xPos, yPos
		self.body.x = self.map.mapArray[xPos][yPos].x
		self.body.y = self.map.mapArray[xPos][yPos].y
		-- Create shortcuts
		xVal, yVal = self.xPos, self.yPos;
		mapArray = self.map.mapArray

		--self.map:setArrows(xPos,yPos)
		-- Move Arrows
		upArrow = self.map.upArrow
		leftArrow = self.map.leftArrow
		rightArrow = self.map.rightArrow
		downArrow = self.map.downArrow
		if mapArray[xVal][yVal-1] ~= nil and mapArray[xVal][yVal-1].passable == true then
			upArrow.x = mapArray[xVal][yVal-1].x
			upArrow.y = mapArray[xVal][yVal-1].y
			upArrow.xVal, upArrow.yVal = xVal, yVal-1
			upArrow.isVisible=true;
		else
			upArrow.isVisible=false;
		end

		if mapArray[xVal][yVal+1] ~= nil and mapArray[xVal][yVal+1].passable == true then
			downArrow.x = mapArray[xVal][yVal+1].x
			downArrow.y = mapArray[xVal][yVal+1].y
			downArrow.xVal, downArrow.yVal = xVal, yVal+1
			downArrow.isVisible=true;
		else
			downArrow.isVisible=false;
		end

		if mapArray[xVal-1][yVal] ~= nil and mapArray[xVal-1][yVal].passable == true then
			leftArrow.x = mapArray[xVal-1][yVal].x
			leftArrow.y = mapArray[xVal-1][yVal].y
			leftArrow.xVal, leftArrow.yVal = xVal-1, yVal
			leftArrow.isVisible=true;
		else
			leftArrow.isVisible=false;
		end

		if mapArray[xVal+1][yVal] ~= nil and mapArray[xVal+1][yVal].passable == true then
			rightArrow.x = mapArray[xVal+1][yVal].x
			rightArrow.y = mapArray[xVal+1][yVal].y
			rightArrow.xVal, rightArrow.yVal = xVal+1, yVal	
			rightArrow.isVisible=true;
		else
			rightArrow.isVisible=false;
		end

		if mapArray[xVal][yVal].pushable == true then
			-- Pushable object logic
		end

		self.map:enemyTurn()
	end

	return previousX, previousY
end

return Player;