---------------
--File: main.lua
--
--Description:
--  Entry point for the application
---------------

local map = require("map")

--Examples (these can be used to create each separate level)--

--Make a default room with doors
mapArray = makeRoom(true, true, true, true)

print(mapArray[0][0].x)
print(mapArray[0][0].passable)

--Swap out a tile with a different one
mapArray[10][4] = swapTile(mapArray, "door", 1, 10, 4, false)

print(mapArray[10][4].x)
print(mapArray[10][4].passable)

--Place an object on top of a tile. Can specify if passable or pushable
pot = placeObject(mapArray, "decor", 2, 3, 2, false, true)

--Place the player character and generate arrows around him if possible
player = placePlayer(mapArray, "player", 1, 6, 6, false, false)

print("Pot is at " .. pot.x .. "," .. pot.y)
print(pot.passable)
print(pot.pushable)

--List to swap out tile
creatorList = 
{
	--type, frameNum, x, y, passable
	[1] = {"tile", 2, 3, 4, true},
	[2] = {"tile", 2, 5, 5, true},
}

--Swap out any of the default tiles with custom ones
mapArray = buildMap(mapArray, creatorList)

--List to add objects
objectList = 
{
	--type, frameNum, x, y, passable, pushable
	[1] = {"decor", 2, 3, 4, false, true},
	[2] = {"trap", 1, 10, 6, true, false}

}

--Fill the map will objects on the tiles
mapArray = fillMap(mapArray, objectList)