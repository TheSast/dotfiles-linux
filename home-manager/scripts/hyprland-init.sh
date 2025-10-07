#!/bin/sh
set -o errexit
set -o nounset

# expects proper XDG base dirs variables to be set up
# runtimeInputs = [coreutils udiskie hyprnotify batsignal wob hyprpolkitagent hypridle trash-cli wl-clipboard]
# ++ ./log.sh.runtimeInputs
# ++ ./corn.sh.runtimeInputs;

# shellcheck source=./log.sh
. "$XDG_CONFIG_HOME/scripts/log.sh"
STATE="$XDG_STATE_HOME/hyprland-init"
mkdir -p "$STATE"

{
	nohup udiskie --smart-tray >/dev/null 2>&1 &

	nohup hyprnotify -s -f 20 >/dev/null 2>&1 &


	rm -f /tmp/wobpipe
	touch /tmp/wobpipe
	nohup tail -f /tmp/wobpipe | wob >/dev/null 2>&1 &

	nohup "$XDG_STATE_HOME"/nix/profile/libexec/hyprpolkitagent >/dev/null 2>&1 &

	nohup hypridle >/dev/null 2>&1 &

	trash "$XDG_CACHE_HOME"/cliphist
	nohup wl-paste --type text --watch cliphist store >/dev/null 2>&1 &
	nohup wl-paste --type image --watch cliphist store >/dev/null 2>&1 &

	nohup "$XDG_CONFIG_HOME"/scripts/corn.sh --startup >/dev/null 2>&1 &
} | log hyprland-init.sh >>"$STATE/hyprland-init.log" 2>&1
