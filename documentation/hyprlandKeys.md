## Window Management
| Keybind                              | Function                                              |
| ------------------------------------ | ----------------------------------------------------- |
| `Super + Esc`                        | Force close focused App                               |
| `Super + Q`                          | Close Focused App                                     |
| `Super + ALT + Space`                | Toggle Floating/Tiled                                 |
| `Super + D`                          | Maximize Focused Window                               |
| `Super + F`                          | Fullscreen Focused Window                             |
| `Super + Left`                       | Focus Left                                            |
| `Super + Right`                      | Focus Right                                           |
| `Super + Up`                         | Focus Up                                              |
| `Super + Down`                       | Focus Down                                            |
| `Alt + Tab`                          | Cycle focus between windows in current workspace      |
| `Super + Tab`                        | Open Window Switcher                                  |
| `Super + Shift + Up`                 | Move focused window up                                |
| `Super + Shift + Right`              | Move focused window right                             |
| `Super + Shift + Left`               | Move focused window left                              |
| `Super + Shift + Down`               | Move focused window down                              |
| `Super + Shift + #(1-3)`             | Move to monitor #(1-3)                                |
| `Super + Shift + Scroll Up`          | Move window to previous monitor                       |
| `Super + Shift + Scroll Down`        | Move window to next monitor                           |
| `Super + Ctrl + Shift + Right`       | Move focused window to the next workspace             |
| `Super + Ctrl + Shift + Left`        | Move focused window to the previous workspace         |
| `Super + Ctrl + Shift + Scroll Up`   | Move focused window to the previous workspace (mouse) |
| `Super + Ctrl + Shift + Scroll Down` | Move focused window to the next workspace (mouse)     |
| `Super + Left Click`                 | Move Window (mouse)                                   |
| `Super + Right Click`                | Resize Window (mouse)                                 |
## Launcher
| Keybind              | Function                           |
| -------------------- | ---------------------------------- |
| `Super + Return`     | Open Terminal                      |
| `Super + E`          | Open File Manager                  |
| `Super + T`          | Open Text Editor                   |
| `Super + C`          | Open Calculater                    |
| `Super + W`          | Open Browser                       |
| `Ctrl + Shift + Esc` | Open System Monitor (Btop)         |
| `Super + Z`          | Open Noctalia Settings             |
| `Super + X`          | Open Noctalia Control Center       |
| `Super + Space`      | Open Noctalia Application launcher |
| `Super + Period`     | Open Noctalia Emoji Picker         |
| `Super + L`          | Lock Session                       |
| `Super + Alt + C`    | Toggle Session Menu                |
## Hardware Controls
| Keybinds          | Function                   |
| ----------------- | -------------------------- |
| `Volume Up`       | Increase volume            |
| `Volume Down`     | Decrease volume            |
| `Mute`            | Mute audio output          |
| `MicMute`         | Mute Microphone Input      |
| `Play/pause`      | Play/Pause Media           |
| `Next`            | Next Media Track           |
| `Previous`        | Previous Media track       |
| `Brightness Up`   | Increase Screen Brightness |
| `Brightness Down` | Decrease Screen Brightness |
## Utilities
| Keybind             | Function                  |
| ------------------- | ------------------------- |
| `Super + P`         | Color Picker              |
| `Print`             | Screen Capture & Annotate |
| `Super + Print`     | Screen Capture Monitor    |
| `Super + Shift + W` | Toggle Wallpaper Menu     |
| `Super + V`         | Open Clipboard History    |
| `Super + A`         | Open NotificationsX       |

## Workspaces & Monitors
| Keybinds                     | Function                                                           |
| ---------------------------- | ------------------------------------------------------------------ |
| `Super + [1-3]`              | Focus on monitor [1-3]                                             |
| `Super + Alt + [1-8]`        | Focus on workspace [1-8] (Absolute, Across all displays)           |
| `Super + Ctrl + [1-8]`       | Focus on workspace [1-8] (Relative, Workspaces on Current Display) |
| `Super + G`                  | Focus on gaming workspace                                          |
| `Super + Shift + G`          | Move window to gaming workspace                                    |
| `Super + Ctrl + Right `      | Focus next workspace                                               |
| `Super + Ctrl + Left`        | Focus previous workspace                                           |
| `Super + Ctrl + Down`        | Focus first empty workspace                                        |
| `Super + Scroll Down`        | Focus next workspace (mouse)                                       |
| `Super + Ctrl + Scroll Up`   | Focus next workspace (mouse alt)                                   |
| `Super + Scroll Up`          | Focus on previous workspace (mouse)                                |
| `Super + Ctrl + Scroll Down` | Focus on previous workspace (mouse alt)                            |
| `Super + S`                  | Toggle special workspace (scratchpad)                              |
| `Super + Shift + S`          | Move Window to special workspace                                   |
## Layout Dependent Bindings
These keybinds do different things dependent on the layout of the Curent Workspace.

| Keybind                       | In Dwindle                                                                                             | In Master                                    | In Scrolling                                                                                               | In Monocle               |
| ----------------------------- | ------------------------------------------------------------------------------------------------------ | -------------------------------------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------ |
| `Super + Alt + Right`         | N/a                                                                                                    | Rotate windows Clockwise                     | Swap column with one on the right                                                                          | Cycle to Next window     |
| `Super + Alt + Left`          | N/a                                                                                                    | Rotate windows counter clockwise             | Swap column with one on the Left                                                                           | Cycle to previous window |
| `Super + Alt + Up`            | Increases the size of the window relative to its children                                              | Increases the size of the master window      | Cycles through the hyprland preset sizes, in increasing order                                              | N/a                      |
| `Super + Alt + Down`          | Decreases the size of the window relative to its children                                              | Decrease the size of the master window       | Cycle through the hyprland preset sizes, in decreasing order                                               | N/a                      |
| `Super + Alt + K`             | Swaps the two halve of the current window(Ie swaps the position of the parent window and its chidlren) | Makes the focused window the master          | Merges Focused Window with Right column if alone, adds to the Right column if in column with other windows | N/a                      |
| `Super + Alt + J`             | Toggles the direction of the split between parent and children ie Horizontal/Vertical                  | N/a                                          | Merges Focused Window with left column if alone, adds to the left column if in column with other windows   | N/a                      |
| `Super + Alt + Shift + Up`    | N/a                                                                                                    | Put the master window on top of workspace    | N/a                                                                                                        | N/a                      |
| `Super + Alt + Shift + Down`  | N/a                                                                                                    | Put the master window on bottom of workspace | N/a                                                                                                        | N/a                      |
| `Super + Alt + Shift + Left`  | N/a                                                                                                    | Put the master window on left of workspace   | N/a                                                                                                        | N/a                      |
| `Super + Alt + Shift + Right` | N/a                                                                                                    | Put the master window on right of workspace  | N/a                                                                                                        | N/a                      |
