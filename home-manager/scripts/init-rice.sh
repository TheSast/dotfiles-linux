#!/bin/sh
set -o errexit
set -o nounset

# expects proper XDG base dirs variables to be set up
# runtimeInputs = [coreutils swww wallust waybar]
# ++ ./log.sh.runtimeInputs
# ++ ./theme.sh.runtimeInputs;

# shellcheck source=./log.sh
. "$XDG_CONFIG_HOME/scripts/log.sh"
THEME=$("$XDG_CONFIG_HOME/scripts/theme.sh")

{
	echo "START"
	if command -v swww >/dev/null 2>&1; then
		if ! swww query >/dev/null 2>&1; then
			swww-daemon & # --no-cache
		fi
		# transition to same image in case cache got wiped
		swww img -t none --transition-duration=1 --transition-fps 255 -- "$XDG_CACHE_HOME/wallpaper" # detaches
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
		nohup waybar "$THEME_ARG" >/dev/null 2>&1 &
	fi
	echo "END"
} 2>&1 | log waybar &
