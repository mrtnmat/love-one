local EventBus = {}

-- Tracks if it has been instanced already
local instance = nil

local subscriptions = {}

-- Private constructor
local function new()
    local self = {}

    --emit event method
    function self.emit(eventName, ...)
        local subs = subscriptions[eventName]
        if subs then
            for _, sub in ipairs(subs) do
                sub.callback(...)
            end
        end
    end

    --register to event method
    function self.on(eventName, component, callback)
        assert(type(eventName) == "string", "Event name must be a string")
        assert(callback ~= nil, "Callback cannot be nil")
        assert(type(callback) == "function", "Callback must be a function")

        if not subscriptions[eventName] then
            subscriptions[eventName] = {}
        end

        -- Add the subscription
        table.insert(
            subscriptions[eventName],
            {
                component = component,
                callback = callback,
            }
        )

        -- Optionally return a token/handle for individual unsubscription
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
