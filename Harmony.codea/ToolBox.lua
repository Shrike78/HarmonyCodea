-- ToolBox

ToolBox = class()

local selectedPaletteIdx = 0
local paletteOffset = 5
local paletteSize = 30
local selPaletteSize = 25
local menuBar = 50
local shadowWidth = 6
local baseCol = 200
local startPos = HEIGHT - 50

function ToolBox:init()

    self:initBrushes()
    self:initPalette()
    
    parameter("thicknessFill", 2, 15, 2)
    iparameter("red", 0, 255)
    iparameter("green",0, 255)
    iparameter("blue",0, 255)
    iparameter("alpha", 0, 255, 255)
    iparameter("resetBrushStartStroke",0,1,0)
    iparameter("resetBrushStroke",0,1,0)
    watch("_currentBrush")
    iparameter("SelectedBrush",1,#self.brushList,1)
    iparameter("showPalette",0,1,1)

end

-- Brushes Management

function ToolBox:initBrushes()
    self.brushList = {
       -- Brush(),
        Chrome(),
        Circles(),
        Discs(),
        Fur(),
        LongFur(),
        Shaded(),
        Simple(),
        Sketchy(),
        Squares(),
        Web()
    }
    self.brushListName = {}
    for _,v in pairs(self.brushList) do
        table.insert(self.brushListName,v:getName())
    end
    self.currentBrushIdx = 1
    _currentBrush = self.brushListName[self.currentBrushIdx]
end

function ToolBox:updateBrush()
    if self.currentBrushIdx ~= SelectedBrush then
        self.brushList[self.currentBrushIdx]:reset()
        self.currentBrushIdx = SelectedBrush
        _currentBrush = self.brushListName[self.currentBrushIdx]
    end
    if resetBrushStroke == 1 then
        resetBrushStroke = 0
        self.brushList[self.currentBrushIdx]:reset()
    end
end

function ToolBox:getCurrentBrush()
    return self.brushList[self.currentBrushIdx]
end


-- Palette Management

function ToolBox:initPalette()
    self.palette = {
        color(255, 0, 0, 255),
        color(255, 127, 0, 255),
        color(255, 255, 0, 255),
        color(0, 255, 0, 255),
        color(0, 255, 255, 255),
        color(0, 0, 255, 255),
        color(127, 0, 255, 255),
        color(255, 0, 255, 255),
        color(0, 0, 0, 255),
        color(51, 51, 51, 255),
        color(102, 102, 102, 255),
        color(153, 153, 153, 255),
        color(204, 204, 204, 255),
        color(255, 255, 255, 255)
    }
end

function ToolBox:getPaletteCol(index)
    return self.palette[index]
end

function ToolBox:setPaletteCol(index,r,g,b,a)
    local c = self.palette[index]
    c.r = r
    c.g = g
    c.b = b
    c.a = a
end

function ToolBox:getPaletteId(y)
    for pCount = 1, #self.palette do
        local topPalSquare = (startPos - ((paletteSize + 5) * pCount)) + 
            (paletteSize/2)
        local botPalSquare = topPalSquare - paletteSize
        if y < topPalSquare and y > botPalSquare then
            return pCount
        end
    end
    return 0
end

function ToolBox:drawPalette()
    
    -- bit of eyecandy drop shadow
    for shadow = 1, shadowWidth do
        local gradFactor = 255 - (baseCol/shadowWidth) * shadow
        fill(gradFactor, gradFactor, gradFactor, 255)
        rect(0, 0, menuBar + shadowWidth - shadow, HEIGHT)
    end

    fill(234, 234, 234, 255)
    rect(0, 0, menuBar, HEIGHT)
    
    --create the current brush style with white backing, 
    -- white impotant when using alpha < 255
    pushStyle()
    stroke(255, 255, 255, 255)
    strokeWidth(1)
    fill(255)
    ellipse(menuBar/2, HEIGHT - paletteSize, thicknessFill * 2)
    fill(red,green,blue,alpha)
    ellipse(menuBar/2, HEIGHT - paletteSize, thicknessFill * 2)
    popStyle()
    
    for pCount = 1, #self.palette do
        if selectedPaletteIdx == pCount then
            pushStyle()
            c = self:getPaletteCol(pCount)
            if handledColSelect then
                red = c[1]
                green = c[2]
                blue = c[3]
                alpha = c[4]
                handledColSelect = false
            end

            fill(c)
            strokeWidth(2)
            stroke(255, 255, 255, 255)
            rectMode(CENTER)
            rect(menuBar/2, (startPos - (paletteSize + paletteOffset) *
                pCount), selPaletteSize, selPaletteSize )
            popStyle()
        else
            c = self:getPaletteCol(pCount)
            fill(c)
            pushStyle()
            rectMode(CENTER)
            rect(menuBar/2, startPos - (paletteSize + paletteOffset) *
                pCount, paletteSize, paletteSize )
            popStyle()
        end
        pushStyle()
        fill(255)
        popStyle()
    end    
end


function ToolBox:draw()
    
    self:updateBrush()
    
    if showPalette == 1 then
        self:drawPalette()
    end
    
    if selectedPaletteIdx ~= 0 then
        self:setPaletteCol(selectedPaletteIdx,red,green,blue,alpha)
    end
end

function ToolBox:touched(touch)
    if showPalette == 1 and touch.state == BEGAN then
        if touch.x < menuBar then
            handledColSelect = true
            local yColSelect = touch.y
            local paletteIdx = self:getPaletteId(yColSelect)
            if selectedPaletteIdx ~= paletteIdx then
                selectedPaletteIdx = paletteIdx
            else
                selectedPaletteIdx = 0
            end
            return true
        end
    end
    return false
end