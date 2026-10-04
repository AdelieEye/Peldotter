_G.M = love
local world = {}

local core  = require "src.core"
local utils = require "src.utils"
local enum  = require "src.enum"

world.grid = {}
world.currentX = (1 + core.gridProp.gridGroupX) / 2
world.currentY = (1 + core.gridProp.gridGroupY) / 2
world.current_grid = {}

world.radius = 0

local ok, mod = pcall(require, "map")
local map = ok and mod or {}

function world:create()
    M.graphics.setBackgroundColor(0.4, 0.4, 0.4, 1)
    world.grid = utils.checkNCreateGrid() or map
    self.current_grid = world.grid[self.currentX][self.currentY]
end

function world:keyboard_inputs(key)
    if     key == "up"    then self.currentY = math.min(core.gridProp.gridGroupY, self.currentY + 1)
    elseif key == "down"  then self.currentY = math.max(1, self.currentY - 1)
    elseif key == "left"  then self.currentX = math.max(1, self.currentX - 1)
    elseif key == "right" then self.currentX = math.min(core.gridProp.gridGroupX, self.currentX + 1)

    elseif key == "p" then self.radius = self.radius + 1
    elseif key == "m" then self.radius = self.radius - 1

    elseif key == "b" then self.color = enum.BLACK
    elseif key == "r" then self.color = enum.RED
    elseif key == "y" then self.color = enum.YELLOW
    elseif key == "c" then self.color = enum.CLEAR

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
    core.draw(self.current_grid)
end

return world
