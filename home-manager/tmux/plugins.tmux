# --- Tmux Plugins ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

set -g @plugin 'TheSast/tpm'                                # Tmux Plugin Manager -- Using fork because currently broken, see https://github.com/tmux-plugins/tpm/pull/249
set -g @plugin 'TheSast/tmux-transient-status'              # Automatically make your tmux status-bar vanish when unneded.
set -g @plugin 'TheSast/tmux-sessionist'                    # Lightweight tmux utils for manipulating sessions -- Using fork while waiting on pr respones upstream
set -g @plugin 'TheSast/tmux-nav-master'                    # Easy cross-navigation with tmux and other programs.
set -g @plugin 'TheSast/tmux-keylocker'                     # Lock away your tmux keybinds temporarely.
set -g @plugin 'erikw/tmux-powerline'                       # A tmux plugin giving you a hackable status bar consisting of dynamic & beautiful looking powerline segments, written purely in bash.
set -g @plugin 'tmux-plugins/tmux-resurrect'                # Persists tmux environment across system restarts.
set -g @plugin 'tmux-plugins/tmux-continuum'                # Continuous saving of tmux environment. Automatic restore when tmux is started. Automatic tmux start when computer is turned on.
set -g @plugin 'joshmedeski/tmux-nerd-font-window-name'     # Nerd Font icons for your tmux windows   
set -g @plugin 'joshmedeski/t-smart-tmux-session-manager'   # t - the smart tmux session manager

# --- Plugins Settings -----------------------------------------------------------------------------------------------------------------------------------------------------------------

set -g @transient-status-delay '0.6'                        # seconds
set -g @transient-status-stall '1.5'                        # seconds

set -g @sessionist-maintain-path 'off'

set -g @resurrect-capture-pane-contents 'on'               
set -g @resurrect-strategy-nvim 'session'

set -g @continuum-restore 'off'
set -g @continuum-save-interval '10'                        # minutes

# --- Plugins Bindings -----------------------------------------------------------------------------------------------------------------------------------------------------------------
# comment or leave empty for default, arbritrary string to unbind

set -g @tpm-install 'no-key'                                # default I 
set -g @tpm-update 'no-key'                                 # default U
set -g @tpm-clean 'no-key'                                  # default M-u

set -g @locker-bind 'nothing'                               # defautl C-g

set -g @sessionist-goto 'nah'                               # default g
set -g @sessionist-alternate 'i-m-good'                     # default S
set -g @sessionist-new 'M-n'                                # default C
set -g @sessionist-promote-pane 'unbound'                   # default @
set -g @sessionist-promote-window 'M-t'                     # default C-@
set -g @sessionist-join-pane 'nope'                         # default t
set -g @sessionist-kill-session 'no-thanks'                 # default X

set -g @t-bind 'f'                                          # default T

set -g @resurrect-save 'no-key'                             # default C-s 
set -g @resurrect-restore 'no-key'                          # default C-r
