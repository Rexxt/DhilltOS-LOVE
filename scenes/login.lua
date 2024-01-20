local LoginScreen = {
    load = function(self, game)
        self.GUI = DCL.Server()
    end,

    update = function(self, game, dt)
        self.GUI:update(dt)
    end,

    draw = function(self, game)
        local background = SYSTEM.images.LoginBackground
        local sx = love.graphics.getWidth() / background:getWidth()
        local sy = love.graphics.getHeight() / background:getHeight()
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(background, 0, 0, 0, sx, sy)

        FontManager:setFont(72)
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.printf(os.date("%X", os.time()), 50, 50, love.graphics.getWidth() - 100, 'left')
        FontManager:setFont(28)
        love.graphics.printf(os.date("%A, %b %d, %Y", os.time()), 50, 122, love.graphics.getWidth() - 100, 'left')

        self.GUI:draw()
    end
}

return LoginScreen