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

local function meshDraw()
    love.graphics.setColor(0,0,0)
    love.graphics.printf(
        string.format(
            "camera y: %d",
            proto.camera().y
        ),
        0, 200, 400)
    love.graphics.draw(mesh, 200, proto.camera().y)
end

self.meshDraw = meshDraw

return self
