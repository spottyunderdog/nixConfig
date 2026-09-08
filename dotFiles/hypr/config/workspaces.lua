-- Workspace rules wiki https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- Add your workspace rules here. Increment the workspace number as you go. Do not have duplicate workspaces.

-- Gaming Workspace
hl.workspace_rule({ workspace = "name:gaming", monitor = PRIMARY_MONITOR })



-- Primary Monitor
hl.workspace_rule({ workspace = "1", 		monitor = PRIMARY_MONITOR, persistent = true, layout = "monocle" })
hl.workspace_rule({ workspace = "2", 		monitor = PRIMARY_MONITOR, persistent = true, layout = "dwindle" })
hl.workspace_rule({ workspace = "3",		monitor = PRIMARY_MONITOR, persistent = true, default = true })
hl.workspace_rule({ workspace = "4", 		monitor = PRIMARY_MONITOR, persistent = true })
hl.workspace_rule({ workspace = "5", 		monitor = PRIMARY_MONITOR, persistent = true })
hl.workspace_rule({ workspace = "6", 		monitor = PRIMARY_MONITOR, persistent = true })
hl.workspace_rule({ workspace = "7", 		monitor = PRIMARY_MONITOR, persistent = true })
hl.workspace_rule({ workspace = "8", 		monitor = PRIMARY_MONITOR, persistent = true })

-- Monitor 2
-- hl.workspace_rule({ workspace = "9", 		monitor = MONITOR2, persistent = true, layout = "monocle" })
-- hl.workspace_rule({ workspace = "10",		monitor = MONITOR2, persistent = true, layout = "dwindle" })
-- hl.workspace_rule({ workspace = "11", 		monitor = MONITOR2, persistent = true, default = true })
-- hl.workspace_rule({ workspace = "12", 		monitor = MONITOR2, persistent = true })
-- hl.workspace_rule({ workspace = "13", 		monitor = MONITOR2, persistent = true })
-- hl.workspace_rule({ workspace = "14", 		monitor = MONITOR2, persistent = true })
-- hl.workspace_rule({ workspace = "15", 		monitor = MONITOR2, persistent = true })
-- hl.workspace_rule({ workspace = "16", 		monitor = MONITOR2, persistent = true })
