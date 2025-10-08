#!/bin/sh
set -o errexit
set -o nounset

# expects proper XDG base dirs variables to be set up
# runtimeInputs = [findutils coreutils swww wallust waybar procps]
# ++ ./log.sh.runtimeInputs
# ++ ./theme.sh.runtimeInputs;

# shellcheck source=./log.sh
. "$XDG_CONFIG_HOME/scripts/log.sh"
THEME=$("$XDG_CONFIG_HOME/scripts/theme.sh")

{
	echo "START"
	WALLPAPER_DIR="$XDG_PICTURES_DIR/wallpapers"
	find_wallpaper() {
		find "$WALLPAPER_DIR" -type f -path "*/$THEME/*" -not -path "*/.*" | shuf -n 1
	}
	WALLPAPER="$(find_wallpaper)"
	echo "$WALLPAPER"
	ln -sf "$WALLPAPER" "$XDG_CACHE_HOME/wallpaper"
	echo "END"
} 2>&1 | log wallpaper

{
	echo "START"
	if command -v swww >/dev/null 2>&1; then
		if ! swww query >/dev/null 2>&1; then
			swww-daemon --no-cache & # INFO: daemon
			swww img -t none -- "$XDG_CACHE_HOME/wallpaper"
		else
			export SWWW_TRANSITION=$(shuf -e -n 1 "wave" "grow" "outer")
			export SWWW_TRANSITION_ANGLE=$(shuf -e -n 1 "45" "90" "135" "180" "225" "270" "315" "360")
			export SWWW_TRANSITION_POS=$(shuf -e -n 1 "center" "top" "left" "right" "bottom" "top-left" "top-right" "bottom-left" "bottom-right")
			export SWWW_TRANSITION_WAVE=$(shuf -e -n 1 "100,1" "10,10" "20,20" "30,30" "40,40" "40,10" "30,20")
			export SWWW_TRANSITION_FPS=255
			export SWWW_TRANSITION_STEP=255
			swww img -- "$XDG_CACHE_HOME/wallpaper"
		fi
	fi
	echo "END"
} 2>&1 | log swww &

{
	echo "START"
	if command -v wallust >/dev/null 2>&1; then
		REAL_WALLPAPER_LOCATION="$(realpath "$XDG_CACHE_HOME/wallpaper")"
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
		STYLE="style.css"
		if [ "$THEME" = "dark" ]; then
			STYLE="style-dark.css"
		fi
		ln -sf $XDG_CONFIG_HOME/waybar/$STYLE $XDG_CACHE_HOME/waybar.css
		if pgrep waybar >/dev/null 2>&1; then
			pkill -SIGUSR2 waybar
		else
			nohup waybar "--style $XDG_CACHE_HOME/waybar.css" >/dev/null 2>&1 & # INFO: daemon
		fi
	fi
	echo "END"
} 2>&1 | log waybar &
