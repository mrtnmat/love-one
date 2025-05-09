local Camera = require('camera')
local Utils = require('utils')
local Const = require('const')

local function linearize(t)
    local linearized = {}
    for index, value in ipairs(t) do
        table.insert(linearized, value[1])
        table.insert(linearized, value[2])
    end
    return linearized
end

local function polygonVertices(sides, radius, rotation, linear)
    local rot = rotation
    if (rotation == nil) then
        rot = 0
    end
    local theta = 360 / sides
    local vertices = {}
    for i = 0, sides - 1, 1 do
        table.insert(vertices, {
            x = radius * math.cos(Utils.toRadians(rot + (theta * i))),
            y = radius * math.sin(Utils.toRadians(rot + (theta * i))),
        })
    end

    if (linear == true) then
        return linearize(vertices)
    else
        return vertices
    end
end

local function starVertices(radius)
    local relativeRot = 36
    local absoluteRot = -90
    local outerVertices = polygonVertices(5, radius, absoluteRot)
    -- local innerVertices = polygonVertices(5, radius * (1 / PHI), absoluteRot + relativeRot)
    local innerVertices = polygonVertices(5, radius * Const.PHI, absoluteRot + relativeRot)

    local ret = {}
    for index, value in ipairs(outerVertices) do
        table.insert(ret, { value.x, value.y })
        table.insert(ret, { innerVertices[index].x, innerVertices[index].y })
    end
    assert(#ret == 10, "return array length wrong: " .. #ret)
    -- assert(false, string.format("starVertices nil element: %d %d", ret[10].x, ret[10].y))
    return ret
end

local function star()
    local function shiftToZero(numberList)
        local min = math.min(unpack(numberList))
        local ret = {}
        for i = 1, #numberList do
            table.insert(ret, numberList[i] - min)
        end
        return ret
    end

    local function translatePolygon(vertices, x, y)
        local ret = {}
        for i = 1, #vertices do
            local shift = nil
            if (i % 2 == 0) then
                shift = y
            else
                shift = x
            end
            table.insert(ret, vertices[i] + shift)
        end
        return ret
    end
    -- local vertices  = { 100, 100, 200, 100, 200, 200, 300, 200, 300, 300, 100, 300 } -- Concave "L" shape.
    -- local vertices  = { 100,0 , 150,50 , 200,50 , 100,100 , 0,50 , 50,50 , 100,0} -- Concave "L" shape.


    local vertices = starVertices(100)
    local linearized = linearize(vertices)
    local shifted = shiftToZero(linearized)

    -- love.graphics.setColor(1, 1, 1)
    -- love.graphics.printf(table.concat(shifted, "\n"), 0, 100, love.graphics.getWidth() - 20)

    local translated = translatePolygon(shifted, -Camera.x + 200, -Camera.y + 200)
    local triangles = love.math.triangulate(translated)

    local colors = {
        --[[         Utils.createColor(1, 0, 0),
        Utils.createColor(1, 0.3, 0.3),
        Utils.createColor(1, 0.6, 0.6),
        Utils.createColor(1, 0.9, 0.9), ]]
        Utils.createColor(0, 0, 0),
        Utils.createColor(0, 0.3, 0.3),
        Utils.createColor(0, 0.6, 0.6),
        Utils.createColor(0, 0.9, 0.9),
        --[[         Utils.createColor(1, 0, 1),
        Utils.createColor(1, 1, 0),
        Utils.createColor(0, 0, 0),
        Utils.createColor(0, 0, 1),
        Utils.createColor(0, 1, 0), ]]
    }

    for i, triangle in ipairs(triangles) do
        love.graphics.setColor(colors[i % #colors + 1])
        love.graphics.polygon("fill", triangle)
    end
end

return star
