Physapp = {}
Physapp._stored = {}
Physapp._defaults = {
    sizex = 720,
    sizey = 576,
    meterHeight = 64,
    gravity = 9.81,
    mx1 = 0,
    my1 = 0,
    mx2 = 0,
    my2 = 0,
    timeLimit = 30
}
Physapp._AppState_Default = {
    update = function()
    end,
    load = function()
    end,
    draw = function()
    end,
    resize = function()
    end
}

function Physapp.loadWorld(filename)
    local labFile = require(filename)
    if labFile ~= nil then
        setmetatable(labFile, {
            __index = function(table, key)
                return Physapp._AppState_Default[key]
            end
        })
    else
        print("ERROR: StateFile \'" .. filename .. "\' not found!")
        print(love.filesystem.getInfo("states." .. filename))
        return
    end
    local o = {}
    o._data = labFile.args
    setmetatable(o._data, {
        __index = function(table, key)
            return Physapp._defaults[key]
        end
    })
    maid64.setup(o._data.sizex, o._data.sizey, false, WIDTH - o._data["mx2"], HEIGHT - o._data["my2"])
    o._dims = {maid64.canvas:getWidth(), maid64.canvas:getHeight()}
    maid64.resize(WIDTH - o._data["mx2"], HEIGHT - o._data["my2"])
    -- stateFile = nil
    labFile.load()
    function o:draw()
        maid64.start()
        -- love.graphics.clear(0, 0, 0, 0)
        -- love.graphics.setColor(0, 0, 0, 1)
        -- love.graphics.rectangle("fill", 0, 0, self._dims[1], self._dims[2])
        labFile.draw()
        love.graphics.setColor(1.0, 0.0, 0.0)
        love.graphics.circle("fill", maid64.mouse.getX(), maid64.mouse.getY(), 2)
        maid64.finish()
    end

    function o:update(dt)
        labFile.update(dt)
    end

    function o:worldResize(w, h)
        maid64.resize(w - self._data["mx2"], h - self._data["my2"])
    end

    return o
end

function Physapp.newWorld(args)
    local a = args or {}
    setmetatable(a, {
        __index = function(table, key)
            return Physapp._defaults[key]
        end
    })
    maid64.setup(a.sizex, a.sizey, false, WIDTH - a["mx2"], HEIGHT - a["my2"])
    -- print(WIDTH - a["mx2"], HEIGHT - a["my2"], a["mx2"])
    local o = {}
    o._data = a
    o._dims = {maid64.canvas:getWidth(), maid64.canvas:getHeight()}
    maid64.resize(WIDTH - o._data["mx2"], HEIGHT - o._data["my2"])
    love.physics.setMeter(64)
    o._world = love.physics.newWorld(0, 9.81 * 64, true)
    o._objects = {} -- table to hold all our physical objects
    local groundbody = love.physics.newBody(world, WIDTH / 2, HEIGHT - 50 / 2)
    local groundshape = love.physics.newRectangleShape(WIDTH, 50)
    local groundfixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)

    function o:createNew(type, w, h, x, y, color)
        if type == "circle" then
            local tnum = #self._objects + 1
            local shape1 = love.physics.newCircleShape(w)
            local body1 = love.physics.newBody(self._world, x, y, "dynamic")
            local fixture1 = love.physics.newFixture(body1, shape1, 1)
            self._objects[tnum] = {
                type = "circle",
                shape = shape1,
                body = body1,
                fixture = fixture1,
                color = {1, 0, 0}
            }
        end
    end

    function o:draw(drawFunction)
        maid64.start()
        love.graphics.clear(0, 0, 0, 0)
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", 0, 0, self._dims[1], self._dims[2])
        for key, value in pairs(self._objects) do
            if value.type == "circle" then
                love.graphics.setColor(0.76, 0.18, 0.05)
        love.graphics.circle("fill", value.body:getX(), value.body:getY(), value.shape:getRadius())
        local bx, by = value.body:getPosition()
        local vx, vy = value.body:getLinearVelocity()
        -- print(vx,vy)
        utils.DrawArrow(bx, by, ((vx) / 8 + bx), ((vy) / 8 + by), 2, 10)
            end
        end
        love.graphics.setColor(0.20, 0.20, 0.20)
        love.graphics.polygon("fill", groundbody:getWorldPoints(groundshape:getPoints()))
        love.graphics.setColor(1.0, 0.0, 0.0)
        love.graphics.circle("fill", maid64.mouse.getX(), maid64.mouse.getY(), 2)
        maid64.finish()
    end

    function o:worldResize(w, h)
        maid64.resize(w - self._data["mx2"], h - self._data["my2"])
    end

    function o:changeData(key, value)
        self._data[key] = value
        maid64.resize(love.graphics.getWidth(), love.graphics.getHeight())
    end

    function o:update(dt)
        -- o._world:update(0) -- this puts the world into motion
    end

    return o
end

function Physapp:store(keyname, data)
    self._stored["key"] = data
end

return Physapp
