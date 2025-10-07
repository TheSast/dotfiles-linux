#!/usr/bin/env sh

CURRENT_SESSION_ID="$1"
CURRENT_WINDOW_ID="$2"
CURRENT_PANE_ID="$3"

number_of_windows() {
	tmux list-windows -t "$CURRENT_SESSION_ID" |
		wc -l |
		tr -d ' '
}

number_of_panes() {
	tmux list-panes -t "$CURRENT_WINDOW_ID" |
		wc -l |
		tr -d ' '
}

main() {
	if [ "$(number_of_windows)" -gt 1 ] || [ "$(number_of_panes)" -gt 1 ]; then
		tmux kill-pane -t "$CURRENT_PANE_ID"
	else
		tmux display-message "Can't kill session with kill-pane keybind"
	fi
}
main
