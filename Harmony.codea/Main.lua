
supportedOrientations(LANDSCAPE_ANY)

--useCanvas = true

function setup()  
    --watch("fps")
    if useCanvas then
        canvas = mesh()
        canvas.texture = image(WIDTH,HEIGHT)
        canvas:addRect(WIDTH/2,HEIGHT/2,WIDTH,HEIGHT)
        setContext(canvas.texture)
        background(255, 255, 255, 255)
        setContext()
    else
        backingMode(RETAINED)
        background(255, 255, 255, 255)
    end
    
    touchList = {}
    toolbox = ToolBox()
    
    iparameter("clean_canvas",0,1,0)
    
    noSmooth()
    
end

function draw()
    --fps = 1/DeltaTime
    if useCanvas then
        setContext(canvas.texture)
    end
    for i = 1, #touchList do
        processTouches(table.remove(touchList,1))
    end
    if clean_canvas == 1 then
        clean_canvas = 0
        toolbox:getCurrentBrush():reset()
        background(255, 255, 255, 255)
    end
    if useCanvas then
        setContext()
        canvas:draw()
    end
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