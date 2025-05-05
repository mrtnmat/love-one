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

    self.logs = {}

    function self.push(logEntry)
        self.log.push(logEntry)
        eventBus.emit(Events.newLogEntry)
    end

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