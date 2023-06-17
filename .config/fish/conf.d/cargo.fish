set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"

# affix colons on either side of $PATH to simplify matching
switch ":$PATH:"
  case "*:/cargo/bin:*"
    # do nothing
    ;;
  case "*"
    # Prepending path in case a system-installed rustc needs to be overridden
    set -gx PATH "$CARGO_HOME/bin:$PATH"
    ;;
end
