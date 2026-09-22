-- Look and feel configuration

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        extend_border_grab_area = 10,
        resize_on_border = true,
    layout = "scrolling"
    },
    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.5,
        follow_min_visible = 0.25
    },
    decoration = {
        dim_special = 0.3,
        rounding = 20,
        rounding_power = 2,

        active_opacity = 0.95,
        inactive_opacity = 0.85,
        fullscreen_opacity = 1,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            vibrancy = 0.1696,
            special = true,
        },
    },
})
