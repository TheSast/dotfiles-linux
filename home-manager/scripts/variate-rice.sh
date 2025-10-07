#!/bin/sh
set -o errexit
set -o nounset

# expects proper XDG base dirs variables to be set up
# runtimeInputs = [findutils coreutils swww wallust waybar procps]
# ++ ./log.sh.runtimeInputs
# ++ ./colorscheme.sh.runtimeInputs
# ++ ./theme.sh.runtimeInputs;

# shellcheck source=./log.sh
. "$XDG_CONFIG_HOME/scripts/log.sh"
COLORSCHEME=$("$XDG_CONFIG_HOME/scripts/colorscheme.sh")
THEME=$("$XDG_CONFIG_HOME/scripts/theme.sh")

WALLPAPER="$XDG_CACHE_HOME/wallpaper"
{
	echo "START"
	WALLPAPER_DIR="$XDG_PICTURES_DIR/wallpapers"
	find_wallpaper() {
		find "$WALLPAPER_DIR/$COLORSCHEME/$THEME" -maxdepth 1 -not -type d | shuf | head -n 1
	}
	WALLPAPER="$(find_wallpaper)"
	echo "$WALLPAPER"
	ln -sf "$WALLPAPER" "$XDG_CACHE_HOME/wallpaper"
	echo "END"
} 2>&1 | log wallpaper

{
	echo "START"
	if command -v swww >/dev/null 2>&1; then
		# TODO: randomise `--transition-angle`, `--transition-pos`, `--transition-bezier`, `--transition-wave`
		TRANSITION=$(echo "left
  	right
  	top
  	bottom
  	wipe
  	wipe
  	wave
  	wave
  	grow
  	grow
  	outer
  	outer" | shuf | head -n 1 | tr -d '[:blank:]')

		if ! swww query >/dev/null 2>&1; then
			swww-daemon --no-cache & # INFO: daemon
			swww img -t none -- "$XDG_CACHE_HOME/wallpaper"
		else
			swww img -t "$TRANSITION" --transition-fps 255 -- "$XDG_CACHE_HOME/wallpaper"
		fi
	fi
	echo "END"
} 2>&1 | log swww &

{
	echo "START"
	if command -v wallust >/dev/null 2>&1; then
		REAL_WALLPAPER_LOCATION="$(readlink "$XDG_CACHE_HOME/wallpaper")"
		{
			wallust run -p "$THEME"16 --dynamic-threshold -- "$REAL_WALLPAPER_LOCATION"
			echo "END"
		} &
	fi
} 2>&1 | log wallust &

{
	echo "START"
	"$XDG_CONFIG_HOME/scripts/variate-vieb.sh"
	echo "END"
} 2>&1 | log vieb &

{
	echo "START"
	if command -v waybar >/dev/null 2>&1; then
		THEME_ARG=""
		if [ "$THEME" = "dark" ]; then
			THEME_ARG="--style $XDG_CONFIG_HOME/waybar/style-dark.css"
		fi
		pkill waybar || echo "expect: failed to kill existing proc $(pgrep waybar)"
		nohup waybar "$THEME_ARG" >/dev/null 2>&1 &
	fi
	echo "END"
} 2>&1 | log waybar &
