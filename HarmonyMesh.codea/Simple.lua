-- Simple

Simple = class(Brush)

function Simple:init()
    Brush.init(self,"Simple")
end

function Simple:stroke(p)
    
    canvas:stroke(red,green,blue,alpha)
    canvas:strokeWidth(thicknessFill)
    
    canvas:line(self.prev,p)
    
end