#!/bin/sh
set -o errexit
set -o nounset

# runtimeInputs = [findutils coreutils];

log() {
	if [ -t 0 ]; then
		DATE="$(date +%Y-%m-%dT%H:%M:%S,%N)"
		echo "$DATE" "$@"
	else
		while read -r line; do
			DATE="$(date +%Y-%m-%dT%H:%M:%S,%N)"
			echo "$DATE" "$@" "$line"
		done
	fi
}
