if [ -z "$COLORSCHEME" ]; then
  export COLORSCHEME=$(shuf -n 1 "$XDG_CONFIG_HOME/colorscheme/pool")
fi
bash "$XDG_CONFIG_HOME/colorscheme/terminal/$COLORSCHEME.sh"
