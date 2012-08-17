-- Discs

Discs = class(Brush)

function Discs:init()
    Brush.init(self,"Discs")
end

function Discs:stroke(x,y)
    local dx = x - self.prevX
    local dy = y - self.prevY
    local dist = math.sqrt(dx * dx + dy * dy)
    
    canvas:stroke(red,green,blue,alpha)
    canvas:strokeWidth(thicknessFill/2)

    canvas:circle(x,y, dist * thicknessFill / 2)

end