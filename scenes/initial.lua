local Boot = {
    load = function(self, game)
        self.bootTimer = game.timer(0, 5)
    end,

    update = function(self, game, dt)
        self.bootTimer:update(dt)
        if self.bootTimer:progress() >= 1 then
            game:switchSceneInstant 'login'
        end
    end,

    draw = function(self, game)
        local image = SYSTEM.images.BootLogo
        local formedSin = (math.sin(love.timer.getTime()*math.pi)+1)/2
        love.graphics.setColor(1, 1-formedSin, 1-formedSin, 1 - self.bootTimer:progress()^2)
        love.graphics.draw(image, love.graphics.getWidth()/2-image:getWidth()/2, love.graphics.getHeight()/2-image:getHeight()/2)

        love.graphics.setColor(1, 1, 1, 1 - self.bootTimer:progress()^3)
        love.graphics.setLineWidth(love.graphics.getWidth()/160)
        love.graphics.arc('line', 'open', love.graphics.getWidth()/2, 7*love.graphics.getHeight()/8, love.graphics.getWidth()/40, love.timer.getTime()*math.pi, love.timer.getTime()*math.pi + self.bootTimer:progress()*math.pi*2)

        if love.keyboard.isDown('space') then
            love.graphics.draw(image, love.graphics.getWidth()/2-image:getWidth()/2, love.graphics.getHeight()/2-image:getHeight()/2, love.timer.getTime()%1*math.pi*24)
        end
    end
}

return Boot