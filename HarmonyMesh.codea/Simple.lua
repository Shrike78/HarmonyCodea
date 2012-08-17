-- Simple

Simple = class(Brush)

function Simple:init()
    Brush.init(self,"Simple")
end

function Simple:stroke(x,y)
    
    canvas:stroke(red,green,blue,alpha)
    canvas:strokeWidth(thicknessFill)
    
    canvas:line(self.prevX,self.prevY,x,y)
    
end