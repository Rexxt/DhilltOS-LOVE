-- clickable object
local TextBox = using("dcl.component"):extend()

function TextBox:new(x, y, width, height, placeholder, default, inType)
    self.super.new(self)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.placeholder = placeholder or ""
    self.value = default or ""
    self.inType = inType or "text"
    self.cursorPos = #self.value

    self.isPassword = false

    self.style = using("dcl.styles").TextBox.primary
    self.currentStyle = self.style.base

    self.padding = self.height/2 - self.style.base.font:getHeight()/2
    self.canvas = love.graphics.newCanvas(self.width - 2*self.padding, self.height-self.padding)
end

function TextBox:update(server, dt)
    local events = self.super.update(self, server, dt)
    for i, v in ipairs(events) do
        if self[v] then
            self[v](self, server)
        end
    end
    if server.focus == self.address then
        self.currentStyle = self.style.focus
    else
        self.currentStyle = self.style.base
    end
end

function TextBox:mouseIn(server)
end

function TextBox:mouseOut(server)
end

function TextBox:mouseDown(server)
    server:grabFocus()
end

function TextBox:mouseUp(server)
end

local function composePasswordString(length)
    local s = ''
    for i=1,length do
        s = s .. '•'
    end
    return s
end

function TextBox:redraw()
    self.canvas:renderTo(function()
        love.graphics.clear()
        local oFont = love.graphics.getFont()

        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.setFont(self.currentStyle.font)
        if not self.isPassword then
            love.graphics.printf(self.value, 0, 0, self.currentStyle.font:getWidth(self.value), 'left')
        else
            love.graphics.printf(composePasswordString(#self.value), 0, 0, self.currentStyle.font:getWidth(composePasswordString(#self.value)), 'left')
        end
        if self.focus then
            local formedSin = (math.sin(love.timer.getTime()*math.pi*2)+1)/2
            love.graphics.setColor(1, 0.25, 0, formedSin)
            if not self.isPassword then
                love.graphics.line(self.currentStyle.font:getWidth(string.sub(self.value, 0, self.cursorPos)), 0, self.currentStyle.font:getWidth(string.sub(self.value, 0, self.cursorPos)), self.currentStyle.font:getHeight())
            else
                love.graphics.line(self.currentStyle.font:getWidth(composePasswordString(self.cursorPos)), 0, self.currentStyle.font:getWidth(composePasswordString(self.cursorPos)), self.currentStyle.font:getHeight())
            end
        end

        love.graphics.setFont(oFont)
    end)
end

function TextBox:textinput(server, t)
    self.value = self.value .. t
    self.cursorPos = #self.value
end

function TextBox:keypressed(server, key)
    if key == 'backspace' then
        self.value = string.sub(self.value, 1, #self.value-1)
        self.cursorPos = #self.value
    end
end

function TextBox:draw(server)
    local oFont = love.graphics.getFont()
    local oR, oG, oB, oA = love.graphics.getColor()

    love.graphics.setFont(self.currentStyle.font)
    love.graphics.setColor(self.currentStyle.background)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, self.currentStyle.rounding)
    if self.currentStyle.outline and self.currentStyle.outline.size > 0 then
        love.graphics.setLineWidth(self.currentStyle.outline.size)
        love.graphics.setColor(self.currentStyle.outline.color)
        love.graphics.rectangle('line', self.x, self.y, self.width, self.height, self.currentStyle.rounding)
    end
    love.graphics.setColor(self.currentStyle.foreground)

    self:redraw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.canvas, self.x + self.padding, self.y + self.padding)

    love.graphics.setFont(oFont)
    love.graphics.setColor(oR, oG, oB, oA)
end

return TextBox