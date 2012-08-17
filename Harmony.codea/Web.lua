-- Web

Web = class(BrushEx)

function Web:init()
    BrushEx.init(self,"Web")
end

function Web:stroke(x,y)
    
    stroke(red,green,blue,alpha)
    strokeWidth(thicknessFill)
    
    line(self.prevX,self.prevY,x,y)

    stroke(red,green,blue, 0.2 * alpha)
    
    local dx, dy, d

    for i = 1, #self.points do
        dx = self.points[i].x - self.points[self.count].x
        dy = self.points[i].y - self.points[self.count].y
        d = dx * dx + dy * dy;

        if (d < 2500 and math.random() > 0.9) then
            line(self.points[self.count].x + dx, 
                self.points[self.count].y + dy,
                self.points[i].x - dx,
                self.points[i].y - dy)
        end
    end
end