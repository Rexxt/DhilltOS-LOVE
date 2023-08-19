-- graphical user interface server
local GUI = Object:extend()

function GUI:new()
    self.components = {}
    self.focus = ''
end

function GUI:add(address, component)
    self.components[address] = component
end

function GUI:remove(address)
    self.components[address] = nil
    if self.focus == address then
        self.focus = 0
    end
end

function GUI:update(dt)
    for k, v in pairs(self.components) do
        function self:grabFocus()
            self.focus = k
            return self.focus
        end
        v:update(self, dt)
    end
    self.grabFocus = nil
end

function GUI:draw()
    for k, v in pairs(self.components) do
        v:draw(self)
    end
end

return GUI