#!/bin/sh

# runtimeInputs = [coreutils-full procps];

STATE="$XDG_STATE_HOME/corn"
mkdir -p "$STATE"
LOG="$STATE/corn.log"

logdate() {
	date +%Y-%m-%dT%H:%M:%S,%N
}

if [ "$(pgrep -x corn.sh)" != "$$" ]; then
	echo >&2 "corn already running"
	echo "$(logdate) attempted to run corn $$ while $(pgrep -x corn.sh) was running" >>"$LOG" 2>&1
	exit 17
fi

SCRIPTS="$XDG_CONFIG_HOME/scripts"
echo "$(logdate) START corn instance $$" >>"$LOG" 2>&1

while true; do
	if ! [ -f "$STATE/variate-rice.time" ]; then
		date --date=1970-01-01T00:00:00 +%s >"$STATE/variate-rice.time"
	fi
	LASTRUN="$(cat "$STATE"/variate-rice.time)"
	NOW="$(date +%s)"
	if [ "$NOW" -ge "$(date +%s --date=18)" ]; then
		SCHEDULED="$(date +%s --date=18)"
	else
		if [ "$NOW" -ge "$(date +%s --date=6)" ]; then
			SCHEDULED="$(date +%s --date=6)"
		else
			SCHEDULED="$(date +%s --date='yesterday 18')"
		fi
	fi
	if [ "$LASTRUN" -le "$SCHEDULED" ]; then
		{
			echo "$(logdate) START variate-rice"
			"$SCRIPTS/variate-rice"
			echo "$(logdate) END variate-rice"
		} >>"$LOG" 2>&1
		echo "$NOW" >"$STATE/variate-rice.time"
	fi
	sleep 60
done
