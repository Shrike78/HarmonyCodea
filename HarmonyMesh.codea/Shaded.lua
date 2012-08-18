-- Shaded

Shaded = class(BrushEx)

function Shaded:init()
    BrushEx.init(self,"Shaded")
end

function Shaded:stroke(p)
                
    canvas:strokeWidth(thicknessFill)
            
    local dt, d

    for i = 1, #self.points do
        dt = self.points[i] - self.points[self.count]
        d = dt:lenSqr()

        if (d < 1000) then
            canvas:stroke(red,green,blue, 
                ((1 - (d / 1000)) * 0.1 * alpha))
            canvas:line(self.points[self.count], 
                self.points[i])
        end
    end

end