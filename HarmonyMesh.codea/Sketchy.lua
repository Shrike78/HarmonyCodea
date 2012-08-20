-- Sketchy

Sketchy = class(BrushEx)

function Sketchy:init()
    BrushEx.init(self,"Sketchy")
end

function Sketchy:stroke(p)

    canvas:strokeWidth(thicknessFill)
    canvas:stroke(red,green,blue,alpha)
    
    canvas:line(self.prev,p,0)
   
    local dt, d

    for i = 1, #self.points do
        dt = self.points[i] - self.points[self.count]
        d = dt:lenSqr()

        if (d < 4000 and math.random() > (d/2000)) then

            canvas:stroke(red,green,blue, 
                ((1 - (d / 1000)) * 0.1 * alpha))
            dt = dt * 0.3
            canvas:line(self.points[self.count] + dt, 
                self.points[i] - dt)

        end
    end
end