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
	nohup udiskie --smart-tray >/dev/null 2>&1 &

	# mako / dunst / fnott

	batsignal -b -w "35" -c "15" -d "5" -W "Battery level low" -C "Battery level minimal" -D "Battery level critical" -M "notify-send" -a "Battery" # daemon by default
	nohup tail -f /tmp/wobpipe | wob >/dev/null 2>&1 &

	# nohup ~/.nix-profile/libexec/polkit-kde-authentication-agent-1 >/dev/null 2>&1 &
	nohup "$XDG_STATE_HOME"/nix/profile/libexec/hyprpolkitagent >/dev/null 2>&1 &

	nohup hypridle >/dev/null 2>&1 &

	trash "$XDG_CACHE_HOME"/cliphist
	nohup wl-paste --type text --watch cliphist store >/dev/null 2>&1 &
	nohup wl-paste --type image --watch cliphist store >/dev/null 2>&1 &

	nohup "$XDG_CONFIG_HOME"/scripts/corn.sh --startup >/dev/null 2>&1 &
} | log niri-init.sh >>"$STATE/niri-init.log" 2>&1
