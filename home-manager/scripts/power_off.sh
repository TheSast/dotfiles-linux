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
	CHOSEN=$(echo "lock
suspend
suspend-then-hibernate
hibernate
poweroff" | rofi -dmenu -no-custom)
	if [ -n "$CHOSEN" ]; then
		echo $CHOSEN
		if [ "lock" = "$CHOSEN" ]; then
			loginctl lock-session
		else
			systemctl "$CHOSEN"
		fi
	fi
} | log power-off.sh >>"$STATE/power-off.log" 2>&1
