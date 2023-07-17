# --- Options --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# set -g backspace C-?
# set -gu user-keys
# set -ga user-keys
# set -ga user-keys
set -g key-table root
set -g mouse off                       # do not capture any mouse input
set -g prefix M-Space                  # use Alt + nvim leader
set -g prefix2 None
set -g status-keys emacs               # use emacs bindings for the commandline
set -g mode-keys vi                    # use vim bindings for copy-mode

# --- Unbind Everything ----------------------------------------------------------------------------------------------------------------------------------------------------------------

unbind -aqT session-table
unbind -aqT toggle-table
unbind -aqT package-table
unbind -aqT copy-mode
unbind -aqT copy-mode-vi
unbind -aqT prefix
unbind -aqT root

# --- Copy-Mode-Vi Bindings ------------------------------------------------------------------------------------------------------------------------------------------------------------

bind -T copy-mode-vi   Escape          send -X clear-selection
bind -T copy-mode-vi   C-v             send -X rectangle-toggle
bind -T copy-mode-vi   C-b             send -X page-up
bind -T copy-mode-vi   C-f             send -X page-down
bind -T copy-mode-vi   C-u             send -X halfpage-up
bind -T copy-mode-vi   C-d             send -X halfpage-down
bind -T copy-mode-vi   C-y             send -X scroll-up
bind -T copy-mode-vi   C-e             send -X scroll-down
bind -T copy-mode-vi   \#              send -FX search-backward "#{copy_cursor_word}"
bind -T copy-mode-vi   \$              send -X end-of-line
bind -T copy-mode-vi   L               send -X end-of-line # there is no foward-to-indentation
bind -T copy-mode-vi   \%              send -X next-matching-bracket
bind -T copy-mode-vi   *               send -FX search-forward "#{copy_cursor_word}"
bind -T copy-mode-vi   ,               send -X jump-reverse
bind -T copy-mode-vi   /               command-prompt -T search -p "(search down)" { send -X search-forward "%%" }
bind -T copy-mode-vi   0               send -X start-of-line
bind -T copy-mode-vi   1               command-prompt -N -I 1 -p (repeat) { send -N "%%" }
bind -T copy-mode-vi   2               command-prompt -N -I 2 -p (repeat) { send -N "%%" }
bind -T copy-mode-vi   3               command-prompt -N -I 3 -p (repeat) { send -N "%%" }
bind -T copy-mode-vi   4               command-prompt -N -I 4 -p (repeat) { send -N "%%" }
bind -T copy-mode-vi   5               command-prompt -N -I 5 -p (repeat) { send -N "%%" }
bind -T copy-mode-vi   6               command-prompt -N -I 6 -p (repeat) { send -N "%%" }
bind -T copy-mode-vi   7               command-prompt -N -I 7 -p (repeat) { send -N "%%" }
bind -T copy-mode-vi   8               command-prompt -N -I 8 -p (repeat) { send -N "%%" }
bind -T copy-mode-vi   9               command-prompt -N -I 9 -p (repeat) { send -N "%%" }
bind -T copy-mode-vi   :               command-prompt
bind -T copy-mode-vi   \;              send -X jump-again
bind -T copy-mode-vi   ?               command-prompt -T search -p "(search up)" { send -X search-backward "%%" }
bind -T copy-mode-vi   W               send -X next-space
bind -T copy-mode-vi   E               send -X next-space-end
bind -T copy-mode-vi   B               send -X previous-space
bind -T copy-mode-vi   F               command-prompt -1 -p "(jump backward)" { send -X jump-backward "%%" }
bind -T copy-mode-vi   G               send -X history-bottom
bind -T copy-mode-vi   N               send -X search-reverse
bind -T copy-mode-vi   T               command-prompt -1 -p "(jump to backward)" { send -X jump-to-backward "%%" }
bind -T copy-mode-vi   V               send -X select-line
bind -T copy-mode-vi   ^               send -X back-to-indentation
bind -T copy-mode-vi   H               send -X back-to-indentation
bind -T copy-mode-vi   w               send -X next-word
bind -T copy-mode-vi   e               send -X next-word-end
bind -T copy-mode-vi   b               send -X previous-word
bind -T copy-mode-vi   f               command-prompt -1 -p "(jump forward)" { send -X jump-forward "%%" }
bind -T copy-mode-vi   g               send -X history-top
bind -T copy-mode-vi   h               send -X cursor-left
bind -T copy-mode-vi   j               send -X cursor-down
bind -T copy-mode-vi   k               send -X cursor-up
bind -T copy-mode-vi   l               send -X cursor-right
bind -T copy-mode-vi   n               send -X search-again
bind -T copy-mode-vi   t               command-prompt -1 -p "(jump to forward)" { send -X jump-to-forward "%%" }
bind -T copy-mode-vi   v               send -X begin-selection
bind -T copy-mode-vi   y               send -X copy-selection
bind -T copy-mode-vi   \{              send -X previous-paragraph
bind -T copy-mode-vi   \}              send -X next-paragraph

bind -T copy-mode-vi   F1              list-keys -N
bind -T copy-mode-vi   i               send -X cancel
bind -T copy-mode-vi   I               send -X cancel
bind -T copy-mode-vi   a               send -X cancel
bind -T copy-mode-vi   A               send -X cancel
bind -T copy-mode-vi   R               send -X cancel
bind -T copy-mode-vi   c               if '[ #{selection_present} -eq 1 ]' { send -X cancel }
bind -T copy-mode-vi   C               send -X cancel
bind -T copy-mode-vi   o               send -X cancel
bind -T copy-mode-vi   O               send -X cancel
#                      C-Down
#                      C-Up
#                      C-Right
#                      C-Left
#                      C-h
#                      C-j
#                      C-k
#                      C-l

# --- Prefix Table Bindings ------------------------------------------------------------------------------------------------------------------------------------------------------------

bind                   M-Space         send-prefix
bind                   v               copy-mode

#                      C-n
bind                   M-q             confirm -p "Kill session #{session_name}? (y/N)" { kill-session }

bind                   e               choose-tree -Zw
bind                   n               new-window
bind                   T               run "$XDG_CONFIG_HOME/tmux/scripts/promote_pane.sh '#{window_id}' '#{pane_id}'"
bind                   Q               run "$XDG_CONFIG_HOME/tmux/scripts/kill_window.sh '#{session_id}' '#{window_id}'"
bind                   1               select-window -t :=1
bind                   2               select-window -t :=2
bind                   3               select-window -t :=3
bind                   4               select-window -t :=4
bind                   5               select-window -t :=5
bind                   6               select-window -t :=6
bind                   7               select-window -t :=7
bind                   8               select-window -t :=8
bind                   9               select-window -t :=9

bind                   E               display-panes -d 0
bind                   s               set -g synchronize-panes
bind -n                M-|             split-window -h -c "#{pane_current_path}"
bind -n                M-\\            split-window -v -c "#{pane_current_path}"
#                      H               
#                      J               
#                      K               
#                      L               
bind                   Down            select-layout -o # TODO: improve layout mappings
bind                   Up              select-layout -E # TODO: improve layout mappings
bind -r                Right           select-layout -p # TODO: improve layout mappings
bind -r                Left            select-layout -n # TODO: improve layout mappings
#                      C-Down
#                      C-Up
#                      C-Right
#                      C-Left
bind                   q               run "$XDG_CONFIG_HOME/tmux/scripts/kill_pane.sh '#{session_id}' '#{window_id}' '#{pane_id}'"
#                      C-h
#                      C-j
#                      C-k
#                      C-l
bind -n                M-h             select-pane -L
bind -n                M-j             select-pane -D
bind -n                M-k             select-pane -U
bind -n                M-l             select-pane -R
bind -n                M-Left          resize-pane -L 3
bind -n                M-Down          resize-pane -D 3
bind -n                M-Up            resize-pane -U 3
bind -n                M-Right         resize-pane -R 3

bind                   u               switch-client -T toggle-table
bind                   p               switch-client -T package-table
bind -T toggle-table   t               set -g pane-border-status
bind -T package-table  i               tpm-install
bind -T package-table  u               tpm-update
bind -n                M-:             { set -g status-position top ; command-prompt ; set -g status-position bottom } # TODO: tmux-topcmd
#                      f
bind -n                M-F1            list-keys -N
bind                   M               select-pane -M
bind                   m               select-pane -m
bind                   t               clock-mode
bind                   z               resize-pane -Z
bind                   S               switch-client -T session-table
bind -T session-table  s               resurrect-save
bind -T session-table  l               resurrect-restore
