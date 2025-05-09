Proto1 = {}
local instance = nil

local PHI = (1 + (5 ^ 1 / 2)) / 2
local radiusRatio = PHI / 4

Proto1.getInstance = function()
    if instance == nil then
        instance = Proto1.new()
    end
    return instance
end

local function createColor(r, g, b)
    return {
        r,
        g,
        b,
        1,
    }
end

local colors = {
    white = createColor(1, 1, 1),
    red = createColor(1, 0, 0),
    green = createColor(0, 1, 0),
    blue = createColor(0, 0, 1),
    black = createColor(0, 0, 0),
}

local camera = {
    x = 0,
    y = 0,
    speed = PHI * 2,
}
local cameraSpeed = PHI * 2
local tileSize = 40
local dtCopy = 0
local relativeRotation = 36

local function getTileColor(x, y)
    if x % 2 == y % 2 then
        return colors.white
    else
        return colors.black
    end
end


local function moveCamera(dt)
    dtCopy = dt + dtCopy
    if love.keyboard.isDown("right") then
        camera.x = camera.x + cameraSpeed
    end
    if love.keyboard.isDown("left") then
        camera.x = camera.x - cameraSpeed
    end
    if love.keyboard.isDown("up") then
        camera.y = camera.y - cameraSpeed
    end
    if love.keyboard.isDown("down") then
        camera.y = camera.y + cameraSpeed
    end
end

local rotationSpeed = 1

function love.keypressed(key, scancode, isrepeat)
    --[[     if key == "right" then
        cameraX = cameraX + cameraSpeed
    elseif key == "left" then
        cameraX = cameraX - cameraSpeed
    elseif key == "up" then
        camera.y = camera.y - cameraSpeed
    elseif key == "down" then
        camera.y = camera.y + cameraSpeed
    end ]]
    if key == "d" then
        relativeRotation = relativeRotation + rotationSpeed
    end
    if key == "f" then
        relativeRotation = relativeRotation - rotationSpeed
    end

    if key == "r" then
        radiusRatio = math.min(1, radiusRatio + 0.02)
    end
    if key == "e" then
        radiusRatio = math.max(0.1, radiusRatio - 0.02)
    end
end

local function linearize(t)
    local linearized = {}
    for index, value in ipairs(t) do
        table.insert(linearized, value.x)
        table.insert(linearized, value.y)
    end
    return linearized
end

local function toRadians(degrees)
    return degrees * (math.pi / 180)
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
            x = radius * math.cos(toRadians(rot + (theta * i))),
            y = radius * math.sin(toRadians(rot + (theta * i))),
        })
    end

    if (linear == true) then
        return linearize(vertices)
    else
        return vertices
    end
end

local function starVertices(radius)
    local relativeRot = relativeRotation
    local absoluteRot = -90
    local outerVertices = polygonVertices(5, radius, absoluteRot)
    -- local innerVertices = polygonVertices(5, radius * (1 / PHI), absoluteRot + relativeRot)
    local innerVertices = polygonVertices(5, radius * radiusRatio, absoluteRot + relativeRot)

    local ret = {}
    for index, value in ipairs(outerVertices) do
        table.insert(ret, {value.x, value.y})
        table.insert(ret, {innerVertices[index].x, innerVertices[index].y})
    end
    assert(#ret == 10, "return array length wrong: " .. #ret)
    -- assert(false, string.format("starVertices nil element: %d %d", ret[10].x, ret[10].y))
    return ret
end


local function printDebugInfo()
    local cameraInfo = table.concat({
        "Camera Speed:",
        cameraSpeed,
        "Camera X:",
        camera.x,
        "Camera Y:",
        camera.y,
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
    local x = 0 - (camera.x / 2)
    local y = 0 - (camera.y / 2)
    local width = 300
    local height = 300
    love.graphics.setColor(1, 0, 1)
    canvas:renderTo(love.graphics.rectangle, "fill", x, y, width, height)

    x = -200 - (camera.x / 2)
    y = 200 - (camera.y / 2)
    width = 350
    height = 800
    love.graphics.setColor(0, 0, 1)
    canvas:renderTo(love.graphics.rectangle, "fill", x, y, width, height)

    return canvas
end

local function canvasWithEndlessCheckboard()
    local canvas = love.graphics.newCanvas(400, 400)
    local speed = { x = camera.x * 3, y = camera.y * 2 }
    local x = -(speed.x / 2) % (tileSize * 2)
    local y = -(speed.y / 2) % (tileSize * 2)

    local offset = (tileSize * 4)

    for row = 0, 20, 1 do
        for col = 0, 20, 1 do
            if (row + col) % 2 == 0 then
                love.graphics.setColor(1, 1, 1)
            else
                love.graphics.setColor(0, 0, 0)
            end
            canvas:renderTo(love.graphics.rectangle, "fill", x + (tileSize * col) - offset, y + (tileSize * row) - offset,
                tileSize,
                tileSize)
        end
    end

    return canvas
end

local function star()
    local function shiftToZero(numberList)
        local min = math.min(table.unpack(numberList))
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
    local shifted = shiftToZero(linearize(vertices))

    -- love.graphics.setColor(1, 1, 1)
    -- love.graphics.printf(table.concat(shifted, "\n"), 0, 100, love.graphics.getWidth() - 20)

    local translated = translatePolygon(shifted, -camera.x + 200, -camera.y + 200)
    local triangles = love.math.triangulate(translated)

    local colors = {
--[[         createColor(1, 0, 0),
        createColor(1, 0.3, 0.3),
        createColor(1, 0.6, 0.6),
        createColor(1, 0.9, 0.9), ]]
        createColor(0, 0, 0),
        createColor(0, 0.3, 0.3),
        createColor(0, 0.6, 0.6),
        createColor(0, 0.9, 0.9),
--[[         createColor(1, 0, 1),
        createColor(1, 1, 0),
        createColor(0, 0, 0),
        createColor(0, 0, 1),
        createColor(0, 1, 0), ]]
    }

    for i, triangle in ipairs(triangles) do
        love.graphics.setColor(colors[i % #colors + 1])
        love.graphics.polygon("fill", triangle)
    end
end

local function renderMap()
    -- local xSize = love.graphics.getWidth()
    -- local ySize = love.graphics.getHeight()
    -- local minX = cameraX - (xSize / 2)
    -- local minY = camera.y - (ySize / 2)

    -- local canvas = canvasWithParallaxRectangles()
    local canvas = canvasWithEndlessCheckboard()
    love.graphics.setColor(1, 1, 1)
    -- love.graphics.draw(canvas, 0 - cameraX, -200 - camera.y)
    -- star()
end


Proto1.new = function()
    return {
        renderMap = renderMap,
        moveCamera = moveCamera,
        printDebugInfo = printDebugInfo,
        starVertices = starVertices,
        canvasWithEndlessCheckboard = canvasWithEndlessCheckboard,
        camera = camera,
    }
end

return Proto1
