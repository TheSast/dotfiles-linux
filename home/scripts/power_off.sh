#!/bin/sh
set -o errexit
set -o nounset

# expects proper XDG base dirs variables to be set up
# runtimeInputs = [coreutils tofi systemd.systemctl]
# ++ ./log.sh.runtimeInputs

PROGNAME="${0##*/}"
# shellcheck source=./log.sh
. "$XDG_CONFIG_HOME/scripts/log.sh"
STATE="$XDG_STATE_HOME/power-off"
mkdir -p "$STATE"

{
	CHOSEN="${1:-"--ask"}"
	if [ "$CHOSEN" = "--ask" ]; then
		CHOSEN=$(echo "lock
suspend
suspend-then-hibernate
hibernate
poweroff
reboot" | tofi)
		sleep 0.35
	fi
	if [ "$CHOSEN" != "" ]; then
		echo "$CHOSEN"
		if [ "lock" = "$CHOSEN" ]; then
			loginctl lock-session
		else
			systemctl "$CHOSEN"
		fi
	fi
} | log "$PROGNAME" >>"$STATE/power-off.log" 2>&1
