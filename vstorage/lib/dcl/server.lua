-- graphical user interface server
local GUI = Object:extend()

function GUI:new()
    self.components = {}
    self.focus = ''
end

function GUI:add(address, component)
    component.address = address
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
            if self.components[self.focus] ~= nil and self.components[self.focus].focus then
                self.components[self.focus].focus = false
            end
            self.focus = k
            self.components[self.focus].focus = true
            return self.focus
        end
        v:update(self, dt)
    end
    self.grabFocus = nil
end

function GUI:textinput(t)
    if self.components[self.focus] ~= nil and self.components[self.focus]:is(using "dcl.textbox") then
        self.components[self.focus]:textinput(self, t)
    end
end

function GUI:keypressed(key)
    if self.components[self.focus] ~= nil and self.components[self.focus]:is(using "dcl.textbox") then
        self.components[self.focus]:keypressed(self, key)
    end
end

function GUI:draw()
    for k, v in pairs(self.components) do
        v:draw(self)
    end
end

return GUI