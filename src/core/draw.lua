local gridProp = require "src.core.gridProp"
local enum     = require "src.enum"

local function draw(current_grid)
    for i = 1, gridProp.countX do
        for j = 1, gridProp.countY do
            local value = current_grid[i][j]
            if value ~= 0 then

                if     value == enum.BLACK  then M.graphics.setColor(0.4, 0.4, 0.4, 0.3)
                elseif value == enum.RED    then M.graphics.setColor(0, 1, 1, 0.3)
                elseif value == enum.YELLOW then M.graphics.setColor(0, 0, 1, 0.3)
                elseif value == enum.GREEN  then M.graphics.setColor(0, 1, 0, 0.3)
                end

                M.graphics.rectangle(
                    "fill",
                    (i-1)*gridProp.width,
                    (j-1)*gridProp.height,
                    gridProp.width,
                    gridProp.height
                )
            end
        end
    end
end

return draw
