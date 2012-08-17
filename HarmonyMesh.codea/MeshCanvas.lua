MeshCanvas = class()

function MeshCanvas:init()
    self.canvas = mesh()
    self.canvas.texture = image(WIDTH,HEIGHT)
    setContext(self.canvas.texture)
    background(255,255,255,255)
    setContext()
    self.canvas:addRect(WIDTH/2,HEIGHT/2,WIDTH,HEIGHT)
    
    self.currentDraw = mesh()
    self.color = color()
    self.thickness = 1
    self.numOfRects = 0
end

function MeshCanvas:stroke(r,g,b,a)
    self.color.r = r
    self.color.g = g
    self.color.b = b
    self.color.a = a
end

function MeshCanvas:beginDraw()
end
    
function MeshCanvas:endDraw()
    setContext(self.canvas.texture)
    self.currentDraw:draw()
    setContext()
    self.currentDraw:clear()
    self.numOfRects = 0
end

function MeshCanvas:strokeWidth(thickness)
    self.thickness = thickness
end

function MeshCanvas:line(x1,y1,x2,y2)
    if x1 ~= x2 or y1 ~= y2 then
        local x = x2-x1
        local y = y2-y1
        local angle = math.atan2(y,x)
        local l = math.sqrt(x * x + y * y)
        x = x1 + x/2
        y = y1 + y/2
        local id = self.currentDraw:addRect(x,y,l,self.thickness,angle)
        self.currentDraw:setRectColor(id,self.color)
        self.numOfRects = self.numOfRects + 1
    end
end

function MeshCanvas:getMeshSize()
    return self.numOfRects
end
function MeshCanvas:clear()
    setContext(self.canvas.texture)
    background(255,255,255,255)
    setContext()
    self.currentDraw:clear()
    self.numOfRects = 0
end

function MeshCanvas:draw()
    self.canvas:draw()
    self.currentDraw:draw()
end
