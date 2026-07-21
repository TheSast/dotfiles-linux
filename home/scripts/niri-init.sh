#!/bin/sh
set -o errexit
set -o nounset

# expects proper XDG base dirs variables to be set up
# runtimeInputs = [coreutils udiskie batsignal wob hyprpolkitagent hypridle trash-cli wl-clipboard]
# ++ ./log.sh.runtimeInputs
# ++ ./corn.sh.runtimeInputs;

# shellcheck source=./log.sh
. "$XDG_CONFIG_HOME/scripts/log.sh"
STATE="$XDG_STATE_HOME/niri-init"
mkdir -p "$STATE"

{
	# `noctalia` which is v5, lacks various features, notably:
	# mirror-mirror plugin
	# privacy-indicator plugin
	# usb-device-manager plugin
	# linux-wallpaper-engine-controller plugin
	NOCTALIA_KIND=$(shuf -n 1 -e noctalia noctalia-shell)
	log "Chosen $NOCTALIA_KIND session"
	$NOCTALIA_KIND &

	udiskie --tray >/dev/null 2>&1 &

	kanshi >/dev/null 2>&1 &

	trash "$XDG_CACHE_HOME"/cliphist || true
	# wl-paste --type text --watch cliphist store >/dev/null 2>&1 & 
	# wl-paste --type image --watch cliphist store >/dev/null 2>&1 &

	if [ "$(hostname)" = "kafka" ]; then
		hypridle >/dev/null 2>&1 &
	fi

	"$XDG_CONFIG_HOME"/scripts/corn.sh --startup >/dev/null 2>&1 &
} | log niri-init.sh >>"$STATE/niri-init.log" 2>&1
