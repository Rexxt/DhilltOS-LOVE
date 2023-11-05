local OOBEScreen = {
    load = function(self, game)
        self.titleFont = love.graphics.newFont(36)
        self.mainFont = love.graphics.newFont(18)
        self.GUI = DCL.Server()

        self.NextButton = DCL.Button(love.graphics.getWidth()/3*2-215, love.graphics.getHeight()-65, 200, 50, 'Restart')
        function self.NextButton:mouseDown(server)
            game.toasts:post('info', 'Release the button to restart.')
        end
        function self.NextButton:mouseUp(server)
            game.toasts:post('success', 'Restarting!')
            game:switchSceneByTransition("initial", "slideIn", 0.75)
        end
        self.GUI:add('next', self.NextButton)

        self.TestTextBox = DCL.TextBox(200, 200, 500, 50)
        self.GUI:add('ttb', self.TestTextBox)

        self.TestTextBox2 = DCL.TextBox(200, 250, 500, 50)
        self.GUI:add('ttb2', self.TestTextBox2)
    end,

    update = function(self, game, dt)
        local x, y = love.mouse.getPosition()
        self.GUI:update(dt)
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