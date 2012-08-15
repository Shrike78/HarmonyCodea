-- Shaded

Shaded = class(BrushEx)

function Shaded:init()
    BrushEx.init(self,"Shaded")
end

function Shaded:stroke(x,y)
    
    pushStyle()
                
    strokeWidth(thicknessFill)
            
    local dx, dy, d

    for i = 1, #self.points do
        dx = self.points[i].x - self.points[self.count].x
        dy = self.points[i].y - self.points[self.count].y
        d = dx * dx + dy * dy;

        if (d < 1000) then
            stroke(red,green,blue, ((1 - (d / 1000)) * 0.1 * alpha))
            line(self.points[self.count].x, self.points[self.count].y,
                self.points[i].x,self.points[i].y)
        end
    end

    popStyle()
end