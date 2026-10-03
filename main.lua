_G.M = love

local grid     = {}
local gridProp = {}
function love.load()
    gridProp.width  = 1
    gridProp.height = 1
    gridProp.countX = math.floor(M.graphics.getWidth() / gridProp.width)
    gridProp.countY = math.floor(M.graphics.getHeight() / gridProp.height)

    for i = 1, gridProp.countX do
        grid[i] = {}
        for j = 1, gridProp.countY do
            grid[i][j] = 0
        end
    end
end

local color = 0
local radius = 0
function love.update(dt)
    if     M.keyboard.isDown("w") then color = 1
    elseif M.keyboard.isDown("r") then color = 2
    elseif M.keyboard.isDown("y") then color = 3
    elseif M.keyboard.isDown("c") then color = 0 end

    if M.keyboard.isDown("p") then radius = radius + 1 * dt * 5
    elseif M.keyboard.isDown("m") then radius = radius - 1 * dt * 5 end

    local pointX = math.floor(M.mouse.getX() / gridProp.width) + 1
    local pointY = math.floor(M.mouse.getY() / gridProp.height) + 1
    if M.mouse.isDown(1) then
        for i = math.floor(pointX - radius + 1), math.floor(pointX + radius) do
            for j = math.floor(pointY - radius + 1), math.floor(pointY + radius) do
                if grid[i] ~= nil then
                    grid[i][j] = color
                end
            end
        end
    end
end

function love.draw()
    M.graphics.print(radius, 100, 100)
    for i = 1, gridProp.countX do
        for j = 1, gridProp.countY do
            local value = grid[i][j]
            if value ~= 0 then

                if value == 1 then M.graphics.setColor(1, 1, 1)
                elseif value == 2 then M.graphics.setColor(1, 0, 0)
                elseif value == 3 then M.graphics.setColor(1, 1, 0)
                end

                M.graphics.rectangle("fill", (i-1)*gridProp.width, (j-1)*gridProp.height, gridProp.width, gridProp.height)
            end
        end
    end
end
