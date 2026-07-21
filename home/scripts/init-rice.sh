#!/bin/sh
set -o errexit
set -o nounset

# expects proper XDG base dirs variables to be set up
# runtimeInputs = [coreutils awww wallust waybar]
# ++ ./log.sh.runtimeInputs
# ++ ./theme.sh.runtimeInputs;

# shellcheck source=./log.sh
. "$XDG_CONFIG_HOME/scripts/log.sh"
THEME=$("$XDG_CONFIG_HOME/scripts/theme.sh")
export XDG_DATA_DIRS="$GSETTINGS_SCHEMAS${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"

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
