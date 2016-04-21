---------------
--File: scene03.lua
--
--Description:
--  Handles the map information for the scene
---------------
local composer = require("composer")
local scene = composer.newScene()
local Map = require("scripts.map")

local map

--Specify the current scene
local sceneName = 3


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
		[1] = {"door", "door",    1, 1, 5, false, false, "scene06", 12, 5, "blue"}, -- left
		[2] = {"door", "door",    1, 13, 5, true, false, "scene02", 2, 5}, -- right
		[3] = {"door", "door",    1, 7, 1, true, false,  "scene04", 7, 8}, -- top
		[4] = {"door", "door",    1, 7, 9, true, false,  "scene05", 7, 2}, -- bottom
		[5] = {"item", "weapon",  1, 11, 7, true, false, 10}, -- standard	
		[6] = {"item", "trap",    1, 9, 8, true, false}, 	
		[7] = {"item", "trap",    1, 10, 8, true, false}, 
		[8] = {"item", "trap",    1, 9, 7, true, false}, 	
		[9] = {"item", "trap",    1, 10, 7, true, false}, 
		[10] = {"item", "trap",    1, 9, 6, true, false}, 	
		[11] = {"item", "trap",    1, 10, 6, true, false}, 
		[12] = {"item", "trap",    1, 9, 5, true, false}, 	
		[13] = {"item", "trap",    1, 10, 5, true, false}, 
		[14] = {"item", "trap",    1, 9, 4, true, false}, 	
		[15] = {"item", "trap",    1, 10, 4, true, false},
		[16] = {"item", "trap",    1, 8, 4, true, false},
		[17] = {"item", "trap",    1, 8, 5, true, false},
		[18] = {"item", "trap",    1, 7, 4, true, false},
		[19] = {"item", "trap",    1, 7, 5, true, false},
		[20] = {"item", "trap",    1, 6, 4, true, false},
		[21] = {"item", "trap",    1, 6, 5, true, false},
		[22] = {"item", "trap",    1, 5, 4, true, false},
		[23] = {"item", "trap",    1, 5, 5, true, false},
		[24] = {"item", "trap",    1, 4, 4, true, false},
		[25] = {"item", "trap",    1, 4, 5, true, false},
		[26] = {"item", "trap",    1, 4, 8, true, false},
		[27] = {"item", "trap",    1, 5, 8, true, false},
		[28] = {"item", "trap",    1, 6, 8, true, false},
		[29] = {"item", "trap",    1, 4, 7, true, false},
		[30] = {"item", "trap",    1, 5, 7, true, false},
		[31] = {"item", "trap",    1, 6, 7, true, false},
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