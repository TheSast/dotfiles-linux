if [ -z "$COLORSCHEME" ]
  set -gx COLORSCHEME (shuf -n 1 "$XDG_CONFIG_HOME/colorscheme/pool")
end
bash "$XDG_CONFIG_HOME/colorscheme/terminal/$COLORSCHEME.sh"
