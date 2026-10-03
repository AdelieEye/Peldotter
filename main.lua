_G.M = love

local ok, mod

ok, mod = pcall(require, "map")
local grid = ok and mod or {}

ok, mod = pcall(require, "check")
local check = ok and mod or {}

local serpent  = require "libs.serpent"

local gridProp = {}
local currentX
local currentY
local current_grid
function love.load()
    M.graphics.setBackgroundColor(0.4, 0.4, 0.4, 0.4)
    gridProp.width  = 10
    gridProp.height = 10
    gridProp.countX = math.floor(M.graphics.getWidth() / gridProp.width)
    gridProp.countY = math.floor(M.graphics.getHeight() / gridProp.height)
    gridProp.gridGroupX = 5
    gridProp.gridGroupY = 5

    currentX = (1 + gridProp.gridGroupX) / 2
    currentY = (1 + gridProp.gridGroupY) / 2

    local function tableEqual(a, b)
        for key, val in pairs(a) do
            if b[key] ~= val then
                return false
            end
        end
        for key, val in pairs(b) do
            if a[key] ~= val then
                return false
            end
        end

        return true
    end

    local function clear(map)
        for i = 1, gridProp.countX do
            map[i] = {}
            for j = 1, gridProp.countY do
                map[i][j] = 0
            end
        end
    end

    if not tableEqual(check, gridProp) then
        for i = 1, gridProp.gridGroupX do
            grid[i] = {}
            for j = 1, gridProp.gridGroupY do
                grid[i][j] = {}
                clear(grid[i][j])
            end
        end
    end

    current_grid = grid[currentX][currentY]
end

local radius = 0
function love.keypressed(key)
    if     key == "up"    then currentY = math.min(gridProp.gridGroupY, currentY + 1)
    elseif key == "down"  then currentY = math.max(1, currentY - 1)
    elseif key == "left"  then currentX = math.max(1, currentX - 1)
    elseif key == "right" then currentX = math.min(gridProp.gridGroupX, currentX + 1)

    elseif key == "p"     then radius = radius + 1
    elseif key == "m"     then radius = radius - 1
    end
    current_grid = grid[currentX][currentY]
end


local function save()
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

local color = 0
function love.update(dt)
    if     M.keyboard.isDown("b") then color = 1
    elseif M.keyboard.isDown("r") then color = 2
    elseif M.keyboard.isDown("y") then color = 3
    elseif M.keyboard.isDown("c") then color = 0 end

    local pointX = math.floor(M.mouse.getX() / gridProp.width) + 1
    local pointY = math.floor(M.mouse.getY() / gridProp.height) + 1
    if M.mouse.isDown(1) then
        for i = math.floor(pointX - radius + 1), math.floor(pointX + radius) do
            for j = math.floor(pointY - radius + 1), math.floor(pointY + radius) do
                if current_grid[i] ~= nil then
                    current_grid[i][j] = color
                end
            end
        end
    end

    if M.keyboard.isDown("space") then save() end
    if M.keyboard.isDown("escape") then
        save()
        love.event.quit()
    end

end

function love.draw()
    M.graphics.print(currentX, 100, 150)
    M.graphics.print(currentY, 100, 200)
    for i = 1, gridProp.countX do
        for j = 1, gridProp.countY do
            local value = current_grid[i][j]
            if value ~= 0 then

                if value == 1 then M.graphics.setColor(0, 0, 0)
                elseif value == 2 then M.graphics.setColor(1, 0, 0)
                elseif value == 3 then M.graphics.setColor(1, 1, 0)
                end

                M.graphics.rectangle("fill", (i-1)*gridProp.width, (j-1)*gridProp.height, gridProp.width, gridProp.height)
            end
        end
    end

    M.graphics.setColor(0, 1, 1)
    M.graphics.print(radius, 100, 100)
end
