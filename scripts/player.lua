
--[[ Player variables ------------------
hpCur - is the player's current HP.
hpMax - used to make sure that HP restore items do not over fill player's hp.
attack - amount of damage the player does per attack.
keys={} - used to store generic keys
rgbKeys - each one is used to store the amount of special keys in the game.
xPos and yPos - hopefully be used store map postion.
map={} - The map should be the parent of the player, so I want to store it to reference it.
]]--------------------------------------

local loadtable = require('scripts.saveGame')

Player = {tag="player", hpCur=60, hpMax=60, attack=15, keys=0, rKey=0, gKey=0, bKey=0, xPos=1, yPos=1, map={}, tileSheet={}, arrows={}}

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
	t = self:load()
	o = t or o or {}
	setmetatable(o, self);
	self.__index = self;
	o:save()
	return o;
end

function Player:spawn()
	self:load()
	self.body = display.newSprite(spriteSheet, spriteSeqData);
	self.body:setSequence("warrior")
	self.body:play()
	self.body.pp = self;
	self.body.tag = "player";
	if self.map.mapArray[self.xPos][self.yPos] ~= nil then
		self.body.x = self.map.mapArray[self.xPos][self.yPos].x
		self.body.y = self.map.mapArray[self.xPos][self.yPos].y
	end
	self.hpCur = hpCur;

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

function Player:haveKey(doorColor)
	-- return false if player has no keys
	if self.keys == 0 then return false; 
	end

	-- verify if player has key that matches door color
	if doorColor == "red" and self.rKey > 0 then
		return true;
	elseif doorColor == "green" and self.gKey > 0 then
		return true;
	elseif doorColor == "blue" and self.bKey > 0 then
		return true;
	end

	-- player does not have key to locked door
	return false;  
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

		-- update position in objectArray if player moved to another tile
		if self.xPos ~= previousX or self.yPos ~= previousY then
			self.map.objectArray[xPos][yPos] = self;
			self.map.objectArray[previousX][previousY] = nil;
		end

		self.map:enemyTurn()
	end

	return previousX, previousY
end

function Player:save()
	-- make new table with player stats I want to save.
	-- call save game function with new table.
	local t = {
		["attack"] = self.attack,
		["hpCur"] = self.hpCur,
		["hpMax"] = self.hpMax,
		["keys"] = self.keys,
		["rKey"] = self.rKey,
		["gKey"] = self.gKey,
		["bKey"] = self.bKey,
		["xPos"] = self.xPos,
		["yPos"] = self.yPos
	}
	loadtable.saveTable(t, "rogue_save.json")
end

function Player:load()
	-- call load game function and save output to new var table.
	-- update current player object with values loaded in loadGame variable.
	t = loadtable.loadTable("rogue_save.json")
	if t == nil then
		return nil
	end
	self.attack = t.attack
	self.hpCur = t.hpCur
	self.hpMax = t.hpMax
	self.keys = t.keys
	self.rKey = t.rKey
	self.gKey = t.gKey
	self.bKey = t.bKey
	self.xPos = t.xPos
	self.yPos = t.yPos
end

function Player:destroy()
	self.body:removeSelf()

	self.attack = nil
	self.hpCur = nil
	self.hpMax = nil
	self.keys = nil
	self.rKey = nil
	self.gKey = nil
	self.bKey = nil
	self.xPos = nil
	self.yPos = nil
end

function Player:delete()
	loadtable.delete("rogue_save.json")
end

return Player;