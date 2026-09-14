---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "rofi -show drun"
local browser     = "flatpak run app.zen_browser.zen"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("rofi -show emoji -modi emoji"))
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
-- hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Window commands
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only
-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, function()
        local mon = hl.get_active_monitor()
        if mon.active_workspace.id == i then
            -- If trying to switch to current workspace, move to previous workspace
            -- This is useful when alternating between two different workspaces
            hl.dispatch(hl.dsp.focus({ workspace = "previous" }))
        else
            -- Otherwise move to desired workspace
            hl.dispatch(hl.dsp.focus({ workspace = i }))
        end
    end)

    -- Move window to a different workspace and switch to that workspace
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    -- Move window to a different workspace but keep current workspace
    hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Fullscreen - Window takes up the entire working space, keeping the margins.
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
-- Fullscreen - Window takes up the entire screen.
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Launch notification panel
hl.bind(mainMod .. " + N", hl.dsp.focus({ direction = "left" }))
-- Open clipboard
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
-- Lock screen
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("noctalia msg session lock"))
-- Cycle power profile
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("noctalia msg power-cycle"))
-- Voice typing
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("/home/matteogeraldo05/hyprwhspr/config/hyprland/hyprwhspr-tray.sh record"))

-- Open sessions menu
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))

-- Select a region, save it, and copy to clipboard
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("noctalia msg screenshot-region"))
-- Capture the entire screen, save it, and copy to clipboard
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen all"))

-- Toggle wallpapers
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("noctalia msg panel-toggle wallpaper"))

-- Cycle workspaces
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
