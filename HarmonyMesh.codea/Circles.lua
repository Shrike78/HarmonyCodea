
-- Circles

Circles = class(Brush)

function Circles:init()
    Brush.init(self,"Circles")
end

function Circles:stroke(p)
    
    local dt = p - self.prev

    local d = 2 * dt:len()
    local c = vec2()
    c.x = math.floor(p.x / 100) * 100 + 50
    c.y = math.floor(p.y / 100) * 100 + 50
    local steps = math.floor( math.random() * 10 )
    local step_delta = d / steps
    
    canvas:stroke(red,green,blue,alpha)
    canvas:strokeWidth(thicknessFill/2)
    for i = 0, steps do
        canvas:circle(c, (steps - i) * step_delta)
    end
        
end
