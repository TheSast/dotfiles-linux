colo() {
  if [ -z "$1" ]; then
    echo "change       changes colorscheme randomly"
    echo "current      display current colorscheme"
  fi
  case "$1" in
    "change")
      unset -v "$COLORSCHEME"
      source "$XDG_CONFIG_HOME/bash/conf.d/colorscheme.bash"
      echo set colorscheme to "$COLORSCHEME"
      ;;
    "current")
      echo "current colorscheme is $COLORSCHEME"
      ;;
  esac
}
