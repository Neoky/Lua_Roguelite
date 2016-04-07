
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
		[1] = {"tile", 3, 8, 5, false}, -- lava
		[2] = {"tile", 3, 8, 6, false}, -- lava
		[3] = {"tile", 3, 8, 7, false}, -- lava
		[4] = {"tile", 3, 8, 8, false}, -- lava
		[5] = {"tile", 3, 9, 5, false}, -- lava
		[6] = {"tile", 3, 9, 6, false}, -- lava
		[7] = {"tile", 3, 9, 7, false}, -- lava
		[8] = {"tile", 3, 9, 8, false}, -- lava
		[9] = {"tile", 3, 10, 5, false}, -- lava
		[10] = {"tile", 3, 10, 6, false}, -- lava
		[11] = {"tile", 3, 10, 7, false}, -- lava
		[12] = {"tile", 3, 10, 8, false}, -- lava
		[13] = {"tile", 3, 11, 5, false}, -- lava
		[14] = {"tile", 3, 11, 6, false}, -- lava
		[15] = {"tile", 3, 11, 7, false}, -- lava
		[16] = {"tile", 3, 11, 8, false}, -- lava
		[17] = {"tile", 3, 12, 5, false}, -- lava
		[18] = {"tile", 3, 12, 6, false}, -- lava
		[19] = {"tile", 3, 12, 7, false}, -- lava
		[20] = {"tile", 3, 12, 8, false}, -- lava
	}


	--List to add objects layered on top of map
	objectList = 
	{
		-- Args: type, description/sheet, frameNum, x, y, passable, pushable
		-- Extra Door Args: toScene, toX, toY, lock color
		-- Extra Enemy Args: HP, ATK, movement
		-- Extra Item Args: power
		[1] = {"door",  "door",    1, 7, 9, true, false,  "scene10", 7, 2}, -- bottom
		[2] = {"enemy", "demon",   1, 7, 5, true, false, 45, 12, "RANDOM"}, -- tier 3
		[3] = {"item",  "chestWeapon",   3, 7, 2, false, false, 20}, -- round chest containing legendary weapon
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