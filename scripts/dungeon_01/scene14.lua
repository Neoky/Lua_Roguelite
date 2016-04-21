---------------
--File: scene14.lua
--
--Description:
--  Handles the map information for the scene
---------------

local composer = require("composer")
local scene = composer.newScene()
local Map = require("scripts.map")

local map

--Specify the current scene
local sceneName = 14


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
		[1] = {"door",  "door",      1, 7, 9, true, false,  "scene13", 7, 2}, -- bottom
		[2] = {"door",  "door",      7, 7, 1, true, false,  "winScreen", 7, 2}, -- top
		[3] = {"enemy", "redDemon",  2, 7, 4, true, false, 100, 25, "STAND"}, -- boss
		
		[4] = {"item", "decor",     16, 3, 3, false, false},  -- white skull
		[5] = {"item", "decor",     17, 3, 6, false, false},  -- pile of white bones
		[6] = {"item", "decor",     18, 9, 2, false, false},  -- white animal skull
		[7] = {"item", "decor",     19, 10, 3, false, false},  -- white rib cage
		[8] = {"item", "decor",     16, 9, 6, false, false},  -- white skull
		-- Walls around boss
		[9] = {"item", "decor",      16, 6, 2, false, false},  -- white skull
		[10] = {"item", "decor",      17, 6, 3, false, false},  -- white skull
		[11] = {"item", "decor",     18, 6, 4, false, false},  -- white skull
		[12] = {"item", "decor",     17, 8, 2, false, false},  -- white skull
		[13] = {"item", "decor",     19, 8, 3, false, false},  -- white skull
		[14] = {"item", "decor",     16, 8, 4, false, false},  -- white skull

		[15] = {"item",  "decor",    40, 3, 1, false, false}, -- wall candles
		[16] = {"item",  "decor",    40, 4, 1, false, false}, -- wall candles
		[17] = {"item",  "decor",    40, 5, 1, false, false}, -- wall candles
		[18] = {"item",  "decor",    40, 9, 1, false, false}, -- wall candles
		[19] = {"item", "decor",     40, 10, 1, false, false}, -- wall candles
		[20] = {"item", "decor",     40, 11, 1, false, false}, -- wall candles


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