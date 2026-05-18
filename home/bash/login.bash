# is always interactive
if [ -n "$SSH_CONNECTION" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CLIENT" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi
