local gridProp = require "src.core.gridProp"

local function clear(map)
    for i = 1, gridProp.countX do
        map[i] = {}
        for j = 1, gridProp.countY do
            map[i][j] = 0
        end
    end
end

return clear
