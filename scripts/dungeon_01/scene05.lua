---------------
--File: scene05.lua
--
--Description:
--  Handles the map information for the scene
---------------
local composer = require("composer")
local scene = composer.newScene()
local Map = require("scripts.map")

local map

--Specify the current scene
local sceneName = 5


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
		[1] = {"door", "door",    1, 7, 1, true, false,  "scene03", 7, 8}, -- top	
		[2] = {"enemy","whiteGhost",  1, 6, 5, true, false, 30, 8, "PATROL_HORZ"}, -- tier 2
		[3] = {"item", "rkey",    1, 2, 7, true, false}, -- red key 	
		[4] = {"item", "potion",  1, 2, 4, true, false, 10}, -- standard
		[5] = {"item",  "decor", 44, 8, 7, false, false}, -- water fountain
		[6] = {"item",  "decor", 48, 9, 7, false, false}, -- statue 
		[7] = {"item",  "decor", 48, 9, 2, false, false}, -- statue
		[8] = {"item",  "decor", 48, 4, 3, false, false}, -- statue
		[9] = {"item",  "decor", 48, 2, 6, false, false}, -- statue 
		[10] = {"item",  "decor", 48, 12, 6, false, false}, -- statue 
		[11] = {"item",  "decor", 48, 5, 8, false, false}, -- statue 
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