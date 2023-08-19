local OOBEScreen = {
    load = function(self, game)
        self.titleFont = love.graphics.newFont(36)
        self.mainFont = love.graphics.newFont(18)
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
        local background = SYSTEM.images.OOBEGradient
        local sx = love.graphics.getWidth() / background:getWidth()
        local sy = love.graphics.getHeight() / background:getHeight()
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(background, 0, 0, 0, sx, sy)

        local logo = SYSTEM.images.BootLogo
        local ls = love.graphics.getWidth() / 1920
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(logo, love.graphics.getWidth()/6*5, love.graphics.getHeight()/2, love.timer.getTime()/30*math.pi, ls, ls, logo:getWidth()/2*ls, logo:getHeight()/2*ls)

        love.graphics.setColor(1, 1, 1, 0.8)
        love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth()/3*2, love.graphics.getHeight(), ls)

        love.graphics.setColor(0.2, 0.2, 0.2, 1)
        love.graphics.setFont(self.titleFont)
        love.graphics.printf('Welcome to DhilltOS!', 30, 30, love.graphics.getWidth() - 60, 'left')
        self.GUI:draw()
    end
}

return OOBEScreen