# --- Aliases --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

set -gu command-alias # unset all aliases to not re-append them on reload
set -ga command-alias reload="source-file '$XDG_CONFIG_HOME/tmux/tmux.conf'; display-message 'Sourced $XDG_CONFIG_HOME/tmux/tmux.conf'"
set -ga command-alias config="new-window -c '$XDG_CONFIG_HOME/tmux/' '$VISUAL $XDG_CONFIG_HOME/tmux/tmux.conf'; rename-window tmux.conf"
set -ga command-alias sv="split-window -v"
set -ga command-alias sh="split-window -h"
set -ga command-alias tpm-install="run '$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/install_plugins'"
set -ga command-alias tpm-update="run '$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/update_plugins all'"
set -ga command-alias tpm-clean="confirm-before -p 'This will clear plugins in $TMUX_PLUGIN_MANAGER_PATH are you sure (y/N)?' 'run $TMUX_PLUGIN_MANAGER_PATH/tpm/bin/clean_plugins'"
set -ga command-alias resurrect-save="run '$TMUX_PLUGIN_MANAGER_PATH/tmux-resurrect/scripts/save.sh'"
set -ga command-alias resurrect-restore="run '$TMUX_PLUGIN_MANAGER_PATH/tmux-resurrect/scripts/restore.sh'"
