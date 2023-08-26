# --- Preferences-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Available server options are:
set -g buffer-limit 50
set -g default-terminal "tmux-256color"          # enable truecolor support
set -g copy-command ''
set -g escape-time 10
set -g editor nvim
set -g exit-empty on # [on | off]
set -g exit-unattached off # [on | off]
set -g extended-keys always # [on | off | always]
set -g focus-events on # [on | off]
set -g history-file ''
set -g message-limit 1000
set -g prompt-history-limit 100
set -g set-clipboard on # [on | external | off]
set -gu terminal-features
set -ga terminal-features 'xterm*:extkeys'
set -ga terminal-features 'xterm*:focus'
set -gu terminal-overrides
set -ga terminal-overrides ",xterm-256color:RGB" # enable truecolor support...         # see https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95
set -ga terminal-overrides ",*256col*:RGB"       # enable truecolor support......
set -ga terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
set -ga terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

# Available session options are:
set -g activity-action other # [any | none | current | other]
set -g assume-paste-time 1
set -g base-index 1
set -g bell-action any # [any | none | current | other]
set -g default-command ''
set -g default-shell "$SHELL"
set -g default-size 80x24
set -g destroy-unattached off # [on | off]
set -g detach-on-destroy off # [off | on | no-detached]
set -g display-panes-time 750
set -g display-time 1350
set -g history-limit 50000
set -g lock-after-time 0
#      lock-command command
#      message-line [0 | 1 | 2 | 3 | 4] # missing ?
set -g renumber-windows on # [on | off]
set -g repeat-time 750
set -g set-titles on # [on | off]
#      set-titles-string string
set -g silence-action current # [any | none | current | other]
#      update-environment[] variable
set -g visual-activity off # [on | off | both]
set -g visual-bell off # [on | off | both]
set -g visual-silence off # [on | off | both]
#      word-separators string

# Available window options are:
set -g aggressive-resize off # [on | off]
set -g automatic-rename on # [on | off]
set -g clock-mode-colour blue
set -g clock-mode-style 24
set -g fill-character ''
set -g main-pane-height 24
set -g main-pane-width 80
set -g monitor-activity off # [on | off]
set -g monitor-bell on # [on | off]
set -g monitor-silence 0
set -g other-pane-height 0
set -g other-pane-width 0
set -g pane-base-index 1
set -g window-size latest # [ largest | smallest | manual | latest ]
set -g wrap-search on # [on | off]

# Available pane options are:
set -g allow-passthrough off # [on | off | all]
set -g allow-rename on # [on | off]
set -g alternate-screen on # [on | off]
set -g remain-on-exit off # [on | off | failed]
#      remain-on-exit-format string
set -g scroll-on-clear on # [on | off]
set -g synchronize-panes off # [on | off]
