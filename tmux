# Make it like GNU Screen
unbind C-b
unbind l
set -g   prefix C-a
bind C-a send-prefix
bind a   send-prefix
bind-key C-a last-window

# Shift+[arrow] to move windows
bind -n S-left prev
bind -n S-right next

# Vim key bindings
setw -g mode-keys vi
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind-key -r C-h select-window -t :-
bind-key -r C-l select-window -t :+

# Vim options
set -sg escape-time 0

# Reload key
bind r source-file ~/.tmux.conf

# No visual activity
set -g visual-activity off
set -g visual-bell off
# set-window-option -g window-status-alert-attr default

# Screen properties
set -g default-terminal "screen-256color"
set -g history-limit 100000
set -g status-interval 10                 # Update every X seconds for the clock
setw -g xterm on                          # Fix CTRL+Arrow in bash

# Theme
set -g bell-action current
set -g status-bg colour16
set -g status-fg white
set-window-option -g window-status-current-format '#[fg=green] #W #[default]'
setw -g automatic-rename on
set -g status-left-length 30
set -g status-right-length 40
#set -g status-left '#[fg=green](#S) #(whoami)@#H#[default]'
#set -g status-left '#[fg=green]#(virtual-host 30)#[default]'
#set -g status-right '#[fg=red][#(num-processors)]#[default] #[fg=yellow]#(cut -d " " -f 1-3 /proc/loadavg)#[default]  #[fg=blue]%H:%M:%S#[default]'

bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"
