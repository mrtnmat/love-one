require("ui")
local EventBusModule = require("eventBus")
local eventBus = EventBusModule.getInstance()

local events = require("eventNames")

local meshproto = require("meshproto")

-- Initialize position and speed
local x = 400
local y = 300
local speed = 200
local time = 0
local rotation = 0
local size = 100

function love.load()
    -- Set the window title
    love.window.setTitle("Dancing rectangle")

    -- Set background color to a dark gray
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)

    love.keyboard.setKeyRepeat( true )

    eventBus.emit(events.gameStart)
end

local function animation(dt)
    time = time + dt

    if time > 0 then
        -- Spin in place
        rotation = rotation + dt * 1.5
        size = 100 + math.sin(time * 5) * 20
    else
        time = 0
    end
end

local function moveInfo()
    -- Display info about the current dance move
    love.graphics.setColor(1, 1, 1)
    local moveNames = {
        "Spin Move", "Circle Dance", "Pulse Wobble",
        "Figure Eight", "Bounce Spin"
    }
    local currentMove = math.min(math.floor(time / 2) + 1, 5)
    -- love.graphics.print("Dance Move: " .. moveNames[currentMove], 10, 10)
    -- love.graphics.print("Press Space to restart choreography", 10, 30)
    love.graphics.print("Size: " .. size, 10, 10)
    love.graphics.print("Rotation: " .. math.deg(rotation) % 360 .. " degrees", 10, 30)
end

local Proto1 = require('Proto1')
local proto = Proto1.getInstance()

function love.update(dt)
    -- playerControls(dt)
    -- animation(dt)
--[[     if proto == nil then
        love.graphics.printf("error", 10, 10)
    elseif
        proto.moveCamera(dt)
    then
    end ]]

    proto.moveCamera(dt)
end

function love.draw()
    -- UI.displayLog()
    -- drawTileMap()
    -- proto.renderMap()
    -- proto.printDebugInfo()
    meshproto.meshDraw()
end

function love.drawOLD()
    -- Save the current transform
    love.graphics.push()

    -- Move to the rectangle's position
    love.graphics.translate(x, y)

    -- Apply rotation around the center
    love.graphics.rotate(rotation)

    -- Draw the colored rectangle centered at the origin
    love.graphics.setColor(1, 0.2, 0.2)
    love.graphics.rectangle("fill", -size / 2, -size / 2, size, size)

    -- Add a white outline
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", -size / 2, -size / 2, size, size)

    -- Restore the transform
    love.graphics.pop()

    moveInfo()
end
