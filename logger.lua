local Logger = {}

-- Import singleton event bus
local EventBusModule = require("eventBus")
local eventBus = EventBusModule.getInstance()

-- Import event names
local Events = require("eventNames")

-- Tracks logger singleton instance
local instance = nil

-- Private constructor
local function new()
    local self = {}

    self.logs = {"TEST LOG"}

    local function push(logEntry)
        table.insert(self.logs, logEntry)
        eventBus.emit(Events.newLogEntry)
    end

    eventBus.on(Events.gameStart, function () push("Game Start!") end)

    return self
end


-- Public method to get the singleton instance
function Logger.getInstance()
    if instance == nil then
        instance = new()
    end
    return instance
end

return Logger