local gridProp = require "src.core.gridProp"
local serpent  = require "libs.serpent"

local function save(grid)
    local f_check = io.open("check.lua", "w")
    if f_check then
        f_check:write("return ")
        f_check:write(serpent.block(gridProp))
        f_check:close()
    end

    local f_save = io.open("map.lua", "w")
    if f_save then
        f_save:write("return ")
        f_save:write(serpent.line(grid))
        f_save:close()
    end
end

return save
