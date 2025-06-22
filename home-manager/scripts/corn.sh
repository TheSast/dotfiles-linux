#!/bin/sh
set -o errexit

# expects proper XDG base dirs variables to be set up
# runtimeInputs = [ coreutils gnugrep procps ] ++ ./variate-rice.sh.runtimeInputs ++ ./init-rice.sh.runtimeInputs;

STATE="$XDG_STATE_HOME/corn"
mkdir -p "$STATE"

# log(msg: String) -> ()
log() {
	echo "$(date +%Y-%m-%dT%H:%M:%S,%N)" "$@" >>"$STATE/corn.log" 2>&1
}

# log_cmd(cmd: String, ... @ args: [String]) -> ()
log_cmd() {
	log "START" "$1"
	"$@" >>"$STATE/corn.log" 2>&1 || log "unwrap: " "$@"
	log "END" "$1"
}

# scheduled() -> u64
scheduled() {
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
	echo "$SCHEDULED"
}

# shellcheck disable=SC2120
# variate_rice(... @ args: [String]) -> ()
variate_rice() {
	log_cmd "$XDG_CONFIG_HOME/scripts/variate-rice.sh" "$@"
	NOW="$(date +%s)"
	echo "$NOW" >"$STATE/variate-rice.time"
}

# init_rice() -> ()
init_rice() {
	log_cmd "$XDG_CONFIG_HOME/scripts/init-rice.sh"
}

## if the device just woke up then replace any running instances and if
## the theme has to change do it instantly, otherwise check every 60s
## if it's day or night and change the theming accordingly and if it
## is not the time yet but the device just booted up then just pick up
## from how the theming was last time
# main() -> !
main() {
	SYSTEM_STARTUP=false
	if [ "$1" = "--startup" ]; then
		SYSTEM_STARTUP=true
	fi

	WAKEUP=false
	if [ "$1" = "--wakeup" ]; then
		WAKEUP=true
	fi

	CURRENT_PID="$$"
	# OTHER_RUNNING_INSTANCES="$(pgrep -x corn.sh | grep -v "$CURRENT_PID" || true)"
	# bash creates a `pgrep` detectable subprocess when there is a pipe or an AND/OR
	set +o errexit
	echo A
	RUNNING_INSTANCES="$(pgrep -x corn.sh)"
	# make sure to not wordsplit stuff with echo
	OTHER_RUNNING_INSTANCES="$(echo "$RUNNING_INSTANCES" | grep -v "$CURRENT_PID")"
	echo B
	set -o errexit

	echo C
	if "$SYSTEM_STARTUP" || "$WAKEUP"; then
		if  [ "$OTHER_RUNNING_INSTANCES" != "" ]; then
			# bash ignores the default -15 aka SIGTERM , using -9 aka SINGKILL will properly kill
			# MUST be unquoted, to expand to multiple arguments
			kill -9 "$OTHER_RUNNING_INSTANCES" || log "expect: failed condition check before running kill on wakeup"
			log "REPLACE instance $OTHER_RUNNING_INSTANCES with $1 instance $CURRENT_PID"
		fi
		log "corn START $1 PID: $CURRENT_PID"
	else
		if [ "$OTHER_RUNNING_INSTANCES" != "" ]; then
			log "attempted to run corn ""$CURRENT_PID while $OTHER_RUNNING_INSTANCES was running"
			exit 17
		fi
		log "corn START PID: $CURRENT_PID"
	fi

	while true; do
		if ! [ -f "$STATE/variate-rice.time" ]; then
			date --date=@0 +%s >"$STATE/variate-rice.time"
			log "no valid variate-rice.time found"
		fi
		LASTRUN="$(cat "$STATE"/variate-rice.time || log "expect: failed condition check before running cat on stored time")"
		if [ "$LASTRUN" -le "$(scheduled)" ]; then
			variate_rice #()
		else
			if "$SYSTEM_STARTUP"; then
				init_rice #()
			fi
		fi
		WAKEUP=false
		SYSTEM_STARTUP=false
		sleep 60 || log "expect: sleep killed"
	done
}
main "$@"
