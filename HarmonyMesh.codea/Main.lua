
supportedOrientations(LANDSCAPE_ANY)


function setup()  
    --watch("fps")
    canvas = MeshCanvas()
    touchList = {}
    toolbox = ToolBox()
    
    iparameter("clean_canvas",0,1,0)
    noSmooth()
    
end

function draw()
    --fps = 1/DeltaTime
    for i = 1, #touchList do
        processTouches(table.remove(touchList,1))
    end
    if clean_canvas == 1 then
        clean_canvas = 0
        canvas:clear()
        toolbox:getCurrentBrush():reset()
    end
    background(255, 255, 255, 255)
    canvas:draw()
    toolbox:draw()
end

function processTouches(touch)
    if not toolbox:touched(touch) then
        toolbox:getCurrentBrush():touched(touch)
    end
end

function touched(touch)
    table.insert(touchList,touch)
end