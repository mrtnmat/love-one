local Proto1 = require("proto1")
local proto = Proto1.getInstance()

local self = {}

local function a()
    local star = proto.starVertices(200)
    local checkboard = proto.canvasWithEndlessCheckboard()
    local m = love.graphics.newMesh(star)
    m:setTexture(checkboard)
    return m
end

local mesh = a()

local y = 100

-- MODULE TEST

local singl1 = require('singl1')
local singl2 = require('singl2')

-- MODULE TEST

local function meshDraw()
--[[     love.graphics.setColor(0,0,0)
    love.graphics.printf(
        string.format(
            "camera y: %d",
            proto.camera.y
        ),
        0, 200, 400)
    love.graphics.draw(mesh, 200, proto.camera.y) ]]
    love.graphics.printf(
        string.format(
            singl1.state.counter
        ),
        0, 200, 400)
    singl1.increment()

    singl2.increment()
    love.graphics.printf(
        string.format(
            singl2.readValue()
        ),
        0, 400, 400)
end

self.meshDraw = meshDraw

return self
