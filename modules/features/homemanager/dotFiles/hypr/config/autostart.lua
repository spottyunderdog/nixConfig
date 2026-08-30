-- Auto-start config
-- if you dont use UWSM add your auto start programs here, otherwise use XDG autostart https://wiiki.archlinux.org/title/XDG_Autostart
local launchPrefix = "uwsm app -- " 
hl.on("hyprland.start", function ()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("noctalia")
    -- hl.exec_cmd("~/.config/hypr/hyprPortalRelaunch.sh")
    hl.exec_cmd("kwalletd6")
    hl.exec_cmd("xhost +SI:localuser:root")
    hl.exec_cmd("systemctl --user start hyprland-session.target") -- Comment Out if not using UWSM For autostarting
    -- hl.exec_cmd(launchPrefix .. "easyeffects --hide-window --service-mode")
    -- hl.exec_cmd("openrgb")
    -- hl.exec_cmd("/steam-library/steamlink.sh")
    -- hl.exec_cmd(launchPrefix .. "steam", { workspace = "16" })
    -- hl.exec_cmd(launchPrefix .. "vesktop --ozone-platform-hint=auto --enable-features=VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE,VaapiOnNvidiaGPUs", { workspace = "15" })
    -- hl.exec_cmd(launchPrefix .. "kitty", { workspace = "5" })
    -- hl.exec_cmd(launchPrefix .. "flatpak run app.zen_browser.zen", { workspace = 4})
    
end)

hl.on("hyprland.shutdown", function()
    os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)
