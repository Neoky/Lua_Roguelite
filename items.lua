---------------
--File: items.lua
--
--Description:
--  This file holds the image sheets for the items.
---------------

local IMAGE_WIDTH = 16;
local IMAGE_HEIGHT = 16;

local ItemsTable = {};

local ItemOptionsTable = {
	door =
	{
		options = {
			frames = {
				{ x =  0,  y =   0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, --wood door	
				{ x = 16,  y =   0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, --wood locked door
				{ x =  0,  y =  16,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, --metal door	
				{ x = 16,  y =  16,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, --metal locked door	
				{ x =  0,  y =  80,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, --Open Path
			}
		},
	}, -- door
	decor =
	{
		options = {
			frames = {
				{ x =  16,  y =  48,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- Brown Pot
				{ x =  48,  y =  48,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- Silver Pot
			}
		},
	}, -- decor
	trap =
	{
		options = {
			frames = {
				{ x = 0,  y =  48,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- Spear Trap
			}
		},
	}, -- trap

};  -- end ItemOptionsTable

ItemsTable = {
	door =
	{
		sheet = graphics.newImageSheet( "images/Objects/Door0.png", 
			ItemOptionsTable.door.options ),
	}, -- door
	decor =
	{
		sheet = graphics.newImageSheet( "images/Objects/Decor0.png", 
			ItemOptionsTable.decor.options ),
	}, -- decor
	trap =
	{
		sheet = graphics.newImageSheet( "images/Objects/Trap0.png", 
			ItemOptionsTable.trap.options ),
	}, -- trap

};  -- end ItemsTable




return ItemsTable;