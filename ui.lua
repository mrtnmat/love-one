local EventBusModule = require("eventBus")
local eventBus = EventBusModule.getInstance()

local Utils = require("utils")

local log = { "line1", "line2", "line3", "HELLO", "test", "long string is good for testing", "2 + 2 = pizza",
    "cantwritenomore", "                 space               .", "HIDDEN ENTRY" }

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
        local entriesToPrint = Utils.lastUpToN(log, 10)
        for i = 1, #entriesToPrint, 1 do
            love.graphics.setColor(1, 1, 1)
            drawLogLine(i, entriesToPrint[i])
        end
    end
}

function love.draw()
    UI.displayLog()
    table.remove(log)
    table.insert(log, "NEW ENTRY")
    UI.displayLog()
end

return UI
