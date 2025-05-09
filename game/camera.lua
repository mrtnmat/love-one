-- local Const = require('const')

local camera = {
    x = 0,
    y = 0,
    speed = 2,
}

camera.move = function (dt)
    if love.keyboard.isDown("right") then
        camera.x = camera.x + camera.speed
    end
    if love.keyboard.isDown("left") then
        camera.x = camera.x - camera.speed
    end
    if love.keyboard.isDown("up") then
        camera.y = camera.y - camera.speed
    end
    if love.keyboard.isDown("down") then
        camera.y = camera.y + camera.speed
    end
end

return camera