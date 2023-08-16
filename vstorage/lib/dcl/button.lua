-- graphical user interface server
local Button = Object:extend()

function Button:new(x, y, width, height, label)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.label = label
    self.style = {
        base = {
            rounding = 5,
            background = {1, 1, 1, 1},
            foreground = {0, 0, 0, 1},
            font = love.graphics.newFont(12)
        },
        hover = {
            rounding = 5,
            background = {0.6, 0.6, 0.6, 1},
            foreground = {0, 0, 0, 1},
            font = love.graphics.newFont(12)
        },
        click = {
            rounding = 5,
            background = {0.2, 0.2, 0.2, 1},
            foreground = {1, 1, 1, 1},
            font = love.graphics.newFont(12)
        },
    }
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
    love.graphics.setColor(self.currentStyle.background)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, self.currentStyle.rounding)
    love.graphics.setColor(self.currentStyle.foreground)
    love.graphics.printf(self.label, self.x + self.width/2 - self.currentStyle.font:getWidth(self.label)/2, self.y + self.height/2 - self.currentStyle.font:getHeight()/2, self.currentStyle.font:getWidth(self.label))
end

return Button