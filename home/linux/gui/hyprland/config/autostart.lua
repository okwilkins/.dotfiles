-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia-shell")
    hl.exec_cmd("zen -P default")
end)
