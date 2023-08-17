-- graphical user interface server
local Button = Object:extend()

function Button:new(x, y, width, height, label)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.label = label
    self.style = using("dcl.styles").Button.primary
    self.hovered = false
    self.clicked = false
    self.currentStyle = self.style.base
end

function Button:update(server, dt)
    local x, y = love.mouse.getPosition()
    if x >= self.x and x <= (self.x + self.width) and y >= self.y and y <= (self.y + self.height) then
        self.hovered = true
        if love.mouse.isDown(1) then
            self.clicked = true
            self.currentStyle = self.style.click
        else
            self.clicked = false
            self.currentStyle = self.style.hover
        end
    else
        self.hovered = false
        self.currentStyle = self.style.base
    end
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