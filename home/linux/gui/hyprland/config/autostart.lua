-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    -- Import the display environment before enabling portal activation.
    hl.exec_cmd(
        "dbus-update-activation-environment --systemd"
            .. " DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE"
            .. " && systemctl --user start hyprland-session.target"
    )

    hl.exec_cmd("noctalia")
    hl.exec_cmd("zen -P default")
end)

hl.on("hyprland.shutdown", function()
    os.execute("systemctl --user stop hyprland-session.target")
end)
