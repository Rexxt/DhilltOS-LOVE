local Transition = {
    canvas1 = love.graphics.newCanvas(),
    canvas2 = love.graphics.newCanvas(),

    pre = function(self, game, fromScene, toScene, data)
        love.graphics.setCanvas(self.canvas1)
        love.graphics.clear()
        if fromScene.draw then
            love.graphics.setColor(0,0,0)
            love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
            love.graphics.setColor(1,1,1)
            fromScene:draw(game)
        end
        
        love.graphics.setCanvas(self.canvas2)
        love.graphics.clear()
        if toScene.draw then
            love.graphics.setColor(0,0,0)
            love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
            love.graphics.setColor(1,1,1)
            toScene:draw(game)
        end
        love.graphics.setCanvas()
    end,

    draw = function(self, game, position, fromScene, toScene, data)
        r,g,b,a = love.graphics.getColor()
        love.graphics.setBlendMode("alpha")

        love.graphics.setColor(1,1,1,1-position)
        love.graphics.draw(self.canvas1, 0, 0)
        
        
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(self.canvas2, 0, math.smoothInterpolation(-self.canvas2:getHeight(), 0, position))

        love.graphics.setColor(r,g,b,a)
    end
}

return Transition