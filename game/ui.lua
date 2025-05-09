local EventBusModule = require("eventBus")
local eventBus = EventBusModule.getInstance()

local Utils = require("utils")
local Proto1 = require("proto1")

local Logger = require("logger")

local log = Logger.getInstance()

love.graphics.setDefaultFilter("nearest", "nearest")

local logFont = love.graphics.newFont("fonts/cour.ttf", 24)
love.graphics.setFont(logFont)

local state = {
    player = {
        x = 0,
        y = 0,
    },
}

local tileSize = 105

local tileTypes = {
    sea = {
        red = 0,
        green = 0,
        blue = 1,
    },
    grass = {
        red = 0,
        green = 1,
        blue = 0,
    },
}

local function getTileType(x, y)
    local types = {'sea', 'grass'}
    local roll = math.floor(math.random(#types) + 0.5)
    return tileTypes[types[roll]]
end

local function drawTile(x, y, tileType)
    -- set color
    love.graphics.setColor( tileType.red, tileType.green, tileType.blue)
    local mode = "fill"
    love.graphics.rectangle(mode, x, y, tileSize, tileSize)
end

local function drawTileMap()
    local screenSizeInTiles = {
        x = math.ceil(love.graphics.getWidth() / tileSize),
        y = math.ceil(love.graphics.getHeight() / tileSize),
    }

    -- main rendering loop
    for y = 0, screenSizeInTiles.y do
        for x = 0, screenSizeInTiles.x do
            local tileType = getTileType(x, y)
            drawTile(x * tileSize, y * tileSize, tileType)
        end
    end
end

local UI = {
    displayLog = function()
        local entriesToPrint = Utils.lastUpToN(log.logs, 10)
        local x = 10
        local y = 40
        local limit = 400
        love.graphics.printf(table.concat(entriesToPrint, '\n'), x, y, 400)
    end
}


return UI
