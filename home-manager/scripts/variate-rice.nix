with (import <nixpkgs> {});
  pkgs.writeShellApplication {
    name = "variate-rice";

    # INFO: this is built in it's parent dir using
    # `nix-build variate-rice.nix -o variate-rice.outlink` and `ln -s -r variate-rice.outlink/bin/variate-rice ./variate-rice`

    runtimeInputs = [coreutils-full findutils];

    text = ''
      #!/bin/sh

      COLORSCHEME=$("$XDG_CONFIG_HOME/scripts/colorscheme.sh")
      THEME=$("$XDG_CONFIG_HOME/scripts/theme.sh")

      WALLPAPER_DIR="$XDG_PICTURES_DIR/wallpapers"
      find_wallpaper() {
        find "$WALLPAPER_DIR/$COLORSCHEME/$THEME" -maxdepth 1 -not -type d | shuf | head -n 1
      }
      WALLPAPER="$(find_wallpaper)"
      ln -sf "$WALLPAPER" "$XDG_CACHE_HOME/wallpaper"

      if command -v swww &> /dev/null; then
        # TODO: randomise `--transition-angle`, `--transition-pos`, `--transition-bezier`, `--transition-wave`
        TRANSITION=$(echo "left
        right
        top
        bottom
        wipe
        wipe
        wave
        wave
        grow
        grow
        outer
        outer" | shuf | head -n 1 | tr -d '[:blank:]')

       swww img -t "$TRANSITION" --transition-fps 255 -- "$XDG_CACHE_HOME/wallpaper"
      fi

      if command -v wallust &> /dev/null; then
        REAL_WALLPAPER_LOCATION="$(readlink "$XDG_CACHE_HOME/wallpaper")"
        wallust -f "$THEME"16 "$REAL_WALLPAPER_LOCATION" &
      fi

      echo "set nativetheme=$THEME" > "$XDG_CACHE_HOME/colorscheme-dyn.vieb"
      if command -v vieb &> /dev/null; then
        vieb --execute="set nativetheme=$THEME" &
      fi

      if command -v waybar &> /dev/null; then
        THEME_ARG=""
        if [ "$THEME" = "dark" ]; then
          THEME_ARG="--style $XDG_CONFIG_HOME/waybar/style-dark.css"
        fi
        pkill waybar && waybar "$THEME_ARG" &
      fi
    '';
  }
