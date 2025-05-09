local self = {}

local Constants = require('const')
local Camera = require('camera')
local Utils = require('utils')
local EndlessCheckboard = require('renderables.endlessCheckboard')
local Star = require('renderables.star')

local radiusRatio = Constants.PHI / 4

local colors = {
    white = Utils.createColor(1, 1, 1),
    red = Utils.createColor(1, 0, 0),
    green = Utils.createColor(0, 1, 0),
    blue = Utils.createColor(0, 0, 1),
    black = Utils.createColor(0, 0, 0),
}

local relativeRotation = 36

local function printDebugInfo()
    local cameraInfo = table.concat({
        "Camera Speed:",
        Camera.speed,
        "Camera X:",
        Camera.x,
        "Camera Y:",
        Camera.y,
        "relativeRotation:",
        relativeRotation,
        "radiusRatio:",
        radiusRatio,
    }, " ")
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(cameraInfo, 0, 0, love.graphics.getWidth() - 20)
end

local function canvasWithParallaxRectangles()
    local canvas = love.graphics.newCanvas(400, 400)
    local x = 0 - (Camera.x / 2)
    local y = 0 - (Camera.y / 2)
    local width = 300
    local height = 300
    love.graphics.setColor(1, 0, 1)
    canvas:renderTo(love.graphics.rectangle, "fill", x, y, width, height)

    x = -200 - (Camera.x / 2)
    y = 200 - (Camera.y / 2)
    width = 350
    height = 800
    love.graphics.setColor(0, 0, 1)
    canvas:renderTo(love.graphics.rectangle, "fill", x, y, width, height)

    return canvas
end

local function renderMap()
    -- local xSize = love.graphics.getWidth()
    -- local ySize = love.graphics.getHeight()
    -- local minX = cameraX - (xSize / 2)
    -- local minY = Camera.y - (ySize / 2)

    -- local canvas = canvasWithParallaxRectangles()
    EndlessCheckboard(-200, 1000)
    Star()
end


self =
{
    renderMap = renderMap,
    printDebugInfo = printDebugInfo,
}

return self
