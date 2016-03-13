---------------
--File: enemy.lua
--
--Description:
--  This file holds the image sheets for the enemies.
---------------

local IMAGE_WIDTH = 16;
local IMAGE_HEIGHT = 16;

local EnemyTable = {};


local EnemyOptionsTable = {
	demon =
	{
		options = {
			frames = {
				{ x = 0.1, y = 0.5, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- green dragon
				{ x = 0.1, y = 16, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- red demon
			}
		},
	}, -- demon
	pest =
	{
		options = {
			frames = {
				{ x = 80, y = 16, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- fly
				{ x = 47.5, y = 32, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- scorpion
				{ x = 48, y = 64, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- ant
				{ x = 0, y = 144, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- spider
			}
		},
	}, -- pest
	undead =
	{
		options = {
			frames = {
				{ x = 80, y = 16, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- mummy
				{ x = 0.5, y = 32, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- white skeleton
				{ x = 32.5, y = 32, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- green skeleton
				{ x = 31, y = 63, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- white ghost
				{ x = -1, y = 96.5, width = IMAGE_WIDTH, height = IMAGE_HEIGHT }, -- dementor
			}
		},
	}, -- undead
};  -- end EnemyOptionsTable

EnemyTable = {
	demon =
	{
		sheet = graphics.newImageSheet( "images/Characters/Demon0.png", 
			EnemyOptionsTable.demon.options ),
	}, -- demon
	pest =
	{
		sheet = graphics.newImageSheet( "images/Characters/Pest0.png", 
			EnemyOptionsTable.pest.options ),
	}, -- pest
	undead =
	{
		sheet = graphics.newImageSheet( "images/Characters/Undead0.png", 
			EnemyOptionsTable.undead.options ),
	}, -- undead
};  -- end EnemyTable




return EnemyTable;