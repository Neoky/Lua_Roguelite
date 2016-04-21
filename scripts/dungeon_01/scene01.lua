---------------
--File: scene01.lua
--
--Description:
--  Handles the map information for the scene
---------------

local composer = require("composer")
local scene = composer.newScene()
local Map = require("scripts.map")

local map
local sceneName = 1

function scene:create()
	print("**CREATING SCENE ".. sceneName .. "**")

	local sceneGroup = self.view


	map = Map:new()

	--List to add map elements (holes, different color tiles, etc.)
	creatorList = 
	{
		-- Args: type, frameNum, x, y, passable
	}


	--List to add objects layered on top of map
	objectList = 
	{
		-- Args: type, description/sheet, frameNum, x, y, passable, pushable
		-- Extra Door Args: toScene, toX, toY, lock color
		-- Extra Enemy Args: HP, ATK, movement
		-- Extra Item Args: power
		[1] = {"door",  "door",  1, 1, 5, false, false, "scene02", 12, 5}, -- left
		[2] = {"door",  "door",  1, 13, 5, true, false, "scene07", 2, 5}, -- right
		[3] = {"door",  "door",  1, 7, 1, true, false,  "scene12", 7, 8}, -- top	
		[4] = {"enemy", "fly",   1, 5, 4, true, false, 20, 5, "RANDOM"}, -- Enemy1.1 (tier 1)
		[5] = {"enemy", "fly",   1, 9, 4, true, false, 20, 5, "RANDOM"}, -- Enemy1.2 (tier 1)
		[6] = {"item",  "decor", 38, 3, 1, false, false}, -- wall candles
		[7] = {"item",  "decor", 38, 4, 1, false, false}, -- wall candles
		[8] = {"item",  "decor", 38, 5, 1, false, false}, -- wall candles
		[9] = {"item",  "decor", 38, 9, 1, false, false}, -- wall candles
		[10] = {"item", "decor", 38, 10, 1, false, false}, -- wall candles
		[11] = {"item", "decor", 38, 11, 1, false, false}, -- wall candles
		[12] = {"item",  "decor", 31, 6, 2, false, false}, -- blank sign post
		[13] = {"item",  "decor", 32, 8, 2, false, false}, -- broken sign post
		[14] = {"item",  "decor", 34, 2, 3, false, false}, -- bread vendor
		[15] = {"item",  "decor", 35, 12, 3, false, false}, -- bread vendor
		[16] = {"item",  "decor", 36, 12, 7, false, false}, -- bread vendor
		[17] = {"item",  "decor", 33, 2, 7, false, false}, -- bread vendor
		--[18] = {"item", "potion",  2, 12, 8, true, false, 10}, -- potion	--Uncomment this for an extra potion in the first room
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

		if(params ~= nil) then
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
		else
		    local previousScene = composer.getSceneName( "previous" )
		    if(previousScene~=nil) then
		    	--The previous scene should be the title screen
		        composer.removeScene(previousScene)
		    end

			--Special case the first scenario when there won't be a scene list yet 
			map:generateMap(1, "grayWall", creatorList, objectList)

			newScene = {scene = sceneName, enemyList = {}, itemList = {}}
			table.insert(map.sceneList, newScene)

			player = map:placePlayer("player", 1, 7, 8)
		end



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