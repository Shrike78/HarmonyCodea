MeshCanvas = class()

function MeshCanvas:init()
    self.canvas = mesh()
    self.canvas.texture = image(WIDTH,HEIGHT)
    setContext(self.canvas.texture)
    background(255,255,255,255)
    setContext()
    self.canvas:addRect(WIDTH/2,HEIGHT/2,WIDTH,HEIGHT)
    
    self.currentDraw = mesh()
    self.color = color()
    self.thickness = 1
    self.numOfRects = 0
    self.smooth = false
end

function MeshCanvas:stroke(r,g,b,a)
    self.color.r = r
    self.color.g = g
    self.color.b = b
    self.color.a = a
end

function MeshCanvas:setSmooth(bValue)
    self.smooth = bValue
end

function MeshCanvas:isSmooth()
    return self.smooth
end

function MeshCanvas:beginDraw()
end
    
function MeshCanvas:endDraw()
    setContext(self.canvas.texture)
    self.currentDraw:draw()
    setContext()
    self.currentDraw:clear()
    self.numOfRects = 0
end

function MeshCanvas:strokeWidth(thickness)
    self.thickness = thickness
end

function MeshCanvas:line1(s,e)

    local v = e - s
    local angle = math.atan2(v.y,v.x)
    local l = v:len()

    v = s + v/2

    if not self.smooth then
        local id = self.currentDraw:addRect(v.x,v.y,
                l,self.thickness,angle)
        self.currentDraw:setRectColor(id,self.color)
        self.numOfRects = self.numOfRects + 1
    else
        local a = self.color.a
        local td = 0.5
        self.thickness = self.thickness - td
        local a1 = a/6
        local a2 = a/2
        local d1 = 2
        local d2 = .8
        
        local as = a1 + a2 * (255 - a1)/255
        local a3 = 255 * (a - as) / (255 - as)

        self.color.a = a1       
        local id = self.currentDraw:addRect(v.x,v.y,
            l + d1, self.thickness + d1, angle)
        self.currentDraw:setRectColor(id,self.color)
            
        self.color.a = a2
        local id = self.currentDraw:addRect(v.x,v.y,
            l + d2, self.thickness + d2,angle)
        self.currentDraw:setRectColor(id,self.color)
            
        self.color.a = a3
        local id = self.currentDraw:addRect(v.x,v.y,
            l,self.thickness,angle)
        self.currentDraw:setRectColor(id,self.color)
        
        self.color.a = a
        self.thickness = self.thickness + td
        self.numOfRects = self.numOfRects + 3
    end
end

--Andrew Stacey smooth line implementation
function MeshCanvas:line2(s,e)

        local w = self.thickness
        local c = self.color
        local wl = (e - s):normalize()
        local wn = wl:rotate90()
        w = wn*w/2
        local n = self.numOfRects * 6 + 1
        if self.smooth then
            self.currentDraw:resize(n+30)
            w = w/2
        else
            self.currentDraw:resize(n+6)
        end
        
        self.currentDraw:vertex(n,s+w)
        self.currentDraw:vertex(n+1,s-w)
        self.currentDraw:vertex(n+2,e+w)
        self.currentDraw:vertex(n+3,e+w)
        self.currentDraw:vertex(n+4,e-w)
        self.currentDraw:vertex(n+5,s-w)
        for i = 0,5 do
            self.currentDraw:color(n+i,c)
        end
        self.numOfRects = self.numOfRects + 1
        if self.smooth then
            local c2 = color(c.r,c.g,c.b,0)
            wn = wn
            wl = wl
            n = n + 6
            self.currentDraw:vertex(n,s+w)
            self.currentDraw:vertex(n+1,s-w)
            self.currentDraw:vertex(n+2,s+w+wn-wl)
            self.currentDraw:vertex(n+3,s+w+wn-wl)
            self.currentDraw:vertex(n+4,s-w-wn-wl)
            self.currentDraw:vertex(n+5,s-w)
            for _,j in ipairs({0,1,5}) do
                self.currentDraw:color(n+j,c)
            end
            for _,j in ipairs({2,3,4}) do
                self.currentDraw:color(n+j,c2)
            end
            n = n + 6
            self.currentDraw:vertex(n,s+w)
            self.currentDraw:vertex(n+1,e+w)
            self.currentDraw:vertex(n+2,s+w+wn-wl)
            self.currentDraw:vertex(n+3,s+w+wn-wl)
            self.currentDraw:vertex(n+4,e+w+wn+wl)
            self.currentDraw:vertex(n+5,e+w)
            for _,j in ipairs({0,1,5}) do
                self.currentDraw:color(n+j,c)
            end
            for _,j in ipairs({2,3,4}) do
                self.currentDraw:color(n+j,c2)
            end
            n = n + 6
            self.currentDraw:vertex(n,e-w)
            self.currentDraw:vertex(n+1,e+w)
            self.currentDraw:vertex(n+2,e-w-wn+wl)
            self.currentDraw:vertex(n+3,e-w-wn+wl)
            self.currentDraw:vertex(n+4,e+w+wn+wl)
            self.currentDraw:vertex(n+5,e+w)
            for _,j in ipairs({0,1,5}) do
                self.currentDraw:color(n+j,c)
            end
            for _,j in ipairs({2,3,4}) do
                self.currentDraw:color(n+j,c2)
            end
            n = n + 6
            self.currentDraw:vertex(n,e-w)
            self.currentDraw:vertex(n+1,s-w)
            self.currentDraw:vertex(n+2,e-w-wn+wl)
            self.currentDraw:vertex(n+3,e-w-wn+wl)
            self.currentDraw:vertex(n+4,s-w-wn-wl)
            self.currentDraw:vertex(n+5,s-w)
            for _,j in ipairs({0,1,5}) do
                self.currentDraw:color(n+j,c)
            end
            for _,j in ipairs({2,3,4}) do
                self.currentDraw:color(n+j,c2)
            end
            self.numOfRects = self.numOfRects + 4
        end       

end

function MeshCanvas:line(p1,p2)
    if line_method == 1 then
        self:line1(p1,p2)
    else
        if self.smooth then
            local t = self.thickness
            self.thickness = self.thickness * 1.8
            self:line2(p1,p2)
            self.thickness = t
        else            
            self:line2(p1,p2)
        end
    end
end

function MeshCanvas:circle(c,d)    
    local r = d/2
    local numSegments = math.floor( 2 * math.pi * r / 
        (self.thickness/2))
        
    local dtheta = 2 * math.pi / numSegments
    local vr = vec2(r,0)
    local p1 = c + vr
    local p2 = vec2()
    local theta = 0
    for i = 1, numSegments do
        theta = theta + dtheta
        p2 = c + vr:rotate(theta)
        self:line(p1,p2)
        p1.x = p2.x
        p1.y = p2.y
    end
end

function MeshCanvas:getMeshSize()
    return self.numOfRects
end

function MeshCanvas:clear()
    setContext(self.canvas.texture)
    background(255,255,255,255)
    setContext()
    self.currentDraw:clear()
    self.numOfRects = 0
end

function MeshCanvas:draw()
    self.canvas:draw()
    self.currentDraw:draw()
end
