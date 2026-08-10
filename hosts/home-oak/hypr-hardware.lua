-- https://wiki.hypr.land/Configuring/Basics/Monitors/
-- To find monitors, run: hyprctl monitors
--   highres:      get the best possible resolution
--   auto:         position automatically
--   1.5:          scale to 1.5 times
--   bitdepth,10:  enable 10 bit support

-- Monitor DP-4 (ID 0):
--         description: Samsung Electric Company U28E850 HTPJ300970
--         availableModes: 3840x2160@60.00Hz 2560x1440@59.95Hz 1920x1080@60.00Hz 1920x1080@59.94Hz 1680x1050@59.95Hz 1600x900@60.00Hz 1280x1024@60.02Hz 1440x900@59.89Hz 1280x800@59.81Hz 1280x720@60.00Hz 1024x768@60.00Hz 800x600@60.32Hz 800x600@56.25Hz 640x480@59.94Hz
--
-- Monitor DP-5 (ID 1):
--         description: LG Electronics LG ULTRAGEAR 101NTXRLQ914
--         availableModes: 2560x1440@143.97Hz 2560x1440@120.00Hz 2560x1440@99.95Hz 2560x1440@59.95Hz 1920x1080@74.91Hz 1920x1080@60.00Hz 1920x1080@59.94Hz 1920x1080@50.00Hz 1680x1050@59.95Hz 1600x900@60.00Hz 1280x1024@75.03Hz 1280x1024@60.02Hz 1280x800@59.81Hz 1152x864@59.96Hz 1280x720@60.00Hz 1280x720@59.94Hz 1280x720@50.00Hz 1024x768@75.03Hz 1024x768@60.00Hz 800x600@75.00Hz 800x600@60.32Hz 720x480@59.94Hz 640x480@75.00Hz 640x480@59.94Hz 640x480@59.93Hz
--
-- Monitor HDMI-A-5 (ID 2):
--         description: LG Electronics LG TV SSCR2 0x01010101
--         availableModes: 3840x2160@60.00Hz 4096x2160@119.88Hz 4096x2160@100.00Hz 4096x2160@59.94Hz 4096x2160@50.00Hz 4096x2160@29.97Hz 4096x2160@25.00Hz 4096x2160@24.00Hz 4096x2160@23.98Hz 3840x2160@119.88Hz 3840x2160@100.00Hz 3840x2160@59.94Hz 3840x2160@50.00Hz 3840x2160@29.97Hz 3840x2160@25.00Hz 3840x2160@23.98Hz 2560x1440@120.00Hz 1920x1080@119.88Hz 1920x1080@100.00Hz 1920x1080@60.00Hz 1920x1080@59.94Hz 1920x1080@50.00Hz 1920x1080@29.97Hz 1920x1080@25.00Hz 1920x1080@23.98Hz 1280x1024@60.02Hz 1152x864@60.00Hz 1280x720@59.94Hz 1280x720@50.00Hz 1024x768@60.00Hz 800x600@60.32Hz 720x576@50.00Hz 720x480@59.94Hz 640x480@59.95Hz 640x480@59.94Hz 640x480@59.93Hz

hl.monitor({ output = "DP-4",     mode = "highres@highrr", position = "0x0",    scale = 1.5, bitdepth = 10 })
hl.monitor({ output = "DP-5",     mode = "highres@highrr", position = "2560x0", scale = 1.0, bitdepth = 10 })
-- Only used to connect TV, when needed
hl.monitor({ output = "HDMI-A-5", mode = "highres@highrr", position = "5120x0", scale = 2.0, bitdepth = 10 })

local ultra = "desc:LG Electronics LG ULTRAGEAR 101NTXRLQ914"
local sammy = "desc:Samsung Electric Company U28E850 HTPJ300970"

for i = 1, 9 do
    hl.workspace_rule({ workspace = i, monitor = i % 2 == 1 and ultra or sammy })
end
