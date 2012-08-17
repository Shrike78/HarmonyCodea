-- Brush

Brush = class()

function Brush:init(name)
    assert(name)
    self.name = name
end

function Brush:reset()
end

function Brush:getName()
    return self.name
end

function Brush:strokeStart(x,y)
    canvas:beginDraw()
end

function Brush:stroke(x,y)
end

function Brush:strokeEnd()
    canvas:endDraw()
end

function Brush:touched(touch)
    if touch.state == BEGAN and not self.touchId then
        self.touchId = touch.id
        self:strokeStart(touch.x,touch.y)
        self.prevX = touch.x
        self.prevY = touch.y
        
    elseif touch.id == self.touchId then
        if touch.state == MOVING then
            self:stroke(touch.x,touch.y)
            self.prevX = touch.x
            self.prevY = touch.y
        elseif touch.state == ENDED then
            self:strokeEnd()
            self.touchId = nil
        end
    end
end