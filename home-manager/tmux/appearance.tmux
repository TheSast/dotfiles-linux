# --- Appearance -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Available session options are:
#      display-panes-active-colour colour
#      display-panes-colour colour
#      message-command-style style
#      message-style style
#      status-format[] format
set -g status off # [off | on | 2 | 3 | 4 | 5] # controlled by pluigins
set -g status-interval 1 # controlled by pluigins
set -g status-justify left # [left | centre | right | absolute-centre]
#      status-left string
#      status-left-length length
#      status-left-style style
set -g status-position bottom # [top | bottom]
#      status-right string
#      status-right-length length
#      status-right-style style
#      status-style style

# Available window options are:
#      automatic-rename-format format
#      copy-mode-match-style style
#      copy-mode-mark-style style
#      copy-mode-current-match-style style
#      mode-style style
#      pane-active-border-style style
set -g pane-border-format "#P #{pane_current_command}"
set -g pane-border-indicators colour # [off | colour | arrows | both]
set -g pane-border-lines single
set -g pane-border-status off # [off | top | bottom]
#      pane-border-style style
#      popup-style style
#      popup-border-style style
set -g popup-border-lines rounded
#      window-status-activity-style style
#      window-status-bell-style style
#      window-status-current-format string
#      window-status-current-style style
#      window-status-format string
#      window-status-last-style style
#      window-status-separator string
#      window-status-style style

# Available pane options are:
#      cursor-colour colour
#      pane-colours[] colour
#      cursor-style style
#      window-active-style style
#      window-style style
