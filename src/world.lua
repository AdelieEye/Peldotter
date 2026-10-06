_G.M = love
local world = {}

local core  = require "src.core"
local utils = require "src.utils"
local enum  = require "src.enum"

world.grid = {}
world.currentX = (1 + core.gridProp.gridGroupX) / 2
world.currentY = (1 + core.gridProp.gridGroupY) / 2
world.current_grid = {}

world.imgs_obj = {}
world.imgs_file = {
    "/imgs/lv_01.png", "/imgs/lv_02.png", "/imgs/lv_03.png", "/imgs/lv_04.png",
    "/imgs/lv_05.png", "/imgs/lv_06.png", "/imgs/lv_07.png", "/imgs/lv_08.png",
    "/imgs/lv_09.png", "/imgs/lv_10.png", "/imgs/lv_11.png", "/imgs/lv_12.png",
    "/imgs/lv_13.png", "/imgs/lv_14.png", "/imgs/lv_15.png", "/imgs/lv_16.png",
    "/imgs/lv_17.png", "/imgs/lv_18.png", "/imgs/lv_19.png", "/imgs/lv_20.png",
    "/imgs/lv_21.png", "/imgs/lv_22.png", "/imgs/lv_23.png", "/imgs/lv_24.png",
    "/imgs/lv_25.png",
    }

world.radius = 0

local ok, mod = pcall(require, "map")
local map = ok and mod or {}

function world:create()
    M.graphics.setBackgroundColor(0.4, 0.4, 0.4, 1)
    world.grid = utils.checkNCreateGrid() or map
    self.current_grid = world.grid[self.currentX][self.currentY]

    for i, img in ipairs(world.imgs_file) do
        world.imgs_obj[i] = M.graphics.newImage(img)
    end
end

function world:keyboard_inputs(key)
    if     key == "up"    then self.currentY = math.min(core.gridProp.gridGroupY, self.currentY + 1)
    elseif key == "down"  then self.currentY = math.max(1, self.currentY - 1)
    elseif key == "left"  then self.currentX = math.max(1, self.currentX - 1)
    elseif key == "right" then self.currentX = math.min(core.gridProp.gridGroupX, self.currentX + 1)

    elseif key == "p" then self.radius = self.radius + 1
    elseif key == "m" then self.radius = math.max(0, self.radius - 1)

    elseif key == "b" then self.color = enum.BLACK
    elseif key == "r" then self.color = enum.RED
    elseif key == "y" then self.color = enum.YELLOW
    elseif key == "c" then self.color = enum.CLEAR
    elseif key == "g" then self.color = enum.GREEN

    elseif key == "space"  then utils.save(self.grid)
    elseif key == "escape" then
        utils.save(self.grid)
        love.event.quit()
    end

    self.current_grid = self.grid[self.currentX][self.currentY]
end

function world:update()
    core.pixelDrawUpdate(self.current_grid, self.color, self.radius)
end

function world:draw()
    local index = (world.currentX - 1) * 5 + (world.currentY)
    M.graphics.setColor(1, 0, 0)
    M.graphics.draw(world.imgs_obj[index], 0, 0)

    core.draw(self.current_grid)
end

return world
