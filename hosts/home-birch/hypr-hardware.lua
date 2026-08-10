-- https://wiki.hypr.land/Configuring/Basics/Monitors/
-- To find monitors, run: hyprctl monitors
--   highres:      get the best possible resolution
--   auto:         position automatically
--   1.5:          scale to 1.5 times
--   bitdepth,10:  enable 10 bit support

-- Monitor eDP-1 (ID 0):
--         description: Sharp Corporation 0x149A
--         availableModes: 1920x1080@60.00Hz

hl.monitor({ output = "eDP-1", mode = "highres@highrr", position = "0x0", scale = 1.0, bitdepth = 10 })

hl.config({
    input = {
        touchpad = {
            natural_scroll = true,
            scroll_factor  = 0.2,
        },
    },
})

-- Mice
hl.device({ name = "syna2393:00-06cb:7a13-touchpad", sensitivity = 0.25, accel_profile = "adaptive" })

-- Keyboards
hl.device({ name = "at-translated-set-2-keyboard", kb_layout = "gb" })
