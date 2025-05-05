local EventBus = {}

-- Tracks if it has been instanced already
local instance = nil

-- Private constructor
local function new()
    local self = {}

    --emit event method
    function self.emit(eventname, payload)
    end

    --register to even method
    function self.on(event, callback)
    end

    return self
end

-- Public method to get the singleton instance
function EventBus.getInstance()
    if instance == nil then
        instance = new()
    end
    return instance
end

-- Return the module
return EventBus