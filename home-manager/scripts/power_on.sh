#!/bin/sh
set -o errexit
set -o nounset

# expects proper XDG base dirs variables to be set up
# runtimeInputs = [coreutils rofi-wayland systemd.systemctl]
# ++ ./log.sh.runtimeInputs

# shellcheck source=./log.sh
. "$XDG_CONFIG_HOME/scripts/log.sh"
STATE="$XDG_STATE_HOME/power-off"
mkdir -p "$STATE"

{
	echo "wake"
} | log power-off.sh >>"$STATE/power-off.log" 2>&1
