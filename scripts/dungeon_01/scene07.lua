---------------
--File: scene07.lua
--
--Description:
--  Handles the map information for the scene
---------------
local composer = require("composer")
local scene = composer.newScene()
local Map = require("scripts.map")

local map

--Specify the current scene
local sceneName = 7


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
		[1] = {"door", "door",    1, 1, 5, false, false, "scene01", 12, 5}, -- left
		[2] = {"door", "door",    1, 13, 5, true, false, "scene08", 2, 5}, -- right
		[3] = {"door", "door",    1, 7, 1, true, false,  "scene09", 7, 8}, -- top
		[4] = {"item", "armor",   3, 10, 7, true, false, 10}, -- standard 
		[5] = {"item", "decor",   23, 2, 7, false, false}, -- bed 
		[6] = {"item", "decor",   24, 2, 8, false, false}, -- silver pot 
		[7] = {"item", "decor",   25, 3, 8, false, false}, -- broken pot
		[8] = {"item", "decor",   26, 7, 6, false, true}, -- silver chair
		[9] = {"item", "decor",   27, 8, 6, false, true}, -- silver square table
		[10] = {"item", "decor",  28, 6, 6, false, false}, -- single candle
		[11] = {"item", "decor",  29, 6, 8, false, true}, -- broken bookcase
		[12] = {"item", "decor",  29, 7, 8, false, true}, -- broken bookcase
		[13] = {"item", "decor",  5, 8, 8, false, true}, -- broken bookcase
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