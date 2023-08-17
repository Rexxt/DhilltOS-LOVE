local LoginScreen = {
    load = function(self, game)
        self.GUI = DCL.Server()
        self.Test = DCL.Button(200, 200, 250, 50, 'Click me!')
        self.GUI:add('test', self.Test)
    end,

    update = function(self, game, dt)
        local x, y = love.mouse.getPosition()
        self.GUI:update(dt)
        if self.Test.clicked then
            self.Test.x = (self.Test.x + x)/2
            self.Test.y = (self.Test.y + y)/2
        end
    end,

    draw = function(self, game)
        local background = SYSTEM.images.LoginBackground
        local sx = love.graphics.getWidth() / background:getWidth()
        local sy = love.graphics.getHeight() / background:getHeight()
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(background, 0, 0, 0, sx, sy)
        self.GUI:draw()
    end
}

return LoginScreen