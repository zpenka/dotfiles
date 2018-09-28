# i3 config file (v4)
#
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

set $mod Mod1

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font Source\ Code\ Pro 13

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec gnome-terminal

# kill focused window
bindsym $mod+Shift+q kill

# start dmenu (a program launcher)
bindsym $mod+d exec dmenu_run
# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
# bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+g split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

# switch to workspace
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace 1
bindsym $mod+Shift+2 move container to workspace 2
bindsym $mod+Shift+3 move container to workspace 3
bindsym $mod+Shift+4 move container to workspace 4
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to wterminator
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace 10

# move workspace left/right
bindsym $mod+Shift+comma move workspace to output left
bindsym $mod+Shift+period workspace to output right

set $Locker i3lock -c 000000 && sleep 1

set $mode_system System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (Shift+s) shutdown
mode "$mode_system" {
    bindsym l exec --no-startup-id $Locker, mode "default"
    bindsym e exec --no-startup-id i3-msg exit, mode "default"
    bindsym s exec --no-startup-id $Locker && systemctl suspend, mode "default"
    bindsym h exec --no-startup-id $Locker && systemctl hibernate, mode "default"
    bindsym r exec --no-startup-id systemctl reboot, mode "default"
    bindsym Shift+s exec --no-startup-id systemctl poweroff -i, mode "default"  

    # back to normal: Enter or Escape
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

bindsym $mod+Shift+Return mode "$mode_system"

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {

        # Resize Windows
        bindsym h resize shrink width 10 px or 10 ppt
        bindsym j resize grow height 10 px or 10 ppt
        bindsym k resize shrink height 10 px or 10 ppt
        bindsym l resize grow width 10 px or 10 ppt

        # Resize Windows more precisely
        bindsym Shift+h resize shrink width 1 px or 1 ppt
        bindsym Shift+j resize grow height 1 px or 1 ppt
        bindsym Shift+k resize shrink height 1 px or 1 ppt
        bindsym Shift+l resize grow width 1 px or 1 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
        status_command i3status
        font pango:Source\ Code\ Pro 13
}

# Disable window titlebars entirely
for_window [class="^.*"] border pixel 2

# Take a screenshot and open it in gimp for quick editing
bindsym $mod+p exec "sleep 0.2; scrot -s -e 'mv $f /tmp/ && gimp /tmp/$f'"

# system volume bindings
bindsym $mod+comma exec pactl set-sink-volume @DEFAULT_SINK@ -2%; exec pactl set-sink-mute @DEFAULT_SINK@ 0;
bindsym $mod+period exec pactl set-sink-volume @DEFAULT_SINK@ +2%; exec pactl set-sink-mute @DEFAULT_SINK@ 0;
bindsym $mod+m exec pactl set-sink-mute @DEFAULT_SINK@ toggle
bindsym $mod+n exec pactl set-source-mute @DEFAULT_SOURCE@ toggle

# tab motion like chrome
bindsym $mod+Tab workspace next
bindsym $mod+Shift+Tab workspace prev
workspace_auto_back_and_forth yes

exec --no-startup-id feh --bg-scale ~/Pictures/scene.jpg

exec_always nm-applet

# # Gaps
# # Set inner/outer gaps
# gaps inner 15
# gaps outer 7
#
# # Additionally, you can issue commands with the following syntax. This is useful to bind keys to changing the gap size.
# # gaps inner|outer current|all set|plus|minus <px>
# # gaps inner all set 10
# # gaps outer all plus 5
#
# # Smart gaps (gaps used if only more than one container on the workspace)
# # smart_gaps on
#
# # Smart borders (draw borders around container only if it is not the only container on this workspace)
# # on|no_gaps (on=always activate and no_gaps=only activate if the gap size to the edge of the screen is 0)
# smart_borders on
#
# # Press $mod+Shift+g to enter the gap mode. Choose o or i for modifying outer/inner gaps. Press one of + / - (in-/decrement for current workspace) or 0 (remove gaps for current workspace). If you also press Shift with these keys, the change will be global for all workspaces.
# set $mode_gaps Gaps: (o) outer, (i) inner
# set $mode_gaps_outer Outer Gaps: +|-|0 (local), Shift + +|-|0 (global)
# set $mode_gaps_inner Inner Gaps: +|-|0 (local), Shift + +|-|0 (global)
# bindsym $mod+Shift+g mode "$mode_gaps"
#
# mode "$mode_gaps" {
#         bindsym o      mode "$mode_gaps_outer"
#         bindsym i      mode "$mode_gaps_inner"
#         bindsym Return mode "default"
#         bindsym Escape mode "default"
# }
#
# mode "$mode_gaps_inner" {
#         bindsym plus  gaps inner current plus 5
#         bindsym minus gaps inner current minus 5
#         bindsym 0     gaps inner current set 0
#
#         bindsym Shift+plus  gaps inner all plus 5
#         bindsym Shift+minus gaps inner all minus 5
#         bindsym Shift+0     gaps inner all set 0
#
#         bindsym Return mode "default"
#         bindsym Escape mode "default"
# }
# mode "$mode_gaps_outer" {
#         bindsym plus  gaps outer current plus 5
#         bindsym minus gaps outer current minus 5
#         bindsym 0     gaps outer current set 0
#
#         bindsym Shift+plus  gaps outer all plus 5
#         bindsym Shift+minus gaps outer all minus 5
#         bindsym Shift+0     gaps outer all set 0
#
#         bindsym Return mode "default"
#         bindsym Escape mode "default"
# }


