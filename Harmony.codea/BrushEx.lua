-- BrushEx

BrushEx = class(Brush)

function BrushEx:init(name)
    Brush.init(self,name)
    self.points = {}
    self.count = 1
end

function BrushEx:reset()
    for k,_ in pairs(self.points) do
        self.points[k] = nil
    end
    self.count = 1
end

function BrushEx:strokeStart(x,y)
    if resetBrushStartStroke == 1 then
        self:reset()
    end
end

function BrushEx:touched(touch)
    if touch.state == BEGAN and not self.touchId then
        self.touchId = touch.id
        pushStyle()
        self:strokeStart(touch.x,touch.y)
        popStyle()
        self.prevX = touch.x
        self.prevY = touch.y
        
    elseif touch.id == self.touchId then
        if touch.state == MOVING then
            table.insert(self.points,vec2(touch.x,touch.y))
            pushStyle()            
            self:stroke(touch.x,touch.y)
            popStyle()            
            self.prevX = touch.x
            self.prevY = touch.y
            self.count = self.count + 1
        elseif touch.state == ENDED then
            pushStyle()
            self:strokeEnd()
            popStyle()
            self.touchId = nil
        end
    end
end