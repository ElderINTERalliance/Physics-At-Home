require("require")
require("classes")
-- require("window")
require("draw")
require("operators")

maid64 = require("maid64")
tween = require("tween")
State = require("state")
palette = require("palette")
ActiveTheme = palette.DefaultDark
utils = require("utils")
Physapp = require("physapp")
WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()

love.filesystem.createDirectory("labs")

function saveSG(data)
    love.filesystem.write("labs/testreq.lua", data)
end

--
-- function loadSG()
--    if love.filesystem.getInfo('savegame.json') == nil then
--        local data = { day = 1, population = 10000, economyH = 0, ecologyH = 0, politicSupport = 0 }
--        saveSG(data)
--    end
--    -- Load the data table:
--    -- Copy the variables out of the table:
--    return json.decode(love.filesystem.read("savegame.json"))
-- end

-- local vertices  = { 100, 100, 200, 100, 200, 200, 300, 200, 300, 300, 100, 300 } -- Concave "L" shape.
-- local triangles = love.math.triangulate(vertices)
--local stencilX = 255
--local stencilY = 200
--local function myStencilFunction()
--    love.graphics.rectangle("fill", stencilX, stencilY, 350, 300, 20, 20, 100)
--end
--local text = ""

function love.resize(w, h)
    WIDTH = w
    HEIGHT = h
    State:resize(w, h)
end

function love.wheelmoved(x, y)
    State:wheelmoved(x,y)
end

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    State:LoadState("menu")
    love.graphics.setBackgroundColor(0.41, 0.53, 0.97, 1)
    -- print(love.graphics.getFont())
    -- local s = "sussy2"
    -- saveSG("print('sussy" .. s .. "')")
    -- require("testreq")
    -- Physapp.newWorld()
end

function love.update(dt)
    State:update(dt)
    -- collectgarbage("collect")
    if love.keyboard.isDown("space") then
        State:LoadState("menu")
    end--elseif love.keyboard.isDown("left") then
    --    stencilX = stencilX - 1
    -- elseif love.keyboard.isDown("down") then
    --    stencilY = stencilY + 1
    -- elseif love.keyboard.isDown("up") then
    --    stencilY = stencilY - 1
    -- end
    -- if love.mouse.isDown(1) then
    --    local x, y = love.mouse.getPosition()
    --    if testShape:testPoint(0, 0, 0, x, y) then
    --        print("mouse is touching shape")
    --    end
    -- end
end

local function stencilTestFunc()
    -- draw a rectangle as a stencil. Each pixel touched by the rectangle will have its stencil value set to 1. The rest will be 0.
    love.graphics.stencil(myStencilFunction, "replace", 1)

    -- Only allow rendering on pixels which have a stencil value greater than 0.
    love.graphics.setStencilTest("greater", 0)

    love.graphics.setColor(1, 0, 0, 0.45)
    love.graphics.circle("fill", 300, 300, 150, 50)

    love.graphics.setColor(0, 1, 0, 0.45)
    love.graphics.circle("fill", 500, 300, 150, 50)

    love.graphics.setColor(0, 0, 1, 0.45)
    love.graphics.circle("fill", 400, 400, 150, 50)

    love.graphics.setStencilTest()
end

function love.draw()
    State:draw()
    -- Window:DrawBounds()
    -- for i, triangle in ipairs(triangles) do
    --    love.graphics.polygon("fill", triangle)
    -- end
    -- stencilTestFunc()
    ----love.graphics.setColor(ActiveTheme._ss.clearButton.rgb)
    ----love.graphics.rectangle("fill", stencilX + stencilX*0.2, stencilY+ stencilY*0.2, 100, 150, 20,20,100)
    -- Utils.DrawElement(stencilX + stencilX * 0.2, stencilY + stencilY * 0.2, 100, 150, "clearButton")
    --
    -- love.graphics.setColor({ 0.341, 0.675, 0.863 })
    -- local MaxRadius = math.max(ActiveTheme._ss.clearButton.borderRadius[1], ActiveTheme._ss.clearButton.borderRadius[2])
    -- local MinRadius = math.min(ActiveTheme._ss.clearButton.borderRadius[1], ActiveTheme._ss.clearButton.borderRadius[2])
    -- love.graphics.circle("fill", MinRadius + stencilX + stencilX * 0.2, MinRadius + stencilY + stencilY * 0.2, MinRadius)
    --
    -- love.graphics.setColor(1, 1, 1, 1)
    --
    -- love.graphics.print(text, 10, 10)

    -- love.graphics.polygon("fill", vertices)

    -- love.graphics.draw(missing_texture, top_left, 50, 50)
    -- love.graphics.draw(missing_texture, bottom_left, 50, 200)
end
