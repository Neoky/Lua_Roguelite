
local composer = require("composer")
local scene = composer.newScene()
local Map = require("scripts.map")
--local File = require("scripts.saveGame")
--local Items, Player, Enemy, enemyClass, Map = require('scripts.standardAssets')
local map
local sceneName = 1

function scene:create()
	print("**CREATING SCENE ".. sceneName .. "**")

	local sceneGroup = self.view


	map = Map:new()

	--List to add map elements (holes, different color tiles, etc.)
	creatorList = 
	{
		--type, frameNum, x, y, passable
		[1] = {"tile", 2, 3, 4, true},
		[2] = {"tile", 2, 5, 5, true},
	}


	--List to add objects layered on top of map
	objectList = 
	{
		--type, description/sheet, frameNum, x, y, passable, pushable
		[1] = {"item","decor",    2, 3, 5, false, true},
		[2] = {"item","trap",     1, 10, 6, true, false}, 
		[3] = {"item","armor",    4, 11, 3, true, false}, 
		[4] = {"item","potion",   7, 3, 7, true, false},
		[5] = {"enemy","undead",  1, 8, 6, false, false},
		[6] = {"door", "door",    1, 1, 5, false, false, "scene02", 12, 5, "green"}, --Extra Door Args are: toScene, toX, toY, lock color
		[7] = {"door", "door",    1, 13, 5, true, false, "scene02", 2, 5},
		[8] = {"door", "door",    1, 7, 1, true, false,  "scene03", 7, 8},
		[9] = {"door", "door",    1, 7, 9, true, false,  "scene03", 7, 2,  "blue"},
		[10] = {"item", "weapon", 1, 9, 3, true, false},
		[11] = {"item", "gkey",   1, 12, 2, true, false},
		[12] = {"enemy","undead", 1, 7, 7, false, false},	
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
			for _ in pairs(params.sList) do
				if _ == sceneName then
					found = true
				end
			end

			if found == true then
				map.sceneList = params.sList
		
				map.enemyList = params.sList[sceneName].enemyList
				map.itemList  = params.sList[sceneName].itemList

				newScene = {enemyList = {}, itemList = {}}
				table.insert(map.sceneList, sceneName, newScene)
			end

			map:generateMap(1, "grayWall", creatorList, objectList)		

			player = map:placePlayer("player", 1, params.startX, params.startY)
		else
			--Special case the first scenario when there won't be a scene list yet 
			map:generateMap(1, "grayWall", creatorList, objectList)

			newScene = {enemyList = {}, itemList = {}}
			table.insert(map.sceneList, sceneName, newScene)

			player = map:placePlayer("player", 1, 6, 6)
		end



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