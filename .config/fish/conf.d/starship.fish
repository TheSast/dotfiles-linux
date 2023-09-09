set -gx STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"
function starship_transient_prompt_func
  echo "- "
end
starship init fish | source
enable_transience
