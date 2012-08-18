-- Squares

Squares = class(Brush)

function Squares:init()
    Brush.init(self,"Squares")
end

function Squares:stroke(p)
    
    local dt = (p - self.prev):rotate90()
    
    canvas:stroke(red,green,blue,alpha)
    canvas:strokeWidth(thicknessFill)
    
    canvas:line(self.prev - dt, self.prev + dt)
    canvas:line(self.prev + dt, p + dt)
    canvas:line(p + dt, p - dt)
    canvas:line(p - dt, self.prev - dt)
        
end
