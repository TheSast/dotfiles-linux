#!/bin/sh
set -o errexit
set -o nounset

# runtimeInputs = [coreutils xdg-utils wl-clipboard];

LOCKFILE="${XDG_RUNTIME_DIR:-/tmp}/editclip.lock"
TMPF="${XDG_RUNTIME_DIR:-/tmp}/editclip.txt"
exec 9>"$LOCKFILE"
flock -n 9 || {
  echo "Another instance is already running." >&2
  exit 1
}
wl-paste -n > $TMPF
chmod o-r $TMPF
${1-"xdg-open"} $TMPF && cat $TMPF | wl-copy
rm $TMPF
