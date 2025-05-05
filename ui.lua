local EventBusModule = require("eventBus")
local eventBus = EventBusModule.getInstance()

local Utils = require("utils")

local Logger = require("logger")

local log = Logger.getInstance()

love.graphics.setDefaultFilter("nearest", "nearest")

local logFont = love.graphics.newFont("fonts/cour.ttf", 24)
love.graphics.setFont(logFont)

local UI = {
    displayLog = function()
        local entriesToPrint = Utils.lastUpToN(log.logs, 10)
        local x = 10
        local y = 40
        local limit = 400
        love.graphics.printf(table.concat(entriesToPrint, '\n'), x, y, 400)
    end
}

function love.draw()
    UI.displayLog()
end

return UI
