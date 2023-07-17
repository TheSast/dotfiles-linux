[ -z "$COLORSCHEME" ] &&
	export COLORSCHEME=$(shuf -n 1 "$XDG_CONFIG_HOME/colorscheme/pool")

# text output when non-interactive is forbidde
[[ $- != *i* ]] && return

sh "$XDG_CONFIG_HOME/colorscheme/terminal/$COLORSCHEME.sh"
