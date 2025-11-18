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
			swww-daemon -l bottom --no-cache & # INFO: daemon
		fi
		if [ "$XDG_CURRENT_DESKTOP" = "niri" ] && ! swww query -n overview-bg >/dev/null 2>&1; then
			swww-daemon -n overview-bg --no-cache & # INFO: daemon
		fi
		# transition to same image cache is unusable in multi-namespace usage
		swww img -t none -- "$XDG_CACHE_HOME/wallpaper" # detaches
		if [ "$XDG_CURRENT_DESKTOP" = "niri" ]; then
			swww img -n overview-bg -t none -- "$XDG_CACHE_HOME/wallpaper-blurred"
		fi
	fi
	echo "END"
} 2>&1 | log swww &

{
	echo "START"
	GTK_THEME="adw-gtk3"
	COLORSCHEME="prefer-light"
	if [ "$THEME" = "dark" ]; then
		GTK_THEME="adw-gtk3-dark"
		COLORSCHEME="prefer-dark"
	fi
	gsettings set org.gnome.desktop.interface gtk-theme $GTK_THEME
	gsettings set org.gnome.desktop.interface color-scheme $COLORSCHEME
	echo "END"
} 2>&1 | log gsettings &

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
	if command -v waybar >/dev/null 2>&1; then
		nohup waybar "--style $XDG_CACHE_HOME/waybar.css" >/dev/null 2>&1 & # INFO: daemon
	fi
	echo "END"
} 2>&1 | log waybar &
