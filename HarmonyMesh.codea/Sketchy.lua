-- Sketchy

Sketchy = class(BrushEx)

function Sketchy:init()
    BrushEx.init(self,"Sketchy")
end

function Sketchy:stroke(x,y)

    canvas:strokeWidth(thicknessFill)
    canvas:stroke(red,green,blue,alpha)
    
    canvas:line(self.prevX,self.prevY,x,y)
   
    local dx, dy, d

    for i = 1, #self.points do
        dx = self.points[i].x - self.points[self.count].x
        dy = self.points[i].y - self.points[self.count].y
        d = dx * dx + dy * dy;

        if (d < 4000 and math.random() > (d/2000)) then

            canvas:stroke(red,green,blue, 
                ((1 - (d / 1000)) * 0.1 * alpha))

            canvas:line(self.points[self.count].x + dx * 0.3, 
                self.points[self.count].y + dy * 0.3,
                self.points[i].x - dx * 0.3,
                self.points[i].y - dy * 0.3)

        end
    end
end