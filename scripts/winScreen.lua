
local composer = require("composer")
local scene = composer.newScene()

local credits, jonathan, martin, steven, insert_more, title_screen;

function scene:create()
	local sceneGroup = self.view
	--Examples (these can be used to create each separate level)--
	congrats = display.newText( "Congrats!", display.contentCenterX, 100, native.systemFontBold, 100 )
	congrats:setFillColor( 1,1,1 )
	youWin = display.newText( "You Win!!!", display.contentCenterX, display.contentCenterY-100, native.systemFont, 72 )
	youWin:setFillColor( 1,1,1 )

	sceneGroup:insert(congrats)
	sceneGroup:insert(youWin)
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