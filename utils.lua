local Utils = {
    lastUpToN = function (list, n)
        local result = {}
        local count = #list
        local start = math.max(0, count - n) + 1

        for i = start, count do
            table.insert(result, list[i])
        end

        return result
    end
}

return Utils