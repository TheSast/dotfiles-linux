# brave fish setup
# affix colons on either side of $PATH to simplify matching
switch ":$PATH:"
  case "*:/Brave-Browser/Application:*"
    # do nothing
    ;;
  case "*"
    # Prepending path in case something needs to be overridden
    set -gx PATH "/mnt/c/Program Files (x86)/BraveSoftware/Brave-Browser/Application:$PATH"
    ;;
end
