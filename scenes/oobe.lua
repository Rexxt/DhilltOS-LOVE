local OOBEScreen = {
    load = function(self, game)
        self.titleFont = love.graphics.newFont(36)
        self.mainFont = love.graphics.newFont(18)
        self.GUI = DCL.Server()

        self.NextButton = DCL.Button(love.graphics.getWidth()/3*2-115, love.graphics.getHeight()-65, 100, 50, 'Next')
        function self.NextButton:mouseDown(server)
            game.toasts:post('info', self.x..';'..self.y)
        end
        function self.NextButton:mouseUp(server)
            game.toasts:post('success', self.x..';'..self.y)
        end
        self.GUI:add('next', self.NextButton)

        self.TestTextBox = DCL.TextBox(200, 200, 500, 50)
        self.GUI:add('ttb', self.TestTextBox)
    end,

    update = function(self, game, dt)
        local x, y = love.mouse.getPosition()
        self.GUI:update(dt)
        if self.NextButton.isMouseDown then
            self.NextButton.x = x - self.NextButton.width/2
            self.NextButton.y = y - self.NextButton.height/2
        end
    end,
    
    textinput = function(self, game, t)
        self.GUI:textinput(t)
    end,

    keypressed = function(self, game, key)
        self.GUI:keypressed(key)
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