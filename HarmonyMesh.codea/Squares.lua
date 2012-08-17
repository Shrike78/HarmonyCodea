-- Squares

Squares = class(Brush)

function Squares:init()
    Brush.init(self,"Squares")
end

function Squares:stroke(x,y)
    
    local dx = x - self.prevX
    local dy = y - self.prevY
    local angle = 1.57079633
    local px = math.cos(angle) * dx - math.sin(angle) * dy
    local py = math.sin(angle) * dx + math.cos(angle) * dy
    
    canvas:stroke(red,green,blue,alpha)
    canvas:strokeWidth(thicknessFill)
    
    canvas:line(self.prevX - px, self.prevY - py, self.prevX + px,
        self.prevY + py)
    canvas:line(self.prevX + px, self.prevY + py, x + px, y + py)
    canvas:line(x + px, y + py, x - px, y - py)
    canvas:line(x - px, y - py, self.prevX - px, self.prevY - py)
        
end
