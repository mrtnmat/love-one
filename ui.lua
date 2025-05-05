local EventBusModule = require("eventBus")
local eventBus = EventBusModule.getInstance()

local Utils = require("utils")

local Logger = require("logger")

local log = Logger.getInstance()

love.graphics.setDefaultFilter("nearest", "nearest")

local logFont = love.graphics.newFont("fonts/cour.ttf", 24)
love.graphics.setFont(logFont)

local function drawLogLine(n, text)
    local x = 10
    local y = 40
    love.graphics.print(text, x, y * n)
end

local UI = {
    displayLog = function()
        local entriesToPrint = Utils.lastUpToN(log.logs, 10)
        for i = 1, #entriesToPrint, 1 do
            love.graphics.setColor(1, 1, 1)
            drawLogLine(i, entriesToPrint[i])
        end
    end
}

function love.draw()
    UI.displayLog()
end

return UI
