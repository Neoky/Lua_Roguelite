---------------
--File: scene02.lua
--
--Description:
--  Handles the map information for the scene
---------------
local composer = require("composer")
local scene = composer.newScene()
local Map = require("scripts.map")

local map
local sceneName = 2


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
		[1] = {"door", "door",  1, 1, 5, false, false, "scene03", 12, 5}, -- left
		[2] = {"door", "door",  1, 13, 5, true,  false, "scene01", 2, 5}, -- right
		[3] = {"enemy","whiteSkeleton",  1, 5, 5, true, false, 30, 8, "PATROL_VERT"}, -- Enemy2.1 (tier 2)
		[4] = {"enemy","greenSkeleton",  1, 9, 5, true, false, 30, 8, "PATROL_VERT"}, -- Enemy2.2 (tier 2)
		[5] = {"item",  "scroll",        1, 3, 2, false, true}, -- white scroll
		[6] = {"item",  "scroll",        2, 11, 2, false, true}, -- gray scroll
		[7] = {"item",  "scroll",        3, 10, 8, false, true}, -- brown scroll
		[8] = {"item",  "light",         2, 9, 2, false, true}, -- lantern
		[9] = {"item",  "decor",         41, 8, 2, false, true}, -- sleeping bag
		[10] = {"item", "decor",         41, 10, 2, false, true}, -- sleeping bag
		[11] = {"item", "ore",           1, 2, 2, false, false}, -- ore
		[12] = {"item", "ore",           1, 2, 3, false, false}, -- ore
		[13] = {"item", "ore",           1, 3, 3, false, false}, -- ore
		[14] = {"item", "ore",           1, 4, 3, false, false}, -- ore
		[15] = {"item", "ore",           1, 4, 2, false, false}, -- ore
		[16] = {"item", "ore",           1, 9, 8, false, false}, -- ore
		[17] = {"item", "ore",           1, 9, 7, false, false}, -- ore
		[18] = {"item", "ore",           1, 10, 7, false, false}, -- ore
		[19] = {"item", "ore",           1, 11, 7, false, false}, -- ore
		[20] = {"item", "ore",           1, 12, 7, false, false}, -- ore
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