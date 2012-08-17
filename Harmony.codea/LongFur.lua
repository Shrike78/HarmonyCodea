-- LongFur
LongFur = class(BrushEx)

function LongFur:init()
    BrushEx.init(self,"LongFur")
end

function LongFur:stroke(x,y)
    
    stroke(red,green,blue,alpha)
    strokeWidth(thicknessFill)
    
    line(self.prevX,self.prevY,x,y) 
    
    stroke(red,green,blue,alpha * 0.1)
    
    local size, dx, dy, d
    
    for i = 1, #self.points do
        size = -math.random()
        dx = self.points[i].x - self.points[self.count].x
        dy = self.points[i].y - self.points[self.count].y
        d = dx * dx + dy * dy
        if d < 4000 and math.random() > d/4000 then
            line(self.points[self.count].x + dx * size,
                self.points[self.count].y + dy * size,
                self.points[i].x - dx * size,
                self.points[i].y - dy * size)
        end
    end
end