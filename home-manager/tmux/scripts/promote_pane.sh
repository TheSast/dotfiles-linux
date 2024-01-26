#!/usr/bin/env sh

CURRENT_WINDOW_ID="$1"
CURRENT_PANE_ID="$2"

number_of_panes() {
	tmux list-panes -t "$CURRENT_WINDOW_ID" |
		wc -l |
		tr -d ' '
}

main() {
	if [ "$(number_of_panes)" -gt 1 ]; then
		tmux break-pane -s "$CURRENT_PANE_ID"
	else
		tmux display-message "Can't promote with only one pane in window"
	fi
}
main
