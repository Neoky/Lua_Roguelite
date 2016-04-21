---------------
--File: arrows.lua
--
--Description:
--  This file handles the arrows that are created to control the player and what he/she interacts with
---------------

local ItemsTable = require("scripts.items");

--Set up movement arrows (and other icons)

local iOptions =
{
	frames = {
		{ x = 16,  y =  0,  width = 16, height = 15}, -- Arrow
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
		sword.x = (o.player.body.x + e.target.xTag)
		sword.y = (o.player.body.y + e.target.yTag)

		sword.rotation = e.target.rotation-90
		sword:scale(tileScale,tileScale)
		local sfx = audio.loadStream( "audio/hit.wav" )
		audio.play( sfx, { channel=2, loops=0, fadein=0 } )
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
			local originalX = enemy.xOrigin
			local originalY = enemy.yOrigin

			enemy:hit(player.attack)

			--If the enemy has been defeated, mark in the enemy list that it is gone
			if objectArray[x][y] == nil then
				print("Enemy is defeated, removing")
				o.map:markForRemoval("enemy", originalX, originalY)
			end

			battleAnimation(e)
			return true, false
		elseif objectList[x][y] and objectList[x][y].tag == "trap" then
			print("TRAP DETECTED")
			local trap = objectList[x][y]
			player:reduceHP(trap.power);
			-- save trap object before player steps onto it
			if self.lostObj == nil then
				self.lostObj = trap; 
			else
				-- lost object container is in use; use another container
				self.lostObj2 = trap;
			end
		elseif objectList[x][y] and objectList[x][y].tag == "key" then
			local key = objectList[x][y]
			local originalX = key.xOrigin
			local originalY = key.yOrigin

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
			o.map:markForRemoval("item", originalX, originalY)
		elseif objectList[x][y] and objectList[x][y].tag == "weapon" then
			print("WEAPON DETECTED")
			local weapon = objectList[x][y]
			local originalX = weapon.xOrigin
			local originalY = weapon.yOrigin

			player.attack = player.attack + weapon.power;
			weapon:remove();
			o.map:markForRemoval("item", originalX, originalY)			
		elseif objectList[x][y] and objectList[x][y].tag == "armor" then
			print("ARMOR DETECTED")
			local armor = objectList[x][y]
			local originalX = armor.xOrigin
			local originalY = armor.yOrigin

			player.hpMax = player.hpMax + armor.power;
			player:restoreHP(armor.power)
			armor:remove();
			o.map:markForRemoval("item", originalX, originalY)
		elseif objectList[x][y] and objectList[x][y].tag == "shield" then
			print("SHIELD DETECTED")
			local shield = objectList[x][y]
			local originalX = shield.xOrigin
			local originalY = shield.yOrigin

			player.hpMax = player.hpMax + shield.power;
			player:restoreHP(shield.power)
			shield:remove();
			o.map:markForRemoval("item", originalX, originalY)		
		elseif objectList[x][y] and objectList[x][y].tag == "potion" then
			print("POTION DETECTED")
			local potion = objectList[x][y]
			local originalX = potion.xOrigin
			local originalY = potion.yOrigin

			player:restoreHP(potion.power)
			potion:remove();
			o.map:markForRemoval("item", originalX, originalY)	
		elseif objectList[x][y] and objectList[x][y].tag == "chest" then
			print("CHEST DETECTED")
			local chest = objectList[x][y]
			local originalX = chest.xOrigin
			local originalY = chest.yOrigin

			-- shows chest contents and then removes the chest
			if chest:openChest() == false then
				-- chest is empty so do nothing
				return true, false;
			end

			-- update player stats based on chest contents
			if chest.contents == "armor" then
				player.hpMax = player.hpMax + chest.power;
				player:restoreHP(chest.power)
			elseif chest.contents == "weapon" then 
				player.attack = player.attack + chest.power;
			end

			o.map:markForRemoval("item", originalX, originalY)	
			return true, false;	-- do not move player
		elseif objectList[x][y] and objectList[x][y].pushable == true then
			print("PUSHABLE DETECTED")
			local pushable = objectList[x][y]
			itemMoved = pushable:move(player.xPos, player.yPos);
			if itemMoved == true then return false;
			else return true, false;
			end
		elseif objectList[x][y] and objectList[x][y].passable == false and objectList[x][y].tag ~= "door" then
			print("NON-PASSABLE ITEM DETECTED")
			return true, false;	-- do not move player
		elseif objectList[x][y] and objectList[x][y].tag == "door" then
			print("DOOR DETECTED")
			local door = objectList[x][y]
			local flag = false
			if door.locked == false then
				flag = true
				o.map:transition(x, y)
			elseif player:haveKey(door.color) == true then
				-- player has key to locked door
				print("DOOR UNLOCKED")
				flag = true
				o.map:transition(x, y)
			else
				-- player does not have correct key to locked door
				print("DOOR IS LOCKED")
			end
			return true,flag;
		end
		return false,false
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
			local transitionFlag = false
			interaction,transitionFlag = interactionCheck(event, event.target.xVal,event.target.yVal)

			if player.hpCur == 0 then
				transitionFlag = true
				o.map:gameOver()
			elseif interaction == false then
				oldX, oldY = o.player:move(event.target.xVal,event.target.yVal)
				
				if self.lostObj ~= nil and self.lostObj.mapX == oldX and self.lostObj.mapY == oldY then
					-- place deleted object back into array
					if objectArray[oldX][oldY] ~= nil and objectArray[oldX][oldY].tag == "enemy" and 
						self.lostObj.tag == "trap" then
						-- enemy fell into trap so remove enemy before adding trap back
						print("Enemy has fallen into trap")
						local enemy = objectArray[oldX][oldY];
						enemy:remove();
					end
					objectArray[oldX][oldY] = self.lostObj
					self.lostObj = nil;
					-- check if object exists in second lost container
					if self.lostObj2 ~= nil then
						-- move up object to first container
						self.lostObj = self.lostObj2;
						self.lostObj2 = nil;
					end
				end


				local sfx = audio.loadStream( "audio/jump.wav" )
				audio.play( sfx, { channel=2, loops=0, fadein=0 } )

				o:setArrows(event.target.xVal, event.target.yVal)


			else
				o.player:move(o.player.xPos, o.player.yPos)
			end

			if transitionFlag == false then
				o.map:updateInfoScreen()
			end
		end
	end

	function keyPlayer(event)

	    --local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase
	    --print( message )

	    if ( event.keyName == "up" ) then
            t.target = o.upArrow;
        elseif ( event.keyName == "down" ) then
            t.target = o.downArrow;
        elseif ( event.keyName == "right" ) then
            t.target = o.rightArrow;
        elseif ( event.keyName == "left" ) then
            t.target = o.leftArrow;
	    end
	    
        if event.phase == "down" then
        	event.phase = "began"
        	event.target = t.target
	    	movePlayer(event)
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
	print("Player x,y = " .. xVal .. "," .. yVal)
	print("passable, pushable = " .. tostring(self.map.mapArray[xVal][yVal].passable), tostring(self.map.mapArray[xVal][yVal].pushable))

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

		upArrow = display.newImage( iconSheet, 1)

		upArrow.x = display.contentWidth-125
		upArrow.y = display.contentHeight-150
		upArrow.xTag = 0
		upArrow.yTag = -50
		upArrow.xVal, upArrow.yVal = xVal, yVal-1


		upArrow:toFront()

		upArrow:scale( tileScale, tileScale )
		self.upArrow = upArrow

		upArrow:addEventListener("touch", movePlayer)

	end

	if (mapArray[xVal][yVal+1] ~= nil) and mapArray[xVal][yVal+1].passable == true then

		downArrow = display.newImage( iconSheet, 1)

		downArrow.x = display.contentWidth-125
		downArrow.y = display.contentHeight-75
		downArrow.xTag = 0
		downArrow.yTag = 50
		downArrow.xVal, downArrow.yVal = xVal, yVal+1

		downArrow:rotate( 180 )

		downArrow:toFront()

		downArrow:scale( tileScale, tileScale )
		self.downArrow = downArrow

		downArrow:addEventListener("touch", movePlayer)

	end

	if (xVal > 1) and mapArray[xVal-1][yVal].passable == true then	

		leftArrow = display.newImage( iconSheet, 1)

		leftArrow.x = display.contentWidth-200
		leftArrow.y = display.contentHeight-110
		leftArrow.xTag = -50
		leftArrow.yTag = 0
		leftArrow.xVal, leftArrow.yVal = xVal-1, yVal

		leftArrow:rotate( -90 )

		leftArrow:toFront()

		leftArrow:scale( tileScale, tileScale )
		self.leftArrow = leftArrow

		leftArrow:addEventListener("touch", movePlayer)		
	end

	if (xVal < table.getn(mapArray)) and mapArray[xVal+1][yVal].passable == true then

		rightArrow = display.newImage( iconSheet, 1)

		rightArrow.x = display.contentWidth-50
		rightArrow.y = display.contentHeight-110
		rightArrow.xTag = 50
		rightArrow.yTag = 0
		rightArrow.xVal, rightArrow.yVal = xVal+1, yVal

		rightArrow:rotate( 90 )

		rightArrow:toFront()

		rightArrow:scale( tileScale, tileScale )
		self.rightArrow = rightArrow

		rightArrow:addEventListener("touch", movePlayer)	
	end
	--Runtime:addEventListener( "key", keyPlayer )
end

------------------------
--Function:    destroy
--Description: 
--  Removes all arrow images. Use when tranisitoning between scenes
------------------------
function Arrows:destroy()
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
end


return Arrows;