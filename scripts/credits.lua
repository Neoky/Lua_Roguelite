---------------
--File: credits.lua
--
--Description:
--  This file handles the screen that shows the games credits
---------------

local composer = require("composer")
local scene = composer.newScene()

local credits, jonathan, martin, steven, insert_more, title_screen;

function scene:create()
	local sceneGroup = self.view

	credits = display.newText( "Credits", display.contentCenterX, 100, native.systemFontBold, 100 )
	credits:setFillColor( 1,1,1 )
	jonathan = display.newText( "Jonathan Bryant", display.contentCenterX, display.contentCenterY-100, native.systemFont, 72 )
	jonathan:setFillColor( 1,1,1 )
	martin = display.newText( "Martin Cox", display.contentCenterX, display.contentCenterY, native.systemFont, 72 )
	martin:setFillColor( 1,1,1 )
	steven = display.newText( "Steven Muller", display.contentCenterX, display.contentCenterY + 100, native.systemFont, 72 )
	steven:setFillColor( 1,1,1 )
	insert_more = display.newText( "DawnLike Tile Set by DragonDePlatino/DawnBringer @ OpenGameArt.org", display.contentCenterX, display.contentCenterY + 200, native.systemFont, 32 )
	insert_more2 = display.newText( "Music by Jay Man @ https://ourmusicbox.com/", display.contentCenterX, display.contentCenterY + 240, native.systemFont, 32 )
	insert_more3 = display.newText( "Sound Effects generated from ww.superflashbros.net/as3sfxr/", display.contentCenterX, display.contentCenterY + 280, native.systemFont, 32 )
	insert_more:setFillColor( 1,1,1 )
	sceneGroup:insert(credits)
	sceneGroup:insert(jonathan)
	sceneGroup:insert(martin)
	sceneGroup:insert(steven)
	sceneGroup:insert(insert_more)
	sceneGroup:insert(insert_more2)
	sceneGroup:insert(insert_more3)	
end


-- "scene:show()"
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Called when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Called when the scene is now on screen
		-- Insert code here to make the scene come alive
		-- Example: start timers, begin animation, play audio, etc.
		title_screen = function() composer.gotoScene( 'scripts.title_screen') end;
		Runtime:addEventListener( "tap", title_screen )
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
		Runtime:removeEventListener( "tap", title_screen )
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