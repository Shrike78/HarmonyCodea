-- Brush

Brush = class()

function Brush:init(name)
    assert(name)
    self.name = name
    self.prev = vec2()
end

function Brush:reset()
end

function Brush:getName()
    return self.name
end

function Brush:strokeStart(p)
    canvas:beginDraw()
end

function Brush:stroke(p)
end

function Brush:strokeEnd()
    canvas:endDraw()
end

function Brush:touched(touch)
    if touch.state == BEGAN and not self.touchId then
        self.touchId = touch.id
        self:strokeStart(vec2(touch.x,touch.y))
        self.prev.x = touch.x
        self.prev.y = touch.y
        
    elseif touch.id == self.touchId then
        if touch.state == MOVING then
            self:stroke(vec2(touch.x,touch.y))
            self.prev.x = touch.x
            self.prev.y = touch.y
        elseif touch.state == ENDED then
            self:strokeEnd()
            self.touchId = nil
        end
    end
end