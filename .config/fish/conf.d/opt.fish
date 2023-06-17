# affix colons on either side of $PATH to simplify matching
switch ":$PATH:"
  case "*:/opt/bin:*"
    # do nothing
    ;;
  case "*"
    # Prepending path in case a package-manager-installed software needs to be overridden
    set -gx PATH "/opt/bin:$PATH"
    ;;
end
