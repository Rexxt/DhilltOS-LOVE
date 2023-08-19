local LoginScreen = {
    load = function(self, game)
        self.GUI = DCL.Server()
        self.Test = DCL.Button(200, 200, 250, 50, 'Click me!')
        function self.Test:mouseDown(server)
            game.toasts:post('info', self.x..';'..self.y)
        end
        function self.Test:mouseUp(server)
            game.toasts:post('success', self.x..';'..self.y)
        end
        self.GUI:add('test', self.Test)
    end,

    update = function(self, game, dt)
        local x, y = love.mouse.getPosition()
        self.GUI:update(dt)
        if self.Test.isMouseIn then
            CURSORSTATE = 'text'
        end
        if self.Test.isMouseDown then
            self.Test.x = x - self.Test.width/2
            self.Test.y = y - self.Test.height/2
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