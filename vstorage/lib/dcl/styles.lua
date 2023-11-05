-- collection of styles for components

return {
    Button = {
        primary = {
            base = {
                rounding = 10,
                background = {0, 0.5, 1, 1},
                foreground = {1, 1, 1, 1},
                outline = {
                    size = 0,
                    color = {1, 1, 1, 1},
                },
                font = love.graphics.newFont(18),
            },
            hover = {
                rounding = 10,
                background = {0, 0.25, 0.5, 1},
                foreground = {1, 1, 1, 1},
                outline = {
                    size = 0,
                    color = {1, 1, 1, 1},
                },
                font = love.graphics.newFont(18),
            },
            click = {
                rounding = 10,
                background = {1, 1, 1, 1},
                foreground = {0, 0.5, 1, 1},
                outline = {
                    size = 0,
                    color = {1, 1, 1, 1},
                },
                font = love.graphics.newFont(18),
            },
        },
    },
    TextBox = {
        primary = {
            base = {
                rounding = 10,
                background = {1, 1, 1, 1},
                foreground = {0, 0, 0, 1},
                outline = {
                    size = 1,
                    color = {0.5, 0.5, 0.5, 1},
                },
                font = love.graphics.newFont(18),
            },
            focus = {
                rounding = 10,
                background = {1, 1, 1, 1},
                foreground = {0, 0, 0, 1},
                outline = {
                    size = 2,
                    color = {0.5, 0.5, 0.5, 1},
                },
                font = love.graphics.newFont(18),
            },
        },
    },
}