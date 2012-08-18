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

function BrushEx:strokeStart(p)
    if resetBrushStartStroke == 1 then
        self:reset()
    end
    canvas:beginDraw()
end

function BrushEx:touched(touch)
    if touch.state == BEGAN and not self.touchId then
        self.touchId = touch.id
        self:strokeStart(touch.x,touch.y)
        self.prev.x = touch.x
        self.prev.y = touch.y
        
    elseif touch.id == self.touchId then
        if touch.state == MOVING then
            local p = vec2(touch.x,touch.y)
            table.insert(self.points,p)
            self:stroke(p)
            self.prev.x = touch.x
            self.prev.y = touch.y
            self.count = self.count + 1
        elseif touch.state == ENDED then
            self:strokeEnd()
            self.touchId = nil
        end
    end
end