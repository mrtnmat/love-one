local Camera = require('camera')

return function(x, y)
    local tileSize = 40
    local canvas = love.graphics.newCanvas(400, 400)
    local speed = { x = Camera.x * 3, y = Camera.y * 2 }
    local originX = -(speed.x / 2) % (tileSize * 2)
    local originY = -(speed.y / 2) % (tileSize * 2)

    local offset = (tileSize * 4)

    for row = 0, 20, 1 do
        for col = 0, 20, 1 do
            if (row + col) % 2 == 0 then
                love.graphics.setColor(1, 1, 1)
            else
                love.graphics.setColor(0, 0, 0)
            end
            canvas:renderTo(love.graphics.rectangle, "fill", originX + (tileSize * col) - offset,
                originY + (tileSize * row) - offset,
                tileSize,
                tileSize)
        end
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(canvas, x - Camera.x, y - Camera.y)
end
