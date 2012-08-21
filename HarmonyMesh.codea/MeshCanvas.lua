--MeshCanvas

MeshCanvas = class()

MeshCanvas.LINE_ID = 2
MeshCanvas.DEFAULT_STROKE = 1

local stroke_type = {
    MeshCanvas.DEFAULT_STROKE,
    MeshCanvas.LINE_ID
}

function MeshCanvas:init()
--Init Canvas
    self.canvas = mesh()
    self.canvas.texture = image(WIDTH,HEIGHT)
    setContext(self.canvas.texture)
    background(255,255,255,255)
    setContext()
    self.canvas:addRect(WIDTH/2,HEIGHT/2,WIDTH,HEIGHT)
    
--Init stroke meshes
    self.meshes = {}
    self.numOfRects = {}
    for _,v in ipairs(stroke_type) do
        self.meshes[v] = mesh()
        self.numOfRects[v] = 0
    end
    self.color = color()
    self.thickness = 1
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
    for _,m in ipairs(self.meshes) do
        m:draw()
    end
    setContext()
    for _,v in ipairs(stroke_type) do
        self.meshes[v]:clear()
        self.numOfRects[v] = 0
    end
end

function MeshCanvas:strokeWidth(thickness)
    self.thickness = thickness
end


function MeshCanvas:line(s,e,lineID,bSkip)
    
    local lineID = lineID or MeshCanvas.DEFAULT_STROKE
    local lines = self.meshes[lineID]
    
    local v = e - s
    local angle = math.atan2(v.y,v.x)
    local l = v:len()

    local v = s + v/2
    
    if not self.smooth then
        local id = lines:addRect(v.x,v.y,
            l,self.thickness,angle)
        lines:setRectColor(id,self.color)
        
        if lineID == MeshCanvas.LINE_ID and not bSkip and id > 1 then
            local idx = (id - 2) * 6
            lines:vertex(idx+3, lines:vertex(idx+8))
            lines:vertex(idx+5, lines:vertex(idx+8))
            lines:vertex(idx+6, lines:vertex(idx+7))
        end
        self.numOfRects[lineID] = self.numOfRects[lineID] + 1
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

        if lineID == MeshCanvas.LINE_ID and not bSkip and id > 3 then
            local idx = (id - 6) * 6
            for i = 1,3 do
                lines:vertex(idx+3, lines:vertex(idx+20))
                lines:vertex(idx+5, lines:vertex(idx+20))
                lines:vertex(idx+6, lines:vertex(idx+19))
                idx = idx + 6
            end
        end
        self.numOfRects[lineID] = self.numOfRects[lineID] + 3
    end
end

function MeshCanvas:circle(c,d)    
    local r = d/2
    
	local numSegments =  (d < 10) and math.floor(d * 4) or 40
    
    local dtheta = 2 * math.pi / numSegments
    local vr = vec2(r,0)
    local p1 = c + vr
    local p2 = vec2()
    local theta = 0
    local bSkip = true
    for i = 1, numSegments do
        theta = theta + dtheta
        p2 = c + vr:rotate(theta)
        self:line(p1,p2,MeshCanvas.LINE_ID,bSkip)
        p1.x = p2.x
        p1.y = p2.y
        bSkip = false
    end
end

function MeshCanvas:getMeshSize()
    local s = 0
    for _,v in ipairs(self.numOfRects) do
        s = s + v
    end
    return s
end

function MeshCanvas:clear()
    setContext(self.canvas.texture)
    background(255,255,255,255)
    setContext()
    for _,v in ipairs(stroke_type) do
        self.meshes[v]:clear()
        self.numOfRects[v] = 0
    end
end

function MeshCanvas:draw()
    self.canvas:draw()
    for _,m in pairs(self.meshes) do
        m:draw()
    end
end
