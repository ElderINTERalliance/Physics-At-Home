local DefaultCanvasW=400
local DefaultCanvasH=400
local DefaultAspectRatio={1,1}
---@diagnostic disable-next-line: lowercase-global
local width = love.graphics.getWidth()
---@diagnostic disable-next-line: lowercase-global
local height = love.graphics.getHeight()

Window = {CanvasW=DefaultCanvasW,CanvasH=DefaultCanvasH,Scale=0,w=0,h=0}

function Window:init(CW,CH)
    self.CanvasW=CW
    self.CanvasH=CH
    self:Update()
end

function Window:Update()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    self.Scale = (math.min(width, height) / math.min(Window.CanvasH, Window.CanvasW))
    local scaleH= width/self.CanvasW
    local scaleW= height/self.CanvasH
    self.w = scaleW*self.CanvasW
    self.h = scaleH*self.CanvasH
    local bound1 = {Operators.ternary(self.w >= width, width, (width-self.w)/2),Operators.ternary(self.h <= height, (height-self.h)/2, height)}
    local bound2 = {Operators.ternary(self.w >= width, 0, bound1[1]+self.w),Operators.ternary(self.h <= height, bound1[2]+self.h, 0)}
    self.Bounds= {{bound1[1],bound1[2]},{bound2[1],bound2[2]}}
end

function Window:DrawBounds()
    Draw.Shape("rectangle",1,1,1,1,"fill",0,0, self.Bounds[1][1],self.Bounds[1][2])
    Draw.Shape("rectangle",1,1,1,1,"fill", self.Bounds[2][1], self.Bounds[2][2], width,height)
end
