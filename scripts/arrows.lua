local ItemsTable = require("scripts.items");

--Set up movement arrows (and other icons)

local iOptions =
{
	frames = {
		{ x = 16,  y =  0,  width = 16, height = 16}, -- Arrow
	}
};
local iconSheet = graphics.newImageSheet( "images/Commissions/Icons.png", iOptions );

local tileScale = 5
local tileSize  = 16 * tileScale


Arrows = {upArrow={}, downArrow={}, leftArrow={}, rightArrow={}, player={}, map={}, lostObj=nil};
local upArrow, downArrow, leftArrow, rightArrow;

function Arrows:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	function battleAnimation(e)
		-- script to play a sword swing at enemies
		e.target.alpha=0
		local sword = display.newImage( ItemsTable.weaponLng.sheet, 2)  -- frame 2 is long sword
		sword.x = (o.player.body.x + e.target.x)/2
		sword.y = (o.player.body.y + e.target.y)/2
		sword.rotation = e.target.rotation-90
		sword:scale(tileScale,tileScale)
		local removeSword = function() e.target.alpha=0.50 return sword:removeSelf() end
		transition.to(sword, {rotation=e.target.rotation, time=500, onComplete=removeSword})
	end

	------------------------
	--Function:    interactionCheck
	--Description: 
	--  Detect if the spot the player is about to goto is going to collide with an object who's space it can't occupy.
	------------------------
	function interactionCheck(e,x,y)
		local mapArray = o.map.mapArray;
		local objectList = o.map.objectArray;
		local player = o.player

		if objectList[x][y] and objectList[x][y].tag == "enemy" then
			print("ENEMY DETECTED")
			local enemy = objectArray[x][y]
			enemy:hit(player.attack)
			battleAnimation(e)
			return true
		elseif objectList[x][y] and objectList[x][y].tag == "trap" then
			print("TRAP DETECTED")
			local trap = objectList[x][y]
			player.hpCur = player.hpCur - trap.power;
			self.lostObj = trap; -- save trap object before player steps onto it
		elseif objectList[x][y] and objectList[x][y].tag == "key" then
			local key = objectList[x][y]
			player.keys = player.keys + 1;
			if key.color == "red" then 
				print("RED KEY DETECTED");
				player.rKey = player.rKey + 1;
			elseif key.color == "green" then 
				print("GREEN KEY DETECTED");
				player.gKey = player.gKey + 1;
			elseif key.color == "blue" then 
				print("BLUE KEY DETECTED");
				player.bKey = player.bKey + 1;
			end
			key:remove();
		elseif objectList[x][y] and objectList[x][y].tag == "weapon" then
			print("WEAPON DETECTED")
			local weapon = objectList[x][y]
			player.attack = player.attack + weapon.power;
			weapon:remove();
		elseif objectList[x][y] and objectList[x][y].tag == "armor" then
			print("ARMOR DETECTED")
			local armor = objectList[x][y]
			player.hpMax = player.hpMax + armor.power;
			player:restoreHP(armor.power)
			armor:remove();
		elseif objectList[x][y] and objectList[x][y].tag == "potion" then
			print("POTION DETECTED")
			local potion = objectList[x][y]
			player:restoreHP(potion.power)
			potion:remove();
		elseif objectList[x][y] and objectList[x][y].pushable == true then
			print("PUSHABLE DETECTED")
			local pushable = objectList[x][y]
			itemMoved = pushable:move(player.xPos, player.yPos);
			if itemMoved == true then return false;
			else return true;
			end
		elseif objectList[x][y] and objectList[x][y].tag == "door" then
			print("DOOR DETECTED")
			local door = objectList[x][y]
			if door.locked == false then
				o.map:transition(x, y)
			elseif player:haveKey(door.color) == true then
				-- player has key to locked door
				print("DOOR UNLOCKED")
				o.map:transition(x, y)
			else
				-- player does not have correct key to locked door
				print("DOOR IS LOCKED")
			end
			return true;
		end
		return false
	end

	------------------------
	--Function:    movePlayer
	--Description: 
	--  Listener function that triggers when one of the movement arrows is tapped
	--  Moves the player, updates the objectArray, sets new Arrows, and updates the Info screen
	------------------------
	function movePlayer(event)
		if event.phase == "began" then
			local interaction = false
			interaction = interactionCheck(event, event.target.xVal,event.target.yVal)
			if interaction == false then
				oldX, oldY = o.player:move(event.target.xVal,event.target.yVal)
				
				if self.lostObj ~= nil and self.lostObj.mapX == oldX and self.lostObj.mapY == oldY then
					-- place deleted object back into array
					if objectArray[oldX][oldY] ~= nil and objectArray[oldX][oldY].tag == "enemy" and 
						self.lostObj.tag == "trap" then
						-- enemy fell into trap so remove enemy before adding trap back
						print("Enemy has fallen into trap!")
						local enemy = objectArray[oldX][oldY];
						enemy:remove();
					end
					objectArray[oldX][oldY] = self.lostObj
					self.lostObj = nil;
				end

				o:setArrows(event.target.xVal, event.target.yVal)

				--TODO:Call player functions to handle combat/picking up items

			else
				o.player:move(o.player.xPos, o.player.yPos)
			end
			o.map:updateInfoScreen()
		end
	end

	return o
end


------------------------
--Function:    setArrows
--Description: 
--  Places arrows around the player character. Will only place the arrow if the 
--  tile is something the player can pass through
--
--Arguments:
--  xVal      - integer    - x value for player
--  yVal      - integer    - y value for player
--
--Returns:
--  Nothing
------------------------
function Arrows:setArrows(xVal, yVal)
	print(xVal .. "," .. yVal)
	print(self.map.mapArray[xVal][yVal].passable, self.map.mapArray[xVal][yVal].pushable)

	if upArrow ~= nil then
		upArrow:removeSelf( )
		upArrow = nil
	end

	if downArrow ~= nil then
		downArrow:removeSelf( )
		downArrow = nil
	end

	if leftArrow ~= nil then
		leftArrow:removeSelf( )
		leftArrow = nil
	end

	if rightArrow ~= nil then
		rightArrow:removeSelf( )
		rightArrow = nil
	end

	mapArray = self.map.mapArray

	if (mapArray[xVal][yVal-1] ~= nil) and mapArray[xVal][yVal-1].passable == true then
		--Check if there is an object present, or if there is, make sure its passable
		--if objectArray[xVal][yVal-1] and objectArray[xVal][yVal-1].passable then
		upArrow = display.newImage( iconSheet, 1)
		upArrow.x = mapArray[xVal][yVal-1].x
		upArrow.y = mapArray[xVal][yVal-1].y
		upArrow.xVal, upArrow.yVal = xVal, yVal-1
		upArrow.alpha = 0.50

		upArrow:toFront()

		upArrow:scale( tileScale, tileScale )
		self.upArrow = upArrow

		upArrow:addEventListener("touch", movePlayer)
		--end
	end

	if (mapArray[xVal][yVal+1] ~= nil) and mapArray[xVal][yVal+1].passable == true then
		--if (objectArray[xVal][yVal+1] and objectArray[xVal][yVal+1].passable) then
		downArrow = display.newImage( iconSheet, 1)
		downArrow.x = mapArray[xVal][yVal+1].x
		downArrow.y = mapArray[xVal][yVal+1].y
		downArrow.xVal, downArrow.yVal = xVal, yVal+1
		downArrow.alpha = 0.50

		downArrow:rotate( 180 )

		downArrow:toFront()

		downArrow:scale( tileScale, tileScale )
		self.downArrow = downArrow

		downArrow:addEventListener("touch", movePlayer)
		--end
	end

	if (xVal > 1) and mapArray[xVal-1][yVal].passable == true then	
		--if (objectArray[xVal-1][yVal] and objectArray[xVal-1][yVal].passable) then
		leftArrow = display.newImage( iconSheet, 1)
		leftArrow.x = mapArray[xVal-1][yVal].x
		leftArrow.y = mapArray[xVal-1][yVal].y
		leftArrow.xVal, leftArrow.yVal = xVal-1, yVal
		leftArrow.alpha = 0.50

		leftArrow:rotate( -90 )

		leftArrow:toFront()

		leftArrow:scale( tileScale, tileScale )
		self.leftArrow = leftArrow

		leftArrow:addEventListener("touch", movePlayer)	
		--end		
	end

	if (xVal < table.getn(mapArray)) and mapArray[xVal+1][yVal].passable == true then
		--print(xVal, table.getn(mapArray))
		--if (objectArray[xVal+1][yVal] and objectArray[xVal+1][yVal].passable) then
		rightArrow = display.newImage( iconSheet, 1)
		rightArrow.x = mapArray[xVal+1][yVal].x
		rightArrow.y = mapArray[xVal+1][yVal].y
		rightArrow.xVal, rightArrow.yVal = xVal+1, yVal
		rightArrow.alpha = 0.50

		rightArrow:rotate( 90 )

		rightArrow:toFront()

		rightArrow:scale( tileScale, tileScale )
		self.rightArrow = rightArrow

		rightArrow:addEventListener("touch", movePlayer)	
		--end
	end
end

return Arrows;