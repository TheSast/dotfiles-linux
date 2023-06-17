#!/bin/env fish

# bail on non interactive
if ! status is-interactive
  return
end

# hide greeting
set fish_greeting









# --- Pass Process ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

# live and die with tmux
if [ -z "$TMUX"  ]
    neofetch # splashscreen
    read -n 1 -p "" key
    clear
    switch "$key"
        case "q"
        case "Q"
        case ""
            return 0
    end
    if tmux list-clients 2> /dev/null | grep -q main
        tmux new-session -d -s mirror -t first
        tmux set-hook -t mirror client-attached "set -t mirror 'destroy-unattached on'"
        tmux attach -f 'ignore-size,active-pane' -t mirror && exit
    end
    tmux new-session -A -s main -t first && exit
end
