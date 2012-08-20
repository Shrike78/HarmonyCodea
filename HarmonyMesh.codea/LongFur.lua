-- LongFur
LongFur = class(BrushEx)

function LongFur:init()
    BrushEx.init(self,"LongFur")
end

function LongFur:stroke(p)
    
    canvas:stroke(red,green,blue,alpha)
    canvas:strokeWidth(thicknessFill)
    
    canvas:line(self.prev,p,0) 
    
    canvas:stroke(red,green,blue,alpha * 0.1)
    
    local size, dt, d
    
    for i = 1, #self.points do
        size = -math.random()
        dt = self.points[i] - self.points[self.count]
        d = dt:lenSqr()
        if d < 4000 and math.random() > d/4000 then
            dt = dt * size
            canvas:line(self.points[self.count] + dt,
                self.points[i] - dt)
        end
    end
end