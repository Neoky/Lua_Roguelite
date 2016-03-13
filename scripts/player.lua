
--[[ Player variables ------------------
hpCur - is the player's current HP.
hpMax - used to make sure that HP restore items do not over fill player's hp.
attack - amount of damage the player does per attack.
keys={} - used to store generic keys
rgbKeys - each one is used to store the amount of special keys in the game.
xPos and yPos - hopefully be used store map postion.
map={} - The map should be the parent of the player, so I want to store it to reference it.
]]--------------------------------------

Player = {hpCur=100, hpMax=100, attack=2, keys=0, rKey=0, gKey=0, bKey=0, xPos=0, yPos=0, map={}, tileSheet={}}

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

function Player:move(x,y)
	self.body.x = x
	self.body.y = y
end

return Player;