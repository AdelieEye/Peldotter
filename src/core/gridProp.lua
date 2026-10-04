local width  = 5
local height = 5

return {
    width  = width,
    height = height,
    countX = math.floor(M.graphics.getWidth()  / width),
    countY = math.floor(M.graphics.getHeight() / height),
    gridGroupX = 5,
    gridGroupY = 5,
}
