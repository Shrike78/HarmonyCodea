
-- Circles

Circles = class(Brush)

function Circles:init()
    Brush.init(self,"Circles")
end

function Circles:stroke(x,y)
    
    local dx = x - self.prevX
    local dy = y - self.prevY
    local d = math.sqrt(dx * dx + dy * dy) * 2
    local cx = math.floor(x / 100) * 100 + 50
    local cy = math.floor(y / 100) * 100 + 50
    local steps = math.floor( math.random() * 10 )
    local step_delta = d / steps
    
    canvas:stroke(red,green,blue,alpha)
    canvas:strokeWidth(thicknessFill/2)
    for i = 0, steps do
        canvas:circle(cx,cy, (steps - i) * step_delta)
    end
        
end
