-- collection of styles for components

return {
    Button = {
        primary = {
            base = {
                rounding = 10,
                background = {0, 0.5, 1, 1},
                foreground = {1, 1, 1, 1},
                font = love.graphics.newFont(18)
            },
            hover = {
                rounding = 10,
                background = {0, 0.25, 0.5, 1},
                foreground = {1, 1, 1, 1},
                font = love.graphics.newFont(18)
            },
            click = {
                rounding = 10,
                background = {1, 1, 1, 1},
                foreground = {0, 0.5, 1, 1},
                font = love.graphics.newFont(18)
            },
        },
    },
}