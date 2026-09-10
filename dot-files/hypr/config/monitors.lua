-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Example: output can be found with hyprctl monitors. Edit variables.lua for the monitor outputs instead of here directly
-- hl.monitor({
--     output    = "MONITOR1",
--     mode      = "1920x1080@60",
--     position  = "0x0",
--     scale     = "1",
-- })

-- Put your monitor configs here.
-- I recommend using the "monitor" variables found in variables.lua 
-- instead of hardcoding the monitor names here,
-- as it will make it easier to change them in the future. 
-- (for exemple, if you want to change primary monitors, etc.)


-- Catchall for any new monitors that may be added in the future, 
-- this will set them to preferred mode and auto position them
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "1",
})
