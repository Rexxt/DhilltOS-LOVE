local FontManager = {
    loadedFonts = {},
    loadFont = function(self, ...)
        local k = {...}
        if not self.loadedFonts[k] then
            self.loadedFonts[k] = love.graphics.newFont(...)
        end
        return self.loadedFonts[k]
    end,
    setFont = function(self, ...)
        love.graphics.setFont(self:loadFont(...))
    end
}

return FontManager