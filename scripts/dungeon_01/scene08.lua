
local composer = require("composer")
local scene = composer.newScene()
local Map = require("scripts.map")

local map

--Specifiy the current scene
local sceneName = 3


function scene:create()
	print("**CREATING SCENE ".. sceneName .. "**")

	local sceneGroup = self.view

	map = Map:new()
	
	--List to add map elements (holes, different color tiles, etc.)
	creatorList = 
	{
		-- Args: type, frameNum, x, y, passable
		[1] = {"tile", 4, 7, 5, true}, -- dark brown
		[2] = {"tile", 4, 7, 6, true}, -- dark brown
		[3] = {"tile", 4, 7, 7, true}, -- dark brown
		[4] = {"tile", 4, 7, 8, true}, -- dark brown
		[5] = {"tile", 4, 8, 5, true}, -- dark brown
		[6] = {"tile", 4, 8, 6, true}, -- dark brown
		[7] = {"tile", 4, 8, 7, true}, -- dark brown
		[8] = {"tile", 4, 8, 8, true}, -- dark brown
		[9] = {"tile", 4, 9, 5, true}, -- dark brown
		[10] = {"tile", 4, 9, 6, true}, -- dark brown
		[11] = {"tile", 4, 9, 7, true}, -- dark brown
		[12] = {"tile", 4, 9, 8, true}, -- dark brown
		[13] = {"tile", 4, 10, 5, true}, -- dark brown
		[14] = {"tile", 4, 10, 6, true}, -- dark brown
		[15] = {"tile", 4, 10, 7, true}, -- dark brown
		[16] = {"tile", 4, 10, 8, true}, -- dark brown
		[17] = {"tile", 4, 11, 5, true}, -- dark brown
		[18] = {"tile", 4, 11, 6, true}, -- dark brown
		[19] = {"tile", 4, 11, 7, true}, -- dark brown
		[20] = {"tile", 4, 11, 8, true}, -- dark brown
		[21] = {"tile", 4, 12, 5, true}, -- dark brown
		[22] = {"tile", 4, 12, 6, true}, -- dark brown
		[23] = {"tile", 4, 12, 7, true}, -- dark brown
		[24] = {"tile", 4, 12, 8, true}, -- dark brown
	}


	--List to add objects layered on top of map
	objectList = 
	{
		-- Args: type, description/sheet, frameNum, x, y, passable, pushable
		-- Extra Door Args: toScene, toX, toY, lock color
		-- Extra Enemy Args: HP, ATK, movement
		-- Extra Item Args: power
		[1] = {"door", "door",    1, 1, 5, false, false, "scene07", 12, 5}, -- left
		[2] = {"door", "door",    1, 7, 1, true, false,  "scene10", 7, 8}, -- top
		[3] = {"enemy","mummy",   1, 7, 3, true, false, 30, 8, "PATROL_HORZ"}, -- Enemy 8.1 (tier 2)
		[4] = {"enemy","whiteSkeleton",   1, 9, 7, true, false, 20, 5, "RANDOM"}, -- Enemy 8.2 (tier 1)
		[5] = {"enemy","whiteSkeleton",   1, 11, 6, true, false, 20, 5, "RANDOM"}, -- Enemy 8.3 (tier 1)
		[6] = {"item", "weapon",  4, 11, 7, true, false, 10}, -- standard 
		[7] = {"item", "decor",   20, 9, 6, false, false},  -- tombstone
		[8] = {"item", "decor",   20, 11, 5, false, false},  -- tombstone
		[9] = {"item", "decor",   21, 12, 8, false, false},  -- tombstone
		[10] = {"item", "decor",  22, 9, 8, false, false},  -- tombstone
	}
end


-- "scene:show()"
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase
	local params = event.params

	if ( phase == "will" ) then
		-- Called when the scene is still off screen (but is about to come on screen)
		map.currentScene = sceneName

		local previousScene = composer.getSceneName( "previous" )
		if(previousScene~=nil) then
		    composer.removeScene(previousScene)
		end


		local found = false
		for _ in pairs(params.sList) do
			if _ == sceneName then
				found = true
			end
		end

		if found == true then
			map.sceneList = params.sList

			map.enemyList = params.sList[sceneName].enemyList
			map.itemList  = params.sList[sceneName].itemList

		else
			
			map.sceneList = params.sList

			newScene = {enemyList = {}, itemList = {}}
			table.insert(map.sceneList, sceneName, newScene)		
		end

		map:generateMap(1, "grayWall", creatorList, objectList)		

		player = map:placePlayer("player", 1, params.startX, params.startY)

	elseif ( phase == "did" ) then
		-- Called when the scene is now on screen
		-- Insert code here to make the scene come alive
		-- Example: start timers, begin animation, play audio, etc.
		--[[
		local function movePlayer(event)
			if event.phase == "began" then
				map1.player:move(event.target.xVal,event.target.yVal)
			end
		end
		map1.leftArrow:addEventListener("touch", movePlayer)
		map1.upArrow:addEventListener("touch", movePlayer)
		map1.rightArrow:addEventListener("touch", movePlayer)
		map1.downArrow:addEventListener("touch", movePlayer)
		]]--
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