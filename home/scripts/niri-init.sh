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
	nohup nfsm >/dev/null 2>&1 & # INFO: daemon

	nohup udiskie --tray >/dev/null 2>&1 & # INFO: daemon

	nohup mako >/dev/null 2>&1 & # INFO: daemon

	nohup kanshi >/dev/null 2>&1 & # INFO: daemon

	rm -f /tmp/wobpipe
	touch /tmp/wobpipe
	nohup tail -f /tmp/wobpipe | wob >/dev/null 2>&1 & # INFO: daemon

	nohup "$XDG_STATE_HOME"/nix/profile/libexec/hyprpolkitagent >/dev/null 2>&1 & # INFO: daemon

	nohup hypridle >/dev/null 2>&1 & # INFO: daemon

	trash "$XDG_CACHE_HOME"/cliphist
	nohup wl-paste --type text --watch cliphist store >/dev/null 2>&1 &  # INFO: daemon
	nohup wl-paste --type image --watch cliphist store >/dev/null 2>&1 & # INFO: daemon

	nohup "$XDG_CONFIG_HOME"/scripts/corn.sh --startup >/dev/null 2>&1 & # INFO: daemon
} | log niri-init.sh >>"$STATE/niri-init.log" 2>&1
