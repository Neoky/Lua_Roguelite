---------------
--File: enemy.lua
--
--Description:
--  This file holds the image sheets for the enemies
---------------

local EnemySheetTable = {};

local EnemyOptionsTable = {
	demon =
	{
		options = {
			frames = {
				{ x = 1.5, y = 2.5, width = 11, height = 14 }, -- green dragon
				{ x = 2, y = 18, width = 11, height = 13 }, -- red demon
			}
		},
	}, -- demon
	pest =
	{
		options = {
			frames = {
				{ x = 83, y = 17, width = 11, height = 14 }, -- fly
				{ x = 48, y = 33, width = 15, height = 13 }, -- scorpion
				{ x = 48, y = 65, width = 15, height = 13 }, -- ant
				{ x = 0, y = 145, width = 15, height = 13 }, -- spider
			}
		},
	}, -- pest
	undead =
	{
		options = {
			frames = {
				{ x = 83, y = 17, width = 11, height = 14 }, -- mummy
				{ x = 2.7, y = 33, width = 11, height = 14 }, -- white skeleton
				{ x = 34.7, y = 33, width = 11, height = 14 }, -- green skeleton
				{ x = 32, y = 64, width = 15, height = 14 }, -- white ghost
				{ x = 0, y = 97, width = 15, height = 14 }, -- dementor
			}
		},
	}, -- undead
};  -- end EnemyOptionsTable

EnemySheetTable = {
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
};  -- end EnemySheetTable




return EnemySheetTable;