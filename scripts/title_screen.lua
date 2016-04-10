
local composer = require("composer")
local scene = composer.newScene()

local title, start, credits, start_game, credits_screen,background;

function scene:create()
	local sceneGroup = self.view
	--Examples (these can be used to create each separate level)--
	background = display.newImage( "images/Examples/Dungeon.gif" )
	background:scale(3,3)
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	background:toBack( )
	title = display.newEmbossedText( "Tale of the Rogue", display.contentCenterX, 150, native.systemFontBold, 100 )
	title:setFillColor( 1,1,1 )
	start = display.newEmbossedText( "Tap to Start", display.contentCenterX, display.contentCenterY, native.systemFont, 72 )
	start:setFillColor( 1,1,1 )
	credits = display.newEmbossedText( "credits", display.contentCenterX, display.contentCenterY + 200, native.systemFont, 48 )
	credits:setFillColor( 1,1,1 )
	credits:toFront( )
	local color = 
	{
	    highlight = { r=1, g=0, b=1 },
	    shadow = { r=0, g=0, b=0 }
	}
	title:setEmbossColor( color )
	start:setEmbossColor( color )
	credits:setEmbossColor( color )
	sceneGroup:insert(background)
	sceneGroup:insert(title)
	sceneGroup:insert(start)
	sceneGroup:insert(credits)
--local spriteSheet = graphics.newImageSheet( "images/Characters/PlayerCombined.png", spriteOpt );
	--spriteSheet = graphics.newImageSheet( "images/Examples/Dungeon.gif")
end


-- "scene:show()"
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Called when the scene is still off screen (but is about to come on screen)

		-- delete previous save data at game start.
		local player = require('scripts.player')
		player.delete()

	elseif ( phase == "did" ) then
		-- Called when the scene is now on screen
		-- Insert code here to make the scene come alive
		-- Example: start timers, begin animation, play audio, etc.

		start_game = function() composer.gotoScene( 'scripts.dungeon_01.scene01') end;
		start:addEventListener( "tap", start_game )
		credits_screen = function() composer.gotoScene( 'scripts.credits') end;
		credits:addEventListener( "tap", credits_screen )
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
		start:removeEventListener( "tap", start_game )
		credits:removeEventListener( "tap", credits_screen )
	end
end


-- "scene:destroy()"
function scene:destroy( event )

	local sceneGroup = self.view

	-- Called prior to the removal of scene's view
	-- Insert code here to clean up the scene
	-- Example: remove display objects, save state, etc.
	sceneGroup:removeSelf()
end

scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene;