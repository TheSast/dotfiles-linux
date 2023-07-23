#!/usr/bin/env bash

# bail on non interactive
[[ $- != *i* ]] && return

# omit cd
shopt -s autocd

# auto win resize
shopt -s checkwinsize

# set history to work correctly
export HISTFILE="$XDG_STATE_HOME/bash/history"
export HISTCONTROL=erasedups
shopt -s histappend

# --- Pass Process ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

# live and die with terminal multiplexers
if [ -z "$TMUX" ] && [ -z "$ZELLIJ" ]; then
	neofetch # splashscreen
	read -r -n 1 -s key
	clear
	case "$key" in
	"q" | "Q" | "")
		return 0
		;;
	"z" | "Z")
		zellij && exit
		;;
	*)
		# if tmux list-clients 2>/dev/null | grep -q main; then
		# 	tmux new-session -d -s mirror -t first
		# 	tmux set-hook -t mirror client-attached "set -st mirror 'destroy-unattached on'"
		# 	tmux attach -f 'ignore-size,active-pane' -t mirror && exit
		# fi
		tmux new-session -A -s main -t first && exit
		;;
	esac
fi
