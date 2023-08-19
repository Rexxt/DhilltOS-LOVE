return function(self, toast, decay, x, y)
    local padding = love.graphics.getHeight()/100
    local icon = SYSTEM.icons[toast.type]
    local scale = self.toastFont:getHeight()/icon:getWidth()
    local toastWidth = self.toastFont:getWidth(toast.text) + 3*padding + self.toastFont:getHeight()
    local toastHeight = self.toastFont:getHeight() + 2*padding

    local toastColours = {
        success = {0.3,   1, 0.3},
        debug = {0.6, 0.6, 0.6},
        info  = {0.5, 0.7, 0.9},
        warn  = {1,   0.7, 0.1},
        error = {1,   0.3, 0.3},
    }
    local colour = toastColours[toast.type]

    -- keeping original colour and font
    r, g, b, a = love.graphics.getColor()
    font = love.graphics.getFont()

    local toastAlpha = 1
    if love.timer.getTime() - toast.timePosted >= decay - 1 then
        local animRate = love.timer.getTime() - toast.timePosted - decay + 1
        toastAlpha = 1 - animRate
    end
    local toastAnimatedY = -toastHeight
    if love.timer.getTime() - toast.timePosted < 0.125 then
        toastAnimatedY = math.lerp(-toastHeight, padding, (love.timer.getTime() - toast.timePosted )*8)
    else
        toastAnimatedY = y
    end

    local actualX = love.graphics.getWidth()/2 - toastWidth/2

    love.graphics.setFont(self.toastFont)
    love.graphics.setColor(0.2, 0.2, 0.2, toastAlpha)
    love.graphics.rectangle('fill', actualX, toastAnimatedY, toastWidth, toastHeight, toastHeight/2)

    love.graphics.setColor(colour[1], colour[2], colour[3], toastAlpha)
    love.graphics.draw(icon, actualX + padding, toastAnimatedY + padding, 0, scale, scale)
    
    love.graphics.setColor(1, 1, 1, toastAlpha)
    love.graphics.print(toast.text, actualX + 2*padding + self.toastFont:getHeight(), toastAnimatedY + padding)

    -- restoring original colour and font
    love.graphics.setColor(r,g,b,a)
    love.graphics.setFont(font)

    return toastHeight*math.min((love.timer.getTime() - toast.timePosted)*8, 1) -- stacked rendering purposes
end