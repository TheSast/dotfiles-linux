# unless it is defined by home-manager
if [ -n "$__HM_SESS_VARS_SOURCED" ]
  return
end
# use XDG Base Directory Specification
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
