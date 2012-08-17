-- Chrome
Chrome = class(BrushEx)

function Chrome:init()
    BrushEx.init(self,"Chrome")
end

function Chrome:stroke(x,y)
    
    stroke(red,green,blue,alpha)
    strokeWidth(thicknessFill)
    
    line(self.prevX,self.prevY,x,y) 
    
    stroke(red,green,blue,alpha * 0.2)
    
    local dx, dy, d
    
    for i = 1, #self.points do
        dx = self.points[i].x - self.points[self.count].x
        dy = self.points[i].y - self.points[self.count].y
        d = dx * dx + dy * dy
        if d < 1000 then          
            line(self.points[self.count].x + dx * 0.2,
                self.points[self.count].y + dy * 0.2,
                self.points[i].x - dx * 0.2,
                self.points[i].y - dy * 0.2)
            
        end
    end
    
end