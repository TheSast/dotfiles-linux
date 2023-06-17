function colo --description 'output and set the colorscheme'
  if [ $(count $argv) -eq 0 ]
    echo "change       changes colorscheme randomly"
    echo "current      display current colorscheme"
  end
  switch "$argv[1]"
    case "change"
      set --erase COLORSCHEME
      source "$XDG_CONFIG_HOME/fish/conf.d/colorscheme.fish"
      echo set colorscheme to "$COLORSCHEME"
    case "current"
      echo "current colorscheme is $COLORSCHEME"
  end
end
