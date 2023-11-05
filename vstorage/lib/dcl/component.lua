-- component masterclass, gives component a set of properties
local Component = Object:extend()

function Component:new()
    self.x = 0
    self.y = 0
    self.width = 0
    self.height = 0
    self.label = "text"
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
        end
        if love.mouse.isDown(1) then
            if not self.isMouseDown then
                table.insert(events, 'mouseDown')
                self.isMouseDown = true
            end
        elseif self.isMouseDown then
            table.insert(events, 'mouseUp')
            self.isMouseDown = false
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
    end
    return events
end

function Component:draw(server)
end

return Component