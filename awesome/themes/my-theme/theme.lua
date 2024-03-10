---------------------------
-- James' awesome theme --
---------------------------


-- Standard awesome library
local themes_path = require("gears.filesystem").get_themes_dir()
local dpi = require("beautiful.xresources").apply_dpi
local gears = require('gears')
local awful = require("awful")

local theme = {}
local my_themes_path = awful.util.getdir("config") .. "themes/my-theme/"

-- theme.wallpaper = themes_path .. "zenburn/zenburn-background.png"
theme.wallpaper = my_themes_path .. "wallpapers/city-wallpaper.jpg"

theme.font = "Fira Mono 10"


-- foreground colors (text)
theme.fg_normal  = "#cdd6f4"
theme.fg_focus   = "#cba6f7"
theme.fg_urgent  = "#cdd6f4"

-- background colors
theme.bg_normal  = "#1E1E2E"
theme.bg_focus   = "#1E1E2E"
theme.bg_urgent  = "#f38ba8"
theme.bg_systray = theme.bg_normal


-- Borders
theme.useless_gap   = dpi(0)
theme.border_width  = dpi(2)
theme.border_normal = "#b4befe"
theme.border_focus  = "#b4befe"
theme.border_marked = "#f38ba8"
theme.border_focus  = "#cba6f7"
theme.border_marked = "#cba6f7"

-- tasklist
theme.tasklist_bg_focus = "#1E1E2E"

-- titlelist
theme.titlebar_bg_focus  = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus  = theme.fg_focus

-- taglist
theme.taglist_bg_focus = "#89dceb"
theme.taglist_fg_focus = "#11111b"
theme.taglist_font = "Fira Mono 9"

-- tasklist
theme.tasklist_plain_task_name = true -- don't show task status (ie. maximized, floating, etc)
theme.tasklist_disable_task_name = true -- only show task logo in tasklist

theme.mouse_finder_color = "#CC9393"

theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)



-- theme.awesome_icon           = themes_path .. "zenburn/awesome-icon.png"
theme.awesome_icon           = my_themes_path .. "icons/wibar/linux-penguin-head.png"
theme.menu_submenu_icon      = themes_path .. "default/submenu.png"


theme.layout_tile       = themes_path .. "zenburn/layouts/tile.png"
theme.layout_tileleft   = themes_path .. "zenburn/layouts/tileleft.png"
theme.layout_tilebottom = themes_path .. "zenburn/layouts/tilebottom.png"
theme.layout_tiletop    = themes_path .. "zenburn/layouts/tiletop.png"
theme.layout_fairv      = themes_path .. "zenburn/layouts/fairv.png"
theme.layout_fairh      = themes_path .. "zenburn/layouts/fairh.png"
theme.layout_spiral     = themes_path .. "zenburn/layouts/spiral.png"
theme.layout_dwindle    = themes_path .. "zenburn/layouts/dwindle.png"
theme.layout_max        = themes_path .. "zenburn/layouts/max.png"
theme.layout_fullscreen = themes_path .. "zenburn/layouts/fullscreen.png"
theme.layout_magnifier  = themes_path .. "zenburn/layouts/magnifier.png"
theme.layout_floating   = themes_path .. "zenburn/layouts/floating.png"
theme.layout_cornernw   = themes_path .. "zenburn/layouts/cornernw.png"
theme.layout_cornerne   = themes_path .. "zenburn/layouts/cornerne.png"
theme.layout_cornersw   = themes_path .. "zenburn/layouts/cornersw.png"
theme.layout_cornerse   = themes_path .. "zenburn/layouts/cornerse.png"

-- titlebar config

-- close button
theme.titlebar_close_button_normal              = my_themes_path .. "icons/titlebar/close.svg"
theme.titlebar_close_button_focus              = my_themes_path .. "icons/titlebar/close.svg"
theme.titlebar_close_button_normal_hover        = my_themes_path .. "icons/titlebar/close_focused_pressed.svg"
theme.titlebar_close_button_focus_hover         = my_themes_path .. "icons/titlebar/close_focused_pressed.svg"

-- minimize button
theme.titlebar_minimize_button_normal           = my_themes_path .. "icons/titlebar/minimize.svg"
theme.titlebar_minimize_button_focus            = my_themes_path .. "icons/titlebar/minimize_focused_normal.svg"
theme.titlebar_minimize_button_normal_hover     = my_themes_path .. "icons/titlebar/minimize_focused_pressed.svg"
theme.titlebar_minimize_button_focus_hover     = my_themes_path .. "icons/titlebar/minimize_focused_pressed.svg"

-- on top button
theme.titlebar_ontop_button_focus_active        = themes_path .. "zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = themes_path .. "zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = themes_path .. "zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = themes_path .. "zenburn/titlebar/ontop_normal_inactive.png"

-- sticky button
theme.titlebar_sticky_button_focus_active       = themes_path .. "zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = themes_path .. "zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = themes_path .. "zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = themes_path .. "zenburn/titlebar/sticky_normal_inactive.png"

-- floating button
theme.titlebar_floating_button_focus_active     = themes_path .. "zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = themes_path .. "zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = themes_path .. "zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = themes_path .. "zenburn/titlebar/floating_normal_inactive.png"

-- maximized button
theme.titlebar_maximized_button_focus_active  = my_themes_path .. "icons/titlebar/maximize.svg"
theme.titlebar_maximized_button_normal_active = my_themes_path .. "icons/titlebar/maximize.svg"
theme.titlebar_maximized_button_focus_inactive  = my_themes_path .. "icons/titlebar/unmaximize.svg"
theme.titlebar_maximized_button_normal_inactive = my_themes_path .. "icons/titlebar/unmaximize.svg"
theme.titlebar_maximized_button_normal_active_hover = my_themes_path .. "icons/titlebar/maximize_focused_pressed.svg"
theme.titlebar_maximized_button_focus_active_hover = my_themes_path .. "icons/titlebar/maximize_focused_pressed.svg"


return theme
