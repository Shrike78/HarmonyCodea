-- Simple

Simple = class(Brush)

function Simple:init()
    Brush.init(self,"Simple")
end

function Simple:stroke(x,y)
    pushStyle()
    
    stroke(red,green,blue,alpha)
    strokeWidth(thicknessFill)
    
    line(self.prevX,self.prevY,x,y)
    
    popStyle()
end