-- Grant
-- Original brush code developed by Grant (grant@enabled.com.au)

Grant = class(Brush)

function Grant:init()
    Brush.init(self,"Grant")
end

function Grant:strokeStart(x,y)
    fill(red,green,blue,alpha)
    ellipse(x, y, thicknessFill, thicknessFill)
end

function Grant:stroke(x,y)
    stroke(red,green,blue,alpha)
    fill(red,green,blue,alpha)
    ellipse(x, y, thicknessFill, thicknessFill)

end

function Grant:strokeEnd()
    fill(0, 0, 0, 255)
end