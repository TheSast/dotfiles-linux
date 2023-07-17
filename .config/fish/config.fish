#!/bin/env fish

# bail on non interactive
if ! status is-interactive
  return
end

# hide greeting
set fish_greeting









# --- Pass Process ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

# live and die with terminal multiplexers
if [ -z "$TMUX"  ] && [ -z "$ZELLIJ"  ]
    neofetch # splashscreen
    read -n 1 -p "" key
    clear
    switch "$key"
        case "q"
            return 0
        case "Q"
            return 0
        case ""
            return 0
        case "z"
            zellij && exit
        case "Z"
            zellij && exit
        case "*"
            # if tmux list-clients 2> /dev/null | grep -q main
            #     tmux new-session -d -s mirror -t first
            #     tmux set-hook -t mirror client-attached "set -st mirror 'destroy-unattached on'"
            #     tmux attach -f 'ignore-size,active-pane' -t mirror && exit
            # end
            tmux new-session -A -s main -t first && exit
    end
end
