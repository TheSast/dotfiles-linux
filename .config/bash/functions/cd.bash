cd() {
  builtin cd "$@" || return
  check_directory_for_new_repository
}
