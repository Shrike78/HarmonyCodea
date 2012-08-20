MeshCanvas = class()

function MeshCanvas:init()
    self.canvas = mesh()
    self.canvas.texture = image(WIDTH,HEIGHT)
    setContext(self.canvas.texture)
    background(255,255,255,255)
    setContext()
    self.canvas:addRect(WIDTH/2,HEIGHT/2,WIDTH,HEIGHT)
    
    self.currentDraw = mesh()
    self.meshes = {}
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
    for _,m in pairs(self.meshes) do
        m:draw()
    end
    self.currentDraw:draw()
    setContext()
    for _,m in pairs(self.meshes) do
        m:clear()
    end
    self.currentDraw:clear()
    self.numOfRects = 0
end

function MeshCanvas:strokeWidth(thickness)
    self.thickness = thickness
end

function MeshCanvas:line1(s,e,lineID)
    
    if lineID and not self.meshes[lineID] then
        self.meshes[lineID] = mesh()
    end
    
    local lines = lineID and self.meshes[lineID] or self.currentDraw
    
    local v = e - s
    local angle = math.atan2(v.y,v.x)
    local l = v:len()

    v = s + v/2
    
    if not self.smooth then
        local id = lines:addRect(v.x,v.y,
                l,self.thickness,angle)
        lines:setRectColor(id,self.color)
        
        if lineID and id > 1 then
            local idx = (id - 2) * 6
            lines:vertex(idx+3, lines:vertex(idx+8))
            lines:vertex(idx+5, lines:vertex(idx+8))
            lines:vertex(idx+6, lines:vertex(idx+7))
        end
        self.numOfRects = self.numOfRects + 1
        
    else        
        local a = self.color.a
        local td = 0.5
        self.thickness = self.thickness - td
        local a1 = a/6
        local a2 = a/2
        local as = a1 + a2 * (255 - a1)/255
        local a3 = 255 * (a - as) / (255 - as)
        local _d = {2, .8, 0}
        local _a = {a1, a2, a3}
        local id
             
        for i=1,3 do
            self.color.a = _a[i]       
            id = lines:addRect(v.x,v.y, l + _d[i], 
            self.thickness + _d[i], angle)
            lines:setRectColor(id,self.color)
        end

        self.color.a = a
        self.thickness = self.thickness + td

        if lineID and id > 3 then
            local idx = (id - 6) * 6
            for i = 1,3 do
--[[
                local v1 = (lines:vertex(idx+3) + 
                    lines:vertex(idx+20))/2
                local v2 = (lines:vertex(idx+6) + 
                    lines:vertex(idx+19))/2
                lines:vertex(idx+3, v1)
                lines:vertex(idx+5, v1)
                lines:vertex(idx+6, v2)
                lines:vertex(idx+20, v1)
                lines:vertex(idx+19, v2)
                lines:vertex(idx+22, v2)

--]]
---[[
                lines:vertex(idx+3, lines:vertex(idx+20))
                lines:vertex(idx+5, lines:vertex(idx+20))
                lines:vertex(idx+6, lines:vertex(idx+19))
--]]

                idx = idx + 6
            end
        end
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

function MeshCanvas:line(p1,p2,id)
    if line_method == 1 then
        self:line1(p1,p2,id)
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

--[[
Slow. Replace line call with a specific line implementation to
avoid all the function calls and also the final end draw now used to reset the line used for each circle
--]]
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
        self:line(p1,p2,0)
        p1.x = p2.x
        p1.y = p2.y
    end
    self:endDraw()
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
    for _,m in pairs(self.meshes) do
        m:draw()
    end
    self.currentDraw:draw()
end
