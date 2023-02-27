state = {}

function state.load()
    selObj = nil
    seltool = nil
    logo = love.graphics.newImage("logo.png")
    editorPanel = utils.CreateParent({WIDTH - 350, 0, 350, HEIGHT, "editorPanel"})
    -- editorPanel:appendChild("image",{logo,"center","top",10,10,50})
    editorPanel:appendChild("element", {"left", "top", 116, 40, "editorTab"}, true, function()
        State:LoadState("menu")
    end)
    editorPanel:appendChild("element", {"center", "top", 116, 40, "editorTab"}, true, function()
        playerMode = true

        atest:changeData("mx2", 0)
        atest:changeData("my2", 0)
    end)
    editorPanel:appendChild("element", {"right", "top", 116, 40, "editorTab"}, true, function()
        State:LoadState("menu")
    end, {
        text = "to menu",
        align = "center",
        x = "center",
        y = "center"
    })
    editorPanel:appendChild("element", {"left", 50, 116, 40, "textOnly"}, false, function()
    end, {
        text = "to menu",
        align = "center",
        x = "center",
        y = "center",
        fontSize = 20
    })
    editorPanel:appendChild("element", {"left", 80, 116, 40, "textOnly"}, false, function()
    end, {
        text = function()
            if selObj ~= nil then
                local vx, vy = selObj.body:getLinearVelocity()
                return "velocty X: " .. vx .. "\n" .. "velocty Y: " .. vy
            end
            return ""
        end,
        align = "center",
        x = "center",
        y = "center",
        fontSize = 16
    })
    toolPanel = utils.CreateParent({0, HEIGHT - 50, WIDTH - 30, 50, "editorPanel"})
    tool1 = toolPanel:appendChild("parent", {20, "center", 45, 45, "menuButton"}, true, function()
        seltool = "move"
    end)
    tool1:appendChild("image", {movetool, "center", "center", 0, 0, 0})
    atest = Physapp.loadWorld("demo1")
    tool2 = toolPanel:appendChild("parent", {65, "center", 45, 45, "menuButton"}, true, function()
        --State:LoadState("labeditor")
    end)
    subParent:appendChild("image", {movetool, "center", "center", 0, 0, 0})
    atest = Physapp.newWorld({
        mx2 = 350,
        my2 = 50
    })
    tool3 = toolPanel:appendChild("parent", {110, "center", 45, 45, "menuButton"}, true, function()
        --State:LoadState("labeditor")
    end)
    subParent:appendChild("image", {movetool, "center", "center", 0, 0, 0})
    atest = Physapp.loadWorld("demo1")
    shapemaker1 = toolPanel:appendChild("parent", {WIDTH - 350 - (45*1), "center", 45, 45, "menuButton"}, true, function()
        if not ToolClicked then
            atest:createNew("circle", 10, 10,720/2, 576/2)
        end
    end)
    subParent:appendChild("image", {movetool, "center", "center", 0, 0, 0})
    atest = Physapp.newWorld({
        mx2 = 350,
        my2 = 50
    })
    shapemaker2 = toolPanel:appendChild("parent", {WIDTH - 350 - (45*2)-10, "center", 45, 45, "menuButton"}, true, function()
        --State:LoadState("labeditor")
    end)
    shapemaker3 = toolPanel:appendChild("parent", {WIDTH - 350 - (45*3)-20, "center", 45, 45, "menuButton"}, true, function()
        --State:LoadState("labeditor")
    end)
    ToolClicked = false
end

function state.update(dt)
    editorPanel:setValue(1, WIDTH - 350)
    editorPanel:setValue(4, HEIGHT)
    toolPanel:setValue(2, HEIGHT - 50)
    toolPanel:setValue(3, WIDTH - 30)
    -- toolPanel:setValue(4,HEIGHT)
    tool1:setValue(4, 50)
    tool2:setValue(4, 50)
    tool3:setValue(4, 50)
    shapemaker1:setValue(4, 50)
    shapemaker2:setValue(4, 50)
    shapemaker3:setValue(4, 50)
    -- tool5:setValue(4, 50)
    atest:update(dt)

    if love.mouse.isDown(1) then
        -- print("mousedown")
        local x, y = maid64.mouse.getPosition()

        if selObj == nil then
            ToolClicked = true
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
            fn = {0, 0}
        end
    else
        ToolClicked = false
        selObj = nil
    end
end

function state.draw()
    atest:draw()
    if not playerMode then
        editorPanel:draw()
        toolPanel:draw()
        atest:draw()
    end
    if playerMode then
        
    end

end

function state.resize(w, h)
    atest:worldResize(w, h)
end

return state
