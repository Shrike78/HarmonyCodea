-- Discs

Discs = class(Brush)

function Discs:init()
    Brush.init(self,"Discs")
end

function Discs:stroke(p)
    local dt = p - self.prev
    local d = dt:len()
    
    canvas:stroke(red,green,blue,alpha)
    canvas:strokeWidth(thicknessFill/2)

    canvas:circle(p, d * thicknessFill / 2)

end