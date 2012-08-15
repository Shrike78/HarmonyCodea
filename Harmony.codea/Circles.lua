
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
        
    pushStyle()
    
    stroke(red,green,blue,alpha)
    strokeWidth(thicknessFill)
    noFill()
    for i = 0, steps do
        ellipse(cx,cy, (steps - i) * step_delta)
    end
        
    popStyle()
end
