local Utils = {
    lastUpToN = function(list, n)
        local result = {}
        local count = #list
        local start = math.max(0, count - n) + 1

        for i = start, count do
            table.insert(result, list[i])
        end

        return result
    end,
    createColor = function(r, g, b)
        return {
            r,
            g,
            b,
            1,
        }
    end,
    toRadians = function(degrees)
        return degrees * (math.pi / 180)
    end,
}

return Utils
