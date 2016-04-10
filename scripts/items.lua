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
	ammo =
	{
		options = {
			frames = {
				{ x =  0, y = 80,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- black dot
			}
		},
	}, -- ammo
	armor =
	{
		options = {
			frames = {
				{ x =  0, y = -1,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- orange armor
				{ x = 48, y = -1,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- green armor
				{ x = 80, y = -1,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- blue armor
				{ x =  0, y = 15,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- black armor
			}
		},
	}, -- armor
	boot =
	{
		options = {
			frames = {
				{ x =  0, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- brown shoe
				{ x = 48, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- green shoe
				{ x = 80, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- brown boot
				{ x = 96, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- gray boot
			}
		},
	}, -- boot
	chest =
	{
		options = {
			frames = {
				{ x =    0, y = -1,    width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- square chest closed
				{ x =    0, y = 47,    width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- square chest open
				{ x = 15.5, y =  0,    width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- round top chest closed
				{ x = 15.5, y = 48,    width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- round top chest open
				{ x =    0, y = 16,    width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- gray barrel closed
				{ x =    0, y = 63.5,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- gray barrel open
				{ x = 15.5, y = 16,    width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- gold barrel closed
				{ x = 15.5, y = 64,    width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- gold barrel open
			}
		},
	}, -- chest
	decor =
	{
		options = {
			frames = {
				{ x =    16, y =    48,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- brown pot
				{ x =    48, y =    48,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- silver pot
				{ x =     0, y =    64,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- empty bookcase
				{ x =    80, y =    64,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- bookcase with books #1
				{ x =    96, y =    64,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- bookcase with books #2
				{ x =     0, y = 111.5,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- brown chair #1
				{ x =    16, y = 111.5,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- brown round table
				{ x =    32, y = 111.5,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- brown chair #2
				{ x =     0, y =   160,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- bar left piece
				{ x =    16, y =   160,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- bar center piece
				{ x =    32, y =   160,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- bar right piece
				{ x =    48, y =   160,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- bar top piece (vertical)
				{ x =    64, y =   160,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- bar center piece (vertical)
				{ x =    80, y =   160,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- bar bottom piece (vertical)
				{ x =    96, y =   175,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- lumber pile
				{ x =     0, y =   192,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- white skull
				{ x =    16, y =   192,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- pile of white bones
				{ x =     0, y =   207,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- white animal skull
				{ x =    16, y =   207,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- white rib cage
				{ x =  -0.5, y =   271,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- RIP tombstone
				{ x =  31.5, y =   271,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- skull tombstone
				{ x =  47.5, y =   271,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- blank tombstone
				{ x =    16, y =   144,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- bed (horizontal)
				{ x =    80, y =    48,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- silver pot with orange stripe
				{ x =    96, y =    48,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- broken pot
				{ x =    48, y = 111.5,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- silver chair #1
				{ x =    64, y = 112.5,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- square silver table
				{ x =    32, y =   128,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- single candle
				{ x =   112, y =    64,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- broken bookcase
				{ x =     0, y =    80,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- blank sign post
				{ x =    16, y =    80,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- written sign post
				{ x =    48, y =    80,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- broken sign post
				{ x =     0, y =    96,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- generic vendor
				{ x =    16, y =    96,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- bread vendor
				{ x =    32, y =    96,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- weapon vendor
				{ x =    80, y =    96,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- potion vendor
				{ x =     0, y =   128,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- white wall candle
				{ x =    16, y =   128,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- white wall candles
				{ x =    64, y =   128,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- black wall candle
				{ x =    80, y =   128,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- black wall candles
				{ x =    64, y =   144,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- sleeping bag (vertical)
				{ x =    80, y =   144,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- sleeping bag (horizontal)
				{ x =  47.1, y =   287.5,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- square tombstone
				{ x =    16, y =   335,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- water fountain
				{ x =  -0.5, y =   303,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- spider web full
				{ x =    16, y =   303,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- spider web top left
				{ x =    32, y =   303,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- spider web top right
				{ x =    48, y =   320,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- statue
			}
		},
	}, -- decor
	door =
	{
		options = {
			frames = {
				{ x =  0, y =   0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, --wood door	
				{ x = 16, y =   0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, --wood locked door
				{ x =  0, y =  16,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, --metal door	
				{ x = 16, y =  16,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, --metal locked door	
				{ x =  0, y =  80,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, --open path
				{ x = 32, y =  64,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, --door lock ONLY
				{ x = 80, y =  80,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, --open sky portal				
			}
		},
	}, -- door
	hat =
	{
		options = {
			frames = {
				{ x = 32, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- silver helmet w/ red feather
				{ x = 64, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- silver helmet w/ gold buzz
				{ x = 80, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- helmet closed faceplate
				{ x = 32, y = 16,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- skyrim helmet
			}
		},
	}, -- hat
	key =
	{
		options = {
			frames = {
				{ x =  0, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- silver key	
				{ x = 15, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- gray key
			}
		},
	}, -- key
	light =
	{
		options = {
			frames = {
				{ x =  32, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- candlelight	
				{ x =  48, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- lantern	
			}
		},
	}, -- light
	ore =
	{
		options = {
			frames = {
				{ x =  80, y =  32,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- blue ore	
			}
		},
	}, -- ore
	potion =
	{
		options = {
			frames = {
				{ x =    0, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- red 
				{ x = 15.5, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- pink 
				{ x =   31, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- orange 
				{ x =   47, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- yellow 
				{ x =   80, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- dark green 
				{ x =    0, y = 16,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- purple 
				{ x =    0, y = 32,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- gray 
			}
		},
	}, -- potion
	scroll =
	{
		options = {
			frames = {
				{ x =    0, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- white scroll 
				{ x =   16, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- gray scroll 
				{ x =   31, y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- brown scroll 
			}
		},
	}, -- scroll
	shield =
	{
		options = {
			frames = {
				{ x =    0, y = 0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- bronze
				{ x = 15.5, y = 0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- green with yellow outline
				{ x = 31.5, y = 0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- brown with yellow symbol
				{ x = 47.5, y = 0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- silver with small image
				{ x =   80, y = 0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- round bronze
				{ x = 95.5, y = 0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- blue
			}
		},
	}, -- shield
	trap =
	{
		options = {
			frames = {
				{ x =  0, y = 48,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- spear trap
				{ x = 47, y = 48,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- spikes
				{ x = 64, y = 32,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- round pit
				{ x = 80, y = 32,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- square pit
			}
		},
	}, -- trap
	weapon=
	{
		options = {
			frames = {
				{ x =  0, y = -1,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- sword #1
				{ x = 16, y = -1,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- sword #2
				{ x = 48, y = -1,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- sword #3
				{ x = 64, y = -1,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- sword #4
				{ x =  0, y = 16,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- single-sided axe
				{ x = 16, y = 16,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- single-sided axe
			}
		},
	}, -- weapon
	weaponLng=
	{
		options = {
			frames = {
				{ x = 96,  y =  0,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- trident
				{ x = 32,  y = 16,  width = IMAGE_WIDTH, height = IMAGE_HEIGHT}, -- long sword
			}
		},
	}, -- weaponLng

};  -- end ItemOptionsTable

ItemsTable = {
	ammo =
	{
		sheet = graphics.newImageSheet( "images/Items/Ammo.png", 
			ItemOptionsTable.ammo.options ),
	}, -- ammo
	armor =
	{
		sheet = graphics.newImageSheet( "images/Items/Armor.png", 
			ItemOptionsTable.armor.options ),
	}, -- armor
	boot =
	{
		sheet = graphics.newImageSheet( "images/Items/Boot.png", 
			ItemOptionsTable.boot.options ),
	}, -- boot
	chest =
	{
		sheet = graphics.newImageSheet( "images/Items/ChestCombined.png", 
			ItemOptionsTable.chest.options ),
	}, -- chest
	decor =
	{
		sheet = graphics.newImageSheet( "images/Objects/Decor0.png", 
			ItemOptionsTable.decor.options ),
	}, -- decor
	door =
	{
		sheet = graphics.newImageSheet( "images/Objects/Door0.png", 
			ItemOptionsTable.door.options ),
	}, -- door
	hat =
	{
		sheet = graphics.newImageSheet( "images/Items/Hat.png", 
			ItemOptionsTable.hat.options ),
	}, -- hat
	key =
	{
		sheet = graphics.newImageSheet( "images/Items/Key.png", 
			ItemOptionsTable.key.options ),
	}, -- key
	light =
	{
		sheet = graphics.newImageSheet( "images/Items/Light.png", 
			ItemOptionsTable.light.options ),
	}, -- light
	ore =
	{
		sheet = graphics.newImageSheet( "images/Objects/Ore0.png", 
			ItemOptionsTable.ore.options ),
	}, -- light
	potion =
	{
		sheet = graphics.newImageSheet( "images/Items/Potion.png", 
			ItemOptionsTable.potion.options ),
	}, -- potion
	scroll =
	{
		sheet = graphics.newImageSheet( "images/Items/Scroll.png", 
			ItemOptionsTable.scroll.options ),
	}, -- scroll
	shield =
	{
		sheet = graphics.newImageSheet( "images/Items/Shield.png", 
			ItemOptionsTable.shield.options ),
	}, -- shield
	trap =
	{
		sheet = graphics.newImageSheet( "images/Objects/Trap0.png", 
			ItemOptionsTable.trap.options ),
	}, -- trap
	weapon =
	{
		sheet = graphics.newImageSheet( "images/Items/MedWep.png", 
			ItemOptionsTable.weapon.options ),
	}, -- weapon
	weaponLng =
	{
		sheet = graphics.newImageSheet( "images/Items/LongWep.png", 
			ItemOptionsTable.weaponLng.options ),
	}, -- weaponLng

};  -- end ItemsTable




return ItemsTable;