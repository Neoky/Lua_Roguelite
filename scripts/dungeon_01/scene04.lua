
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
	{--[[
		--type, frameNum, x, y, passable
		[1] = {"tile", 2, 3, 4, true},
		[2] = {"tile", 2, 5, 5, true},]]
	}


	--List to add objects layered on top of map
	objectList = 
	{
		-- Args: type, description/sheet, frameNum, x, y, passable, pushable
		-- Extra Door Args: toScene, toX, toY, lock color
		-- Extra Enemy Args: HP, ATK, movement
		-- Extra Item Args: power
		[1] = {"door", "door",   1, 7, 9, true, false,  "scene03", 7, 2}, -- bottom		
		[2] = {"enemy","dementor",  1, 3, 4, true, false, 30, 8, "STAND"}, -- tier 2
		[3] = {"item", "armor",  1, 2, 2, true, false, 10}, -- standard
		[4] = {"item", "bkey",   1, 11, 3, true, false}, -- blue key 
		[5] = {"item", "decor",  9, 2, 5, false, false}, -- bar left piece
		[6] = {"item", "decor",  10, 3, 5, false, false}, -- bar center piece
		[7] = {"item", "decor",  11, 4, 5, false, false}, -- bar right piece
		[8] = {"item", "decor",  12, 5, 2, false, false}, -- bar top piece
		[9] = {"item", "decor",  14, 5, 3, false, false}, -- bar bottom piece
		[10] = {"item", "chest",  6, 7, 2, false, true}, -- gray barrel
		[11] = {"item", "chest",  5, 8, 2, false, true}, -- gray barrel
		[12] = {"item", "chest",  5, 9, 2, false, true}, -- gray barrel
		[13] = {"item", "chest",  7, 11, 7, false, true}, -- gold barrel
		[14] = {"item", "chest",  7, 11, 8, false, true}, -- gold barrel
		[15] = {"item", "chest",  8, 12, 7, false, true}, -- gold barrel
		[16] = {"item", "chest",  7, 12, 8, false, true}, -- gold barrel
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