#!/usr/bin/env sh

CURRENT_SESSION_ID="$1"
CURRENT_WINDOW_ID="$2"

number_of_windows() {
	tmux list-windows -t "$CURRENT_SESSION_ID" |
		wc -l |
		tr -d ' '
}

main() {
	if [ "$(number_of_windows)" -gt 1 ]; then
		tmux kill-window -t "$CURRENT_WINDOW_ID"
	else
		tmux display-message "Can't kill session with kill-window keybind"
	fi
}
main
