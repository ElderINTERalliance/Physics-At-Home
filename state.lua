State = {}
State._AppState = {update = function () end, load = function () end, draw = function () end}
State._AppState_Default = {update = function () end, load = function () end, draw = function () end, resize = function () end, wheelmoved = function (x,y) end}
State._stored = {}

function State:LoadState(stateStr)
    local stateFile = require("states."..stateStr)
    if stateFile ~= nil then
        self._AppState = require("states." .. stateStr)
        setmetatable(self._AppState, {__index = function (table, key) return self._AppState_Default[key] end})
        self._AppState.load()
    else
        print("ERROR: StateFile \'" .. stateStr .. "\' not found!")
        print(love.filesystem.getInfo("states." .. stateStr))
    end
    stateFile = nil
end

function State:update(dt)
    self._AppState.update(dt)
end
function State:draw()
    self._AppState.draw()
end
function State:resize(w,h)
    self._AppState.resize(w,h)
end

function State:store(keyname,data)
    self._stored["key"] = data
end

function State:wheelmoved(x,y)
    self._AppState.wheelmoved(x,y)
end

return State