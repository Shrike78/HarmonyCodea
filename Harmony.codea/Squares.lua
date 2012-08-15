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
        
    pushStyle()
    
    stroke(red,green,blue,alpha)
    strokeWidth(thicknessFill)
    
    line(self.prevX - px, self.prevY - py, self.prevX + px,
        self.prevY + py)
    line(self.prevX + px, self.prevY + py, x + px, y + py)
    line(x + px, y + py, x - px, y - py)
    line(x - px, y - py, self.prevX - px, self.prevY - py)
        
    popStyle()
end
