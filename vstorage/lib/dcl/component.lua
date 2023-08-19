-- component masterclass, gives component a set of properties
local Component = Object:extend()

function Component:new()
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.label = label
    self.style = {}
    self.isMouseIn = false
    self.isMouseDown = false
    self.currentStyle = {}
end

function Component:update(server, dt)
    local events = {}
    local x, y = love.mouse.getPosition()
    if x >= self.x and x <= (self.x + self.width) and y >= self.y and y <= (self.y + self.height) then
        if not self.isMouseIn then
            table.insert(events, 'mouseIn')
            self.isMouseIn = true
            self.currentStyle = self.style.hover
        end
        if love.mouse.isDown(1) then
            if not self.isMouseDown then
                table.insert(events, 'mouseDown')
                self.isMouseDown = true
                self.currentStyle = self.style.click
            end
        elseif self.isMouseDown then
            table.insert(events, 'mouseUp')
            self.isMouseDown = false
            self.currentStyle = self.style.hover
        end
    else
        if self.isMouseIn then
            table.insert(events, 'mouseOut')
            self.isMouseIn = false
        end
        if self.isMouseDown then
            table.insert(events, 'mouseUp')
            self.isMouseDown = false
        end
        self.currentStyle = self.style.base
    end
    return events
end

function Component:draw(server)
end

return Component