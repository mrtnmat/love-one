Proto1 = {}
local instance = nil

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

local entities = {
    {
        x = 100,
        y = 20,
        width = 70,
        height = 90,
        color = colors.green,
        mode = "fill",
    },
    {
        x = 300,
        y = 10,
        width = 100,
        height = 150,
        color = colors.blue,
        mode = "fill",
    },
    {
        x = 10,
        y = 90,
        width = 40,
        height = 40,
        color = colors.red,
        mode = "fill",
    },
    {
        x = -100,
        y = 500,
        width = 40,
        height = 2000,
        color = colors.black,
        mode = "fill",
    },
    {
        x = -0,
        y = -200,
        width = 400,
        height = 400,
        color = colors.white,
        mode = "line",
    },
}



local cameraX = 0
local cameraY = 0
local cameraSpeed = 2
local tileSize = 40

local function getTileColor(x, y)
    if x % 2 == y % 2 then
        return colors.white
    else
        return colors.black
    end
end


local function moveCamera()
    if love.keyboard.isDown("right") then
        cameraX = cameraX + cameraSpeed
    end
    if love.keyboard.isDown("left") then
        cameraX = cameraX - cameraSpeed
    end
    if love.keyboard.isDown("up") then
        cameraY = cameraY - cameraSpeed
    end
    if love.keyboard.isDown("down") then
        cameraY = cameraY + cameraSpeed
    end
end

function love.keypressed(key, scancode, isrepeat)
    --[[     if key == "right" then
        cameraX = cameraX + cameraSpeed
    elseif key == "left" then
        cameraX = cameraX - cameraSpeed
    elseif key == "up" then
        cameraY = cameraY - cameraSpeed
    elseif key == "down" then
        cameraY = cameraY + cameraSpeed
    end ]]
end

local function printDebugInfo()
    local cameraInfo = table.concat({
        "Camera Speed:",
        cameraSpeed,
        "Camera X:",
        cameraX,
        "Camera Y:",
        cameraY,
    }, " ")
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(cameraInfo, 0, 0, love.graphics.getWidth() - 20)
end

local function canvasWithParallaxRectangles()
    local canvas = love.graphics.newCanvas(400, 400)
    local x = 0 - (cameraX / 2)
    local y = 0 - (cameraY / 2)
    local width = 300
    local height = 300
    love.graphics.setColor(1, 0, 1)
    canvas:renderTo(love.graphics.rectangle, "fill", x, y, width, height)

    x = -200 - (cameraX / 2)
    y = 200 - (cameraY / 2)
    width = 350
    height = 800
    love.graphics.setColor(0, 0, 1)
    canvas:renderTo(love.graphics.rectangle, "fill", x, y, width, height)

    return canvas
end

local function canvasWithEndlessCheckboard()
    local canvas = love.graphics.newCanvas(400, 400)
    local speed = {x = cameraX * 3, y = cameraY * 2}
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
            canvas:renderTo(love.graphics.rectangle, "fill", x + (tileSize * col) - offset, y + (tileSize * row) -offset, tileSize,
                tileSize)
        end
    end

    return canvas
end

local function renderMap()
    -- local xSize = love.graphics.getWidth()
    -- local ySize = love.graphics.getHeight()
    -- local minX = cameraX - (xSize / 2)
    -- local minY = cameraY - (ySize / 2)

    -- local canvas = canvasWithParallaxRectangles()
    local canvas = canvasWithEndlessCheckboard()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(canvas, 0 - cameraX, -200 - cameraY)
    for index, rectangle in ipairs(entities) do
        love.graphics.setColor(rectangle.color)
        local x = rectangle.x - cameraX
        local y = rectangle.y - cameraY
        love.graphics.rectangle(rectangle.mode, x, y, rectangle.width, rectangle.height)
    end
end


Proto1.new = function()
    return {
        renderMap = renderMap,
        moveCamera = moveCamera,
        printDebugInfo = printDebugInfo,
    }
end

return Proto1
