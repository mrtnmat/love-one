Proto1 = {}
local instance = nil

Proto1.getInstance = function()
    if instance == nil then
        instance = Proto1.new()
    end
    return instance
end

local entities = {
    {
        x = 100,
        y = 20,
        width = 70,
        height = 90,
    },
    {
        x = 300,
        y = 10,
        width = 100,
        height = 150,
    },
    {
        x = 10,
        y = 90,
        width = 40,
        height = 40,
    },
    {
        x = -100,
        y = 500,
        width = 40,
        height = 2000,
    },
}



local cameraX = 0
local cameraY = 0
local cameraSpeed = 2
local tileSize = 20

local colors = {
    white = { r = 0, g = 0, b = 0 },
    black = { r = 1, g = 1, b = 1 },
}

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

local function renderMap()
    -- local xSize = love.graphics.getWidth()
    -- local ySize = love.graphics.getHeight()
    -- local minX = cameraX - (xSize / 2)
    -- local minY = cameraY - (ySize / 2)
    for index, rectangle in ipairs(entities) do
        local x = rectangle.x + cameraX
        local y = rectangle.y + cameraY
        love.graphics.rectangle("fill", x, y, rectangle.width, rectangle.height)
    end
end

Proto1.new = function()
    return {
        renderMap = renderMap,
        moveCamera = moveCamera,
    }
end

return Proto1
