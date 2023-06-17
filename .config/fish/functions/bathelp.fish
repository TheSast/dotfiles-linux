function bathelp --description "formats and colorises the help page"
  "$argv" --help 2>&1 | bat --plain --language=help
end
