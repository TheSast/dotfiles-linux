# shellcheck shell=sh
# runtimeInputs = [coreutils jq slurp grim libnotify hyprpicker];

# Environment Handling
PROGNAME=$(basename "$0")
if ! command -v hyprctl >/dev/null 2>&1 || ! hyprctl activewindow -q; then
	echo >&2 "$PROGNAME: Fatal Error. Not running in Hyprland."
	exit 1
fi
SAVE=false
COPY=false
args() {
	while test $# -gt 0; do
		case "$1" in
		-s | --save)
			SAVE=true
			;;
		-c | --copy)
			COPY=true
			;;
		*) ;;
		esac
		shift
	done
}
args "$@"
if "$COPY" && ! command -v wl-copy >/dev/null 2>&1; then
	echo >&2 "$PROGNAME: Warning. Missing wl-copy (wl-clipboard). Ignoring '--copy' argument."
	COPY=false
fi
if ! "$SAVE" && ! "$COPY"; then
	echo >&2 "$PROGNAME: Fatal Error. Missing any one of '--save' and '--copy' argument."
	exit 1
fi

# Region Selection
hyprpicker -r -z &
sleep 0.2
HYPRPICKER_PID=$!
if [ "0" != "$(hyprctl -j activewindow | jq -e .fullscreen)" ] >/dev/null; then
	selection="$(slurp -od || true)"
else
	monitors="$(hyprctl -j monitors)"
	clients="$(hyprctl -j clients | jq -r '[.[] | select(.workspace.id | contains('"$(echo "$monitors" | jq -r 'map(.activeWorkspace.id) | join(",")')"'))]')"
	boxes="$(echo "$clients" | jq -r '.[] | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1]) \(.title)"')"
	selection="$(echo "$boxes" | slurp -od || true)"
fi
(kill "$HYPRPICKER_PID")
if [ "$selection" = "" ]; then
	exit 1
fi

# Data Saving
if "$SAVE"; then
	OUTDIR="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots/$(date +%Y)/$(date +%m)/$(date +%d)"
	OUTFILE="$OUTDIR/$(date +%H-%M-%S)"
	mkdir -p "$OUTDIR"
	grim -g "$selection" "$OUTFILE.png"
	if "$COPY"; then
		wl-copy <"$OUTFILE.png"
		notify-send "Image saved and copied to the clipboard." -i "$OUTFILE.png" -a "$PROGNAME"
	else
		notify-send "Image saved." -i "$OUTFILE.png" -a "$PROGNAME"
	fi
else
	if "$COPY"; then
		grim -g "$selection" - | wl-copy
		notify-send "Image copied to the clipboard." -a "$PROGNAME"
	fi
fi
