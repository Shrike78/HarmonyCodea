-- Discs

Discs = class(Brush)

function Discs:init()
    Brush.init(self,"Discs")
end

function Discs:stroke(x,y)
    local dx = x - self.prevX
    local dy = y - self.prevY
    local dist = math.sqrt(dx * dx + dy * dy)

    pushStyle()
    
    stroke(red,green,blue,alpha)
    strokeWidth(thicknessFill/4)
    noFill()

    ellipse(x,y,dist * thicknessFill / 2)
    
    popStyle()

end