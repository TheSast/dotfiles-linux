#!/bin/sh
set -o errexit
set -o nounset

# expects proper XDG base dirs variables to be set up
# runtimeInputs = [findutils coreutils ggrep sed vieb]

THEME=$("$XDG_CONFIG_HOME/scripts/theme.sh")
WHICH_LIGHT="paper"
WHICH_DARK="default"
[ "$THEME" = "dark" ] && VIEB_THEMED_COLORSCHEME_BASE="$WHICH_DARK" || VIEB_THEMED_COLORSCHEME_BASE="$WHICH_LIGHT"

# get_running_vieb_colorscheme(Option<String>: datafolder) -> String
get_running_vieb_colorscheme() {
	if [ "$1" = "None" ]; then
		vieb --execute="colorscheme" --execute-dur=10 | sed "s/colorscheme: //" || true
	else
		vieb --execute="colorscheme" --execute-dur=10 --datafolder="$1" | sed "s/colorscheme: //" || true
	fi
}

# get_config_vieb_colorscheme() -> String
get_config_vieb_colorscheme() {
	head -n 1 "$XDG_CACHE_HOME"/colorscheme-dyn.vieb | sed "s/colorscheme //" || true
}

# get_vieb_colorscheme_variant(colorscheme_with_variant: String) -> String
get_vieb_colorscheme_variant() {
	echo "$1" | sed -E "s/^.*-//" || true
}

# join_if_both(left: String, separator: String, right: String) -> String
join_if_both() {
	JOIN="$2"
	if [ "$1" = "" ] || [ "$3" = "" ]; then
		JOIN=""
	fi
	echo "$1""$JOIN""$3"
}

main() {
	if command -v vieb >/dev/null 2>&1; then
		VIEB_COLORSCHEME=default
		# INFO: process is not named "vieb" it's an "electron" instance
		if vieb --execute="echo variate-vieb.sh detected" --execute-dur=10 >/dev/null 2>&1; then
			# TODO: add error handling
			VIEB_COLORSCHEME=$(join_if_both "$VIEB_THEMED_COLORSCHEME_BASE" - "$(get_vieb_colorscheme_variant "$(get_running_vieb_colorscheme None)")" | sed -E "s/^default-//")
			{
				# shellcheck disable=SC2015
				vieb --execute="colorscheme $VIEB_COLORSCHEME" --execute-dur=10 &&
					vieb --execute="set nativetheme=$THEME" --execute-dur=10 ||
					true
			} &
		else
			VIEB_COLORSCHEME=$(join_if_both "$VIEB_THEMED_COLORSCHEME_BASE" - "$(get_vieb_colorscheme_variant "$(get_config_vieb_colorscheme)")" | sed -E "s/^default-//")
		fi
		echo "colorscheme $VIEB_COLORSCHEME" >"$XDG_CACHE_HOME"/colorscheme-dyn.vieb
		echo "set nativetheme=$THEME" >>"$XDG_CACHE_HOME"/colorscheme-dyn.vieb
		for DATAFOLDER in "$XDG_STATE_HOME"/Erwic/*; do
			if vieb --execute="variate-vieb.sh is running" --execute-dur=10 --datafolder="$DATAFOLDER" >/dev/null 2>&1; then
				VIEB_COLORSCHEME=$(join_if_both "$VIEB_THEMED_COLORSCHEME_BASE" - "$(get_vieb_colorscheme_variant "$(get_running_vieb_colorscheme "$DATAFOLDER")")" | sed -E "s/^default-//")
				{
					# shellcheck disable=SC2015
					vieb --execute="colorscheme $VIEB_COLORSCHEME" --execute-dur=10 --datafolder="$DATAFOLDER" &&
						vieb --execute="set nativetheme=$THEME" --execute-dur=10 --datafolder="$DATAFOLDER" ||
						true
				} &
			fi
		done
	fi
}
main
