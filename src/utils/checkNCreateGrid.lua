local gridProp   = require "src.core.gridProp"
local tableEqual = require "src.utils.tableEqual"
local clear      = require "src.utils.clear"

local ok, mod

ok, mod = pcall(require, "check")
local check = ok and mod or {}

ok, mod = pcall(require, "map")
local map = ok and mod or {}

local grid = {}
local function checkNCreateGrid()
    if not tableEqual(check, gridProp) or #map == 0 then
        for i = 1, gridProp.gridGroupX do
            grid[i] = {}
            for j = 1, gridProp.gridGroupY do
                grid[i][j] = {}
                clear(grid[i][j])
            end
        end
        return grid
    end
    return map
end

return checkNCreateGrid
