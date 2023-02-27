Utils = {}
--Utils._conf = require("config")

Utils._fontPaths = {
    inter = { regular = "fonts/Inter-Regular.ttf",
        semibold = "fonts/Inter-SemiBold.ttf",
        light = "fonts/Inter-Light.ttf" }
}
Utils._DEFAULT_FONTNAME = Utils._fontPaths.inter.regular
Utils._fonts = {}
Utils._fonts[16] = love.graphics.setNewFont(Utils._fontPaths.inter.regular, 16)
Utils._currentFontSize = 16
function Utils.DrawElement(x, y, w, h, styleSheetStr, mouseover, textData)
    local mouseoverVar = ""
    if mouseover then
        mouseoverVar = "_mouseover"
        --print("mousoverworked  " .. "opacity"..mouseoverVar)
    end
    local rgb = ActiveTheme._ss[styleSheetStr]["rgb" .. mouseoverVar] or ActiveTheme._ss["DEFAULT"]["rgb"] or { 0, 0, 0 }
    if ActiveTheme._ss[styleSheetStr]["opacity" .. mouseoverVar] ~= nil or ActiveTheme._ss[styleSheetStr]["opacity"] ~= nil then
        rgb = { rgb[1], rgb[2], rgb[3],
            ActiveTheme._ss[styleSheetStr]["opacity" .. mouseoverVar] or ActiveTheme._ss[styleSheetStr]["opacity"] or 1 }
    end
    love.graphics.setColor(rgb)
    love.graphics.rectangle("fill", x, y, w, h, ActiveTheme._ss[styleSheetStr]["borderRadiusX"] or 0,
        ActiveTheme._ss[styleSheetStr]["borderRadiusY"] or 0)
    if ActiveTheme._ss[styleSheetStr]["border"] ~= nil and ActiveTheme._ss[styleSheetStr]["border"] ~= 0 then
        love.graphics.setLineWidth(ActiveTheme._ss[styleSheetStr]["border"])
        local B_rgb = ActiveTheme._ss[styleSheetStr]["border_rgb"] or { 0, 0, 0 }
        if ActiveTheme._ss[styleSheetStr]["border_opacity"] ~= nil then
            B_rgb = { B_rgb[1], B_rgb[2], B_rgb[3], ActiveTheme._ss[styleSheetStr]["border_opacity"] or 1 }
        end
        love.graphics.setColor(B_rgb)
        love.graphics.rectangle("line", x, y, w, h, ActiveTheme._ss[styleSheetStr]["borderRadiusX"] or 0,
            ActiveTheme._ss[styleSheetStr]["borderRadiusY"] or 0)
    end
    if textData then
        Utils.setFontSize(textData["fontSize"])
        local c = Utils.GetSnapCoords(x, y, w, h, textData["x"], textData["y"], w, textData["fontSize"] or 16)
        local txt
        if type(textData["text"]) == "function" then txt = textData["text"]() else txt = textData["text"] end
        Utils.printf(textData["style"] or styleSheetStr, txt, c[1], c[2] - ((textData["fontSize"] or 16) / 4),
            textData["limit"] or w, textData["align"])
    end
    love.graphics.setColor(1, 1, 1, 1)
end

function Utils.MathRound(num)
    local ceilNum = math.ceil(num)
    if num >= ceilNum - 0.5 then
        return ceilNum
    end
    return math.floor(num)
end

function Utils.printf(styleSheetStr, ...)
    local rgb = ActiveTheme._ss[styleSheetStr]["text_rgb"] or ActiveTheme._ss["DEFAULT"]["text_rgb"] or { 0, 0, 0 }
    if ActiveTheme._ss[styleSheetStr]["text_opacity"] ~= nil then
        rgb = { rgb[1], rgb[2], rgb[3],
            ActiveTheme._ss[styleSheetStr]["text_opacity"] or 1 }
    end
    love.graphics.setColor(rgb)
    love.graphics.printf(...)
    love.graphics.setColor(1, 1, 1, 1)
end

function Utils.setFontSize(fontsize)
    local fontsize = fontsize or 16
    if Utils._currentFontSize == fontsize then
        return
    elseif Utils._fonts[fontsize] then
        love.graphics.setFont(Utils._fonts[fontsize])
    else
        Utils._fonts[fontsize] = love.graphics.setNewFont(Utils._fontPaths.inter.regular, fontsize)
    end
    Utils._currentFontSize = fontsize
end

function Utils.DrawStyled(imagedata, insidex, insidey, insidew, insideh, xc, yc, marginx, marginy, paddingx, paddingy)
    love.graphics.setColor(1, 1, 1, 1)
    local w = imagedata:getWidth()
    local h = imagedata:getHeight()
    --local minIn = math.min(insideh-((paddingy or 0)*2), insidew-((paddingx or 0)*2))
    --local minPic = math.min(w, h)
    local scale = 0
    local inWidth = (insidew - ((marginx or 0) * 2))
    local inHeight = (insideh - ((marginy or 0) * 2))
    if h / inHeight > w / inWidth then
        scale = (inHeight - ((paddingy or 0) * 2)) / h
    else
        scale = (inWidth - ((paddingx or 0) * 2)) / w
    end
    --local scale = math.min((math.min(w, h) / math.min(insideh-((paddingy or 0)*2), insidew-((paddingx or 0)*2))),(math.min(insideh-((paddingy or 0)*2), insidew-((paddingx or 0)*2)) / math.min(w, h)))
    --print(scale)
    local x = 0
    if type(xc) == "string" then
        if xc == "center" then
            --print(insidex)
            x = (insidex + ((insidew / 2) - (w * scale / 2)))
        elseif xc == "left" then
            x = insidex + (marginx or 0)
        elseif xc == "right" then
            x = (insidex + insidew - (w * scale + (marginx or 0)))
        end
    else
        x = xc or 0
    end
    local y = 0
    if type(yc) == "string" then
        --print("sussy")
        if yc == "center" then
            y = (insidey + ((insideh / 2) - (h * scale / 2)))
            --print("middle")
        elseif yc == "top" then
            y = insidey + (marginy or 0)
        elseif yc == "bottom" then
            y = (insidey + insideh - (h * scale + (marginy or 0)))
        end
    else
        y = yc or 0
    end
    --print(x,type(x),y,type(y))
    love.graphics.draw(imagedata, x --[[+(paddingx or 0)]], y --[[+(paddingy or 0)]], 0, scale, scale)
    love.graphics.setColor(0, 0, 0, 1)
end

function Utils.CreateParent(ElementDataTable)
    local o = {}
    o._data = ElementDataTable
    o._children = {}
    o._hitboxes = {}
    o._childrenData = {}
    function o:appendChild(type, childData, clickable, clickFunction, textData)
        if type == "element" then
            table.insert(self._children,
                function(clicked)
                    local coords = Utils.GetSnapCoords(self._data[1], self._data[2], self._data[3], self._data[4],
                        childData[1],
                        childData[2], childData[3], childData[4])
                    Utils.DrawElement(coords[1] or 0, coords[2] or 0, childData[3] or 0, childData[4] or 0,
                        childData[5] or 0, clicked, textData)
                end)

            if clickable then
                --self._hitboxes[#self._children] = { coords[1], coords[2], coords[1] + childData[3],
                --    coords[2] + childData[4], clickFunction or function()
                --end }
                self._hitboxes[#self._children] = function()
                    local coords = Utils.GetSnapCoords(self._data[1], self._data[2], self._data[3], self._data[4],
                        childData[1], childData[2], childData[3], childData[4])
                    return { coords[1], coords[2], coords[1] + childData[3],
                        coords[2] + childData[4], clickFunction or function()
                    end }
                end
            end
        elseif type == "img" or type == "image" then
            table.insert(self._children,
                function()
                    Utils.DrawStyled(childData[1], self._data[1], self._data[2], self._data[3],
                        self._data[4], childData[2] or 0, childData[3] or 0, childData[4] or 0, childData[5] or 0,
                        childData[6] or 0, childData[7] or 0)
                end)
        elseif type == "parent" then
            local coords = Utils.GetSnapCoords(self._data[1], self._data[2], self._data[3], self._data[4],
                        childData[1],
                        childData[2], childData[3], childData[4])
            local p = Utils.CreateParent({coords[1],coords[2],childData[3],childData[4],childData[5]})
            table.insert(self._children,
                function(clicked)
                    local coords = Utils.GetSnapCoords(self._data[1], self._data[2], self._data[3], self._data[4],
                        childData[1],
                        childData[2], childData[3], childData[4])
                    Utils.DrawElement(coords[1] or 0, coords[2] or 0, childData[3] or 0, childData[4] or 0,
                        childData[5] or 0, clicked, textData)
                        p._data = {coords[1] or 0, coords[2] or 0, childData[3] or 0, childData[4] or 0,
                        childData[5]}
                    p:draw(true)
                end)

            if clickable then
                --self._hitboxes[#self._children] = { coords[1], coords[2], coords[1] + childData[3],
                --    coords[2] + childData[4], clickFunction or function()
                --end }
                self._hitboxes[#self._children] = function()
                    local coords = Utils.GetSnapCoords(self._data[1], self._data[2], self._data[3], self._data[4],
                        childData[1], childData[2], childData[3], childData[4])
                    return { coords[1], coords[2], coords[1] + childData[3],
                        coords[2] + childData[4], clickFunction or function()
                    end }
                end
            end
            return p
        end
    end

    function o:setValue(key, value)
        self._data[key] = value
    end

    function o:getValue(key)
        return self._data[key]
    end

    function o:draw(subParent)
        if not subParent then Utils.DrawElement(o._data[1] or 0, o._data[2] or 0, o._data[3] or 0, o._data[4] or 0, o._data[5] or "DEFAULT", false, o._data["textData"] or nil) end
        local mouseDown = love.mouse.isDown(1)
        local x, y = love.mouse.getPosition()
        for index, value in ipairs(self._children) do
            if self._hitboxes[index] ~= nil then
                local hbCoords = self._hitboxes[index]()
                local mouseOver = Utils.CheckPointCollision(x, y, hbCoords[1], hbCoords[2],
                    hbCoords[3], hbCoords[4])
                if mouseDown and mouseOver then
                    hbCoords[5]()
                end
                value(mouseOver)
            else
                value()
            end
        end
    end

    return o
end

function Utils.CheckPointCollision(px, py, l, t, r, b)
    if px < l or px > r then
        return false
    end
    if py < t or py > b then
        return false
    end
    return true
end

function Utils.GetSnapCoords(insidex, insidey, insidew, insideh, xc, yc, w, h)
    local x = 0
    if type(xc) == "string" then
        if xc == "center" then
            x = (insidex + ((insidew / 2) - (w / 2)))
        elseif xc == "left" then
            x = insidex
        elseif xc == "right" then
            x = (insidex + insidew - (w))
        end
    else
        x = xc or 0
    end
    local y = 0
    if type(yc) == "string" then
        if yc == "center" then
            y = (insidey + ((insideh / 2) - (h / 2)))
            --print("middle")
        elseif yc == "top" then
            y = insidey
        elseif yc == "bottom" then
            y = (insidey + insideh - (h))
        end
    else
        y = yc or 0
    end
    return { x, y }
end

function Utils.DrawArrow(x1, y1, x2, y2, lineWeight, arrowLength, rgb)
    local ll = math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
    if ll < 5 then return end
    love.graphics.setColor(rgb or { 1, 1, 1, 1 })
    love.graphics.setLineWidth(lineWeight or 1)
    love.graphics.line(x1, y1, x2, y2)
    local t1 = math.atan((y2 - y1) / (x2 - x1))
    local c1 = { math.sin(t1) * arrowLength, -math.cos(t1) * arrowLength }
    local t2 = math.atan((c1[2]) / (c1[1]))
    local c2
    if (y2 >= y1) then
        c2 = { -math.sin(t2) * arrowLength, math.cos(t2) * arrowLength }
    else
        c2 = { math.sin(t2) * arrowLength, -math.cos(t2) * arrowLength }
    end
    love.graphics.line(x2, y2, (x2 + c1[1]) - c2[1], (y2 + c1[2]) - c2[2])
    love.graphics.line(x2, y2, (x2 - c1[1]) - c2[1], (y2 - c1[2]) - c2[2])
end

--local function pointInTriangle(px, py, x1, y1, x2, y2, x3, y3)
--    local ax, ay = x1 - px, y1 - py
--    local bx, by = x2 - px, y2 - py
--    local cx, cy = x3 - px, y3 - py
--    local sab = ax*by - ay*bx < 0
--    if sab ~= (bx*cy - by*cx < 0) then
--      return false
--    end
--    return sab == (cx*ay - cy*ax < 0)
--end
--if borderRadius ~= nil then
--    local localOrigins = {{borderRadius[1],borderRadius[2]},{w-borderRadius[1],borderRadius[2]},{borderRadius[1],h-borderRadius[2]},{w-borderRadius[1],h-borderRadius[2]}}
--    local resolution
--    if Utils._conf.CollisionResolution > 5 then
--        resolution = 5
--    elseif Utils._conf.CollisionResolution < 1 then
--        resolution = 1
--    else
--        resolution = Utils._conf.CollisionResolution
--    end
--    for i = 1, 4, 1 do
--        for j = 1, resolution, 1 do
--
--        end
--    end
--
--end


return Utils
