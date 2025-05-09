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

local meshDraw = function()
end

self.meshDraw = meshDraw

return self
