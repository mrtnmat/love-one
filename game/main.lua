require('debugAdapter')
require('ui')

local Camera = require('camera')
local Proto = require('proto1')

function love.load()
    -- Set the window title
    love.window.setTitle('Dancing rectangle')

    -- Set background color to a dark gray
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)

    love.keyboard.setKeyRepeat(true)
end

function love.update(dt)
    Camera.move(dt)
end

function love.draw()
    -- UI.displayLog()
    -- drawTileMap()
    Proto.renderMap()
    Proto.printDebugInfo()
    -- meshproto.meshDraw()
end
