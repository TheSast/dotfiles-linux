if [ -z "$COLORSCHEME" ]
  set -gx COLORSCHEME (shuf -n 1 "$XDG_CONFIG_HOME/colorscheme/pool")
end

# text output when non-interactive is forbidden
if ! status is-interactive
  return
end

sh "$XDG_CONFIG_HOME/colorscheme/terminal/$COLORSCHEME.sh"
