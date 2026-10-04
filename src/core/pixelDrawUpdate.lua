local gridProp = require "src.core.gridProp"
local prevX, prevY

local function pixelDrawUpdate(current_grid, color, radius)
    local pointX = math.floor(M.mouse.getX() / gridProp.width) + 1
    local pointY = math.floor(M.mouse.getY() / gridProp.height) + 1

    if prevX ~= nil and prevY ~= nil then
        if M.mouse.isDown(1) then

            local dx = pointX - prevX
            local dy = pointY - prevY
            local dist = math.sqrt(dx*dx + dy*dy)
            local step = math.ceil(dist)

            for k = 0, step do
                local t = k / step
                local curX = prevX + (pointX - prevX) * t
                local curY = prevY + (pointY - prevY) * t

                for i = math.floor(curX - radius + 1), math.floor(curX + radius) do
                    for j = math.floor(curY - radius + 1), math.floor(curY + radius) do
                        if current_grid[i] ~= nil then
                            current_grid[i][j] = color
                        end
                    end
                end
            end
        end
    end

    prevX = pointX
    prevY = pointY

end

return pixelDrawUpdate
