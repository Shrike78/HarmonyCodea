-- Fur
Fur = class(BrushEx)

function Fur:init()
    BrushEx.init(self,"Fur")
end

function Fur:stroke(p)
    
    canvas:stroke(red,green,blue,alpha)
    canvas:strokeWidth(thicknessFill)
    
    canvas:line(self.prev,p) 
    
    canvas:stroke(red,green,blue,alpha * 0.2)
    
    local dt, d
    
    for i = 1, #self.points do
        dt = self.points[i] - self.points[self.count]

        d = dt:lenSqr()
        if d < 2000 and math.random() > d/2000 then
            dt = dt * 0.5
            canvas:line(p + dt, p - dt)
        end
    end

end