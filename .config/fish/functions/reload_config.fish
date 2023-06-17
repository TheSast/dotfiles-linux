function reload_config --wraps='source /root/.config/fish/config.fish' --description 'source config.fish'
  source $XDG_CONFIG_HOME/fish/config.fish
end
