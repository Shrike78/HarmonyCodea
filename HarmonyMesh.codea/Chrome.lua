-- Chrome
Chrome = class(BrushEx)

function Chrome:init()
    BrushEx.init(self,"Chrome")
end

function Chrome:stroke(p)
    
    canvas:stroke(red,green,blue,alpha)
    canvas:strokeWidth(thicknessFill)
    
    canvas:line(self.prev,p) 
    
    canvas:stroke(red,green,blue,alpha * 0.2)
    
    local dt, d
    
    for i = 1, #self.points do
        dt = self.points[i] - self.points[self.count]
        d = dt:lenSqr()
        if d < 1000 then
            dt = dt * 0.2
            canvas:line(self.points[self.count] + dt,
                self.points[i] - dt)           
        end
    end
    
end