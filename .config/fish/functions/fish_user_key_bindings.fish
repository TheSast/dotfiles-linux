function fish_user_key_bindings
  fzf_key_bindings
  bind \cd delete-char
  bind \cd true
  # bind \cd\cd delete-or-exit
  bind --erase --preset \cd
end

