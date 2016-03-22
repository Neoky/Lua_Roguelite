
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


Arrows = {upArrow={}, downArrow={}, leftArrow={}, rightArrow={}, player={}, map={}};
local upArrow, downArrow, leftArrow, rightArrow;

function Arrows:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self


	------------------------
	--Function:    movePlayer
	--Description: 
	--  Listener function that triggers when one of the movement arrows is tapped
	--  Moves the player, updates the objectArray, sets new Arrows, and updates the Info screen
	------------------------
	function movePlayer(event)
		if event.phase == "began" then
			oldX, oldY = o.player:move(event.target.xVal,event.target.yVal)
			
			objectArray[event.target.xVal][event.target.yVal] = self.player
			objectArray[oldX][oldY] = nil

			o:setArrows(event.target.xVal, event.target.yVal)

			--TODO:Call player functions to handle combat/picking up items

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

		rightArrow:rotate( 90 )

		rightArrow:toFront()

		rightArrow:scale( tileScale, tileScale )
		self.rightArrow = rightArrow

		rightArrow:addEventListener("touch", movePlayer)	
		--end
	end
end

return Arrows;