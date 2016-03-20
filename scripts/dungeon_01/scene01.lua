
local composer = require("composer")
local scene = composer.newScene()
local Map = require("scripts.map")
--local Items, Player, Enemy, enemyClass, Map = require('scripts.standardAssets')

local map1

function scene:create()
	local sceneGroup = self.view
	--Examples (these can be used to create each separate level)--

	map1 = Map:new()

	--Make a default room with doors
	mapArray = map1:makeRoom(true, true, true, true)

	print(mapArray[0][0].x)
	print(mapArray[0][0].passable)

	--Swap out a tile with a different one
	mapArray[10][4] = map1:swapTile("door", 1, 10, 4, false)

	print(mapArray[10][4].x)
	print(mapArray[10][4].passable)

	--Place an object on top of a tile. Can specify if passable or pushable
	pot = map1:placeObject("decor", 2, 3, 2, false, true)

	--Place the player character and generate arrows around him if possible

	print("Pot is at " .. pot.x .. "," .. pot.y)
	print(pot.passable)
	print(pot.pushable)

	--List to swap out tile
	creatorList = 
	{
		--type, frameNum, x, y, passable
		[1] = {"tile", 2, 3, 4, true},
		[2] = {"tile", 2, 5, 5, true},
	}

	--Swap out any of the default tiles with custom ones
	mapArray = map1:buildMap(creatorList)

	--List to add objects
	objectList = 
	{
		--type, frameNum, x, y, passable, pushable
		[1] = {"decor", 2, 3, 4, false, true},
		[2] = {"trap", 1, 10, 6, true, false},
		[3] = {"armor", 4, 11, 3, false, false},
		[4] = {"potion", 7, 3, 7, false, false},
		[5] = {"undead", 1, 8, 1, false, false},
		[6] = {"demon", 1, 1, 4, false, false},
	}

	--Fill the map will objects on the tiles
	mapArray = map1:fillMap(objectList)
	player = map1:placePlayer("player", 1, 6, 6, false, false)
end


-- "scene:show()"
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Called when the scene is still off screen (but is about to come on screen)
	elseif ( phase == "did" ) then
		-- Called when the scene is now on screen
		-- Insert code here to make the scene come alive
		-- Example: start timers, begin animation, play audio, etc.
		local function movePlayer(event)
			if event.phase == "began" then
				map1.player:move(event.target.xVal,event.target.yVal)
			end
		end
		map1.leftArrow:addEventListener("touch", movePlayer)
		map1.upArrow:addEventListener("touch", movePlayer)
		map1.rightArrow:addEventListener("touch", movePlayer)
		map1.downArrow:addEventListener("touch", movePlayer)
	end
end


-- "scene:hide()"
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Called when the scene is on screen (but is about to go off screen)
		-- Insert code here to "pause" the scene
		-- Example: stop timers, stop animation, stop audio, etc.
	elseif ( phase == "did" ) then
		-- Called immediately after scene goes off screen
	end
end


-- "scene:destroy()"
function scene:destroy( event )

	local sceneGroup = self.view

	-- Called prior to the removal of scene's view
	-- Insert code here to clean up the scene
	-- Example: remove display objects, save state, etc.
end

scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene;