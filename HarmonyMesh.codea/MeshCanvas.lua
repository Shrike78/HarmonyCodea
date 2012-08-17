MeshCanvas = class()

function MeshCanvas:init()
    self.canvas = mesh()
    self.color = color()
    self.thickness = 1
end

function MeshCanvas:stroke(r,g,b,a)
    self.color.r = r
    self.color.g = g
    self.color.b = b
    self.color.a = a
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
        local id = self.canvas:addRect(x,y,l,self.thickness,angle)
        self.canvas:setRectColor(id,self.color)
    end
end

function MeshCanvas:clear()
    self.canvas:clear()
end

function MeshCanvas:draw()
    self.canvas:draw()
end
