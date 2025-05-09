

    -- dtCopy = dt + dtCopy
function love.keypressed(key, scancode, isrepeat)
    --[[     if key == "right" then
        cameraX = cameraX + Camera.speed
    elseif key == "left" then
        cameraX = cameraX - Camera.speed
    elseif key == "up" then
        Camera.y = Camera.y - Camera.speed
    elseif key == "down" then
        Camera.y = Camera.y + Camera.speed
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
