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
end

function Brush:stroke(x,y)
end

function Brush:strokeEnd()
end

function Brush:touched(touch)
    if touch.state == BEGAN and not self.touchId then
        self.touchId = touch.id
        pushStyle()
        self:strokeStart(touch.x,touch.y)
        popStyle()
        self.prevX = touch.x
        self.prevY = touch.y
        
    elseif touch.id == self.touchId then
        if touch.state == MOVING then
            pushStyle()            
            self:stroke(touch.x,touch.y)
            popStyle()            
            self.prevX = touch.x
            self.prevY = touch.y
        elseif touch.state == ENDED then
            pushStyle()
            self:strokeEnd()
            popStyle()
            self.touchId = nil
        end
    end
end