-- Web

Web = class(BrushEx)

function Web:init()
    BrushEx.init(self,"Web")
end

function Web:stroke(p)
    
    canvas:stroke(red,green,blue,alpha)
    canvas:strokeWidth(thicknessFill)
    
    canvas:line(self.prev,p)

    canvas:stroke(red,green,blue, 0.2 * alpha)
    
    local dt, d

    for i = 1, #self.points do
        dt = self.points[i] - self.points[self.count]

        d = dt:lenSqr()

        if (d < 2500 and math.random() > 0.9) then
            canvas:line(self.points[self.count] + dt, 
                self.points[i] - dt)
        end
    end
end