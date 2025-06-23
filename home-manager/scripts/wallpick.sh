#!/bin/sh
fd -t file . "$XDG_PICTURES_DIR/wallpapers" | shuf | xargs swayimg "--config=keys.viewer.Return=exec swww img %"
