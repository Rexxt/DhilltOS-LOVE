-- clickable object
local Button = using("dcl.component"):extend()

function Button:new(x, y, width, height, label)
    self.super.new(self)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.label = label

    self.style = using("dcl.styles").Button.primary
    self.currentStyle = self.style.base
end

function Button:update(server, dt)
    self.super.update(self, server, dt)
end

function Button:draw(server)
    local oFont = love.graphics.getFont()
    local oR, oG, oB, oA = love.graphics.getColor()

    love.graphics.setFont(self.currentStyle.font)
    love.graphics.setColor(self.currentStyle.background)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, self.currentStyle.rounding)
    love.graphics.setColor(self.currentStyle.foreground)
    love.graphics.printf(self.label, self.x + self.width/2 - self.currentStyle.font:getWidth(self.label)/2, self.y + self.height/2 - self.currentStyle.font:getHeight()/2, self.currentStyle.font:getWidth(self.label))

    love.graphics.setFont(oFont)
    love.graphics.setColor(oR, oG, oB, oA)
end

return Button