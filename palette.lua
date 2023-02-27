--[[Theme Palettes]] local Themes = {
    _colors = {
        --[[it is recommended to put palettes
            and alpha values here for your themes
            if you will using color values multiple times]]
        builtin_dark = {
            main = {0.141, 0.152, 0.160},
            text = {0.976, 0.976, 0.976},
            text_alpha = 1,
            text_hover_alpha = 0.5,
            text_disabled_alpha = 0.25,
            element = {0.278, 0.278, 0.278},
            element_hover = {0.349, 0.349, 0.349},
            dark_outline = {0.121, 0.121, 0.121}

        },
        -- builtin_light = { 0.976, 0.976, 0.976 },
        builtin_palette_1 = {
            _secondary = 0.5,
            c1 = {0.914, 0.118, 0.388},
            c2 = {0.761, 0.094, 0.357},
            c3 = {0.612, 0.153, 0.69},
            c4 = {0.341, 0.153, 0.69},
            c5 = {0.153, 0.165, 0.69},
            c6 = {0.153, 0.42, 0.69},
            c7 = {0.341, 0.675, 0.863},
            c8 = {0.341, 0.863, 0.745},
            c9 = {0.376, 0.776, 0.537}
        }
    }
}

Themes.DefaultDark = {
    DisplayName = "Default Dark",
    BackgroundColor = Themes._colors.builtin_dark.main,
    DefaultColor = Themes._colors.builtin_dark.main,
    _ss = { --[[style sheets]]
        DEFAULT = {
            rgb = Themes._colors.builtin_dark.main,
            text_rgb = Themes._colors.builtin_dark.text
        },
        clearButton = {
            transitionTime = 0.25,
            rgb = Themes._colors.builtin_dark.element,
            opacity = 0,
            rbg_mouseover = Themes._colors.builtin_dark.element_hover,
            opacity_mouseover = 1,
            border = 1,
            borderRadiusX = 20,
            borderRadiusY = 20,
            border_rgb = Themes._colors.builtin_palette_1.c3,
            border_opacity = 1
        },
        menuPanel = {
            opacity = 0.75
        },
        menuButton = {
            -- transitionTime = 0.25,
            rgb = Themes._colors.builtin_dark.main,
            opacity = 1,
            rgb_mouseover = Themes._colors.builtin_dark.element,
            opacity_mouseover = 0.5,
            border = 5,
            borderRadiusX = 20,
            borderRadiusY = 20,
            border_rgb = Themes._colors.builtin_palette_1.c6,
            border_opacity = 0.5
        },
        editorTab = {
            -- transitionTime = 0.25,
            rgb = Themes._colors.builtin_dark.element,
            opacity = 1,
            rgb_mouseover = Themes._colors.builtin_dark.element_hover,
            opacity_mouseover = 1,
            border = 1,
            border_rgb = Themes._colors.builtin_dark.dark_outline,
            border_opacity = 1,
            text_rgb = Themes._colors.builtin_dark.text,
            text_opacity = Themes._colors.builtin_dark.text_alpha
        },
        editorPanel = {
            opacity = 1
        },
        textOnly = {
            opacity = 0,
            text_rgb = Themes._colors.builtin_dark.text,
            text_opacity = Themes._colors.builtin_dark.text_alpha
        },
        textBox = {
            text_rgb = {1, 1, 1},
            text_opacity = Themes._colors.builtin_dark.text_alpha,
            rgb = Themes._colors.builtin_dark.text,
            opacity = 1
        }
    }
}

return Themes
