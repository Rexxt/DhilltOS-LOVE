local Boot = {
    load = function(self, game)
        self.bootTimer = game.timer(0, 5)
    end,

    update = function(self, game, dt)
        CURSORSTATE = 'hidden'
        self.bootTimer:update(dt)
        if self.bootTimer:progress() >= 1 then
            local users = love.filesystem.getDirectoryItems('vstorage/usr/')
            game:switchSceneByTransition((#users >= 1) and "login" or "oobe", "slideIn", 0.75)
        end
    end,

    draw = function(self, game)
        local image = SYSTEM.images.BootLogo
        local formedSin = (math.sin(love.timer.getTime()*math.pi)+1)/2
        local slideUpProgress = math.max(0, math.min(1, (self.bootTimer:progress())/0.1))
        local slideUpProgressSmooth = math.smoothInterpolation(0, 1, slideUpProgress)
        
        love.graphics.setColor(1, 1-formedSin, 1-formedSin, slideUpProgress^3)
        love.graphics.draw(image, love.graphics.getWidth()/2-image:getWidth()/2, love.graphics.getHeight()/(1+slideUpProgressSmooth)-image:getHeight()/2)

        if love.keyboard.isDown('space') then
            love.graphics.draw(image, love.graphics.getWidth()/2-image:getWidth()/2, love.graphics.getHeight()/2-image:getHeight()/2, love.timer.getTime()%1*math.pi*24)
        end
    end
}

return Boot