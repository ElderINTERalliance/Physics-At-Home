state = {}
local playerMode = false
function state.load()
    logo = love.graphics.newImage("logo.png")
    movetool = love.graphics.newImage("movetool.png")
    menuPanel = utils.CreateParent({0, 0, 350, HEIGHT, "menuPanel"})
    menuPanel:appendChild("image", {logo, "center", "top", 10, 10, 50})
    menuPanel:appendChild("element", {"center", 200, 200, 20, "textOnly"}, false, nil, {
        text = "DEMO v0.1 Showcase",
        align = "center",
        x = "center",
        y = "center",
        fontSize = 16
    })
    menuPanel:appendChild("element", {"center", 225, 175, 75, "menuButton"}, true, function()
        playerMode = true
    end, {
        text = "Open Lab Editor",
        align = "center",
        x = "center",
        y = "center",
        fontSize = 22
    })
    --subParent = menuPanel:appendChild("parent", {"center", 325, 100, 100, "menuButton"}, true, function()
    --    State:LoadState("labeditor")
    --end)
    ----subParent:appendChild("image", {movetool, "center", "center", 5, 5, 0})
    atest = Physapp.loadWorld("demo1")
end

function state.update(dt)
    atest:update(dt)
    menuPanel:setValue(4, HEIGHT)

    if love.mouse.isDown(1) then
        -- print("mousedown")
        local x, y = maid64.mouse.getPosition()

        if selObj == nil then
            -- print("fart")
            for index, value in pairs(objects) do
                local bx, by = value.body:getPosition()
                if value.shape:testPoint(bx, by, 0, x, y) and value.body:getType() == "dynamic" then
                    selObj = value
                    selObj.body:setAwake(true)
                end
            end
        else
            selObj.body:setPosition(x, y)
            selObj.body:setLinearVelocity(0, 0)
            selObj.body:setAngularVelocity(0)
            fn={0,0}
        end
    else
        selObj = nil
    end

    if love.keyboard.isDown('o') then
        world:setGravity(0,9.81 * 64)
    end
end

function state.draw()
    atest:draw()
    if not playerMode then
        menuPanel:draw()
    end
end

function state.resize(w, h)
    atest:worldResize(w, h)
end

return state
