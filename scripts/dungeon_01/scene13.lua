
local composer = require("composer")
local scene = composer.newScene()
local Map = require("scripts.map")

local map

--Specifiy the current scene
local sceneName = 13


function scene:create()
	print("**CREATING SCENE ".. sceneName .. "**")

	local sceneGroup = self.view

	map = Map:new()
	
	--List to add map elements (holes, different color tiles, etc.)
	creatorList = 
	{

	}


	--List to add objects layered on top of map
	objectList = 
	{
		-- Args: type, description/sheet, frameNum, x, y, passable, pushable
		-- Extra Door Args: toScene, toX, toY, lock color
		-- Extra Enemy Args: HP, ATK, movement
		-- Extra Item Args: power
		[1] = {"door", "door",    1, 7, 1, true, false,  "scene14", 7, 8, "red"}, -- top
		[2] = {"door", "door",    1, 7, 9, true, false,  "scene12", 7, 2}, -- bottom
		[3] = {"item", "armor",   2, 2, 5, true, false, 10}, -- standard
		[4] = {"item", "potion",  2, 12, 5, true, false, 10}, -- standard
		[5] = {"item", "decor",  43, 2, 2, true, false}, -- square tombstone
		[6] = {"item", "decor",  43, 5, 2, true, false}, -- square tombstone
		[7] = {"item", "decor",  43, 9, 2, true, false}, -- square tombstone
		[8] = {"item", "decor",  43, 12, 2, true, false}, -- square tombstone
		[9] = {"item", "decor",  43, 2, 3, true, false}, -- square tombstone
		[10] = {"item", "decor",  43, 4, 3, true, false}, -- square tombstone
		[11] = {"item", "decor",  43, 5, 3, true, false}, -- square tombstone
		[12] = {"item", "decor",  43, 6, 3, true, false}, -- square tombstone
		[13] = {"item", "decor",  43, 7, 3, true, false}, -- square tombstone
		[14] = {"item", "decor",  43, 8, 3, true, false}, -- square tombstone
		[15] = {"item", "decor",  43, 9, 3, true, false}, -- square tombstone
		[16] = {"item", "decor",  43, 10, 3, true, false}, -- square tombstone
		[17] = {"item", "decor",  43, 12, 3, true, false}, -- square tombstone
		[18] = {"item", "decor",  43, 3, 4, true, false}, -- square tombstone
		[19] = {"item", "decor",  43, 6, 4, true, false}, -- square tombstone
		[20] = {"item", "decor",  43, 8, 4, true, false}, -- square tombstone
		[21] = {"item", "decor",  43, 11, 4, true, false}, -- square tombstone
		[22] = {"item", "decor",  43, 6, 5, true, false}, -- square tombstone
		[23] = {"item", "decor",  43, 8, 5, true, false}, -- square tombstone
		[24] = {"item", "decor",  43, 2, 6, true, false}, -- square tombstone
		[25] = {"item", "decor",  43, 3, 6, true, false}, -- square tombstone
		[26] = {"item", "decor",  43, 4, 6, true, false}, -- square tombstone
		[27] = {"item", "decor",  43, 5, 6, true, false}, -- square tombstone
		[28] = {"item", "decor",  43, 6, 6, true, false}, -- square tombstone
		[29] = {"item", "decor",  43, 8, 6, true, false}, -- square tombstone
		[30] = {"item", "decor",  43, 9, 6, true, false}, -- square tombstone
		[31] = {"item", "decor",  43, 10, 6, true, false}, -- square tombstone
		[32] = {"item", "decor",  43, 11, 6, true, false}, -- square tombstone
		[33] = {"item", "decor",  43, 12, 6, true, false}, -- square tombstone
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
		local index = nil
		for _ in pairs(params.sList) do
			if params.sList[_].scene == sceneName then
				found = true
				index = _
			end
		end


		if found == true then
			map.sceneList = params.sList

			map.enemyList = params.sList[index].enemyList
			map.itemList  = params.sList[index].itemList

		else			
			map.sceneList = params.sList

			newScene = {scene = sceneName, enemyList = {}, itemList = {}}
			table.insert(map.sceneList, newScene)		
		end

		map:generateMap(1, "grayWall", creatorList, objectList)		

		player = map:placePlayer("player", 1, params.startX, params.startY)

	elseif ( phase == "did" ) then
		-- Called when the scene is now on screen
		-- Insert code here to make the scene come alive
		-- Example: start timers, begin animation, play audio, etc.

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