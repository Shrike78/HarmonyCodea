
supportedOrientations(LANDSCAPE_ANY)

function setup()

    backingMode(RETAINED)    
     
    toolbox = ToolBox()
    
    iparameter("clean_canvas",0,1,0)

    background(255, 255, 255, 255)
    noSmooth()
end

function draw()
    if clean_canvas == 1 then
        clean_canvas = 0
        toolbox:getCurrentBrush():reset()
        background(255, 255, 255, 255)
    end
    
    toolbox:draw()   
end

function touched(touch)
    if not toolbox:touched(touch) then
        toolbox:getCurrentBrush():touched(touch)
    end
end   