-- collection of styles for components

local default_font = love.graphics.newFont(18)

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
                font = default_font,
            },
            hover = {
                rounding = 10,
                background = {0, 0.25, 0.5, 1},
                foreground = {1, 1, 1, 1},
                outline = {
                    size = 0,
                    color = {1, 1, 1, 1},
                },
                font = default_font,
            },
            click = {
                rounding = 10,
                background = {1, 1, 1, 1},
                foreground = {0, 0.5, 1, 1},
                outline = {
                    size = 0,
                    color = {1, 1, 1, 1},
                },
                font = default_font,
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
                font = default_font,
            },
            focus = {
                rounding = 10,
                background = {1, 1, 1, 1},
                foreground = {0, 0, 0, 1},
                outline = {
                    size = 2,
                    color = {0.5, 0.5, 0.5, 1},
                },
                font = default_font,
            },
        },
    },
}