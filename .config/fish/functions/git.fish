function git
  switch $argv[1]
  case "root"
    set repository_root (command git rev-parse --show-toplevel 2> /dev/null)
    if [ "$repository_root" ]
      if ! [ "$PWD" = "$repository_root" ]
        cd $repository_root
      end
      if [ (count $argv) -gt 1 ]
        git $argv[2..]
      end
    else
      echo "unable to find repo root"
    end
    ;;
  case "sw"
    if [ (count $argv) -gt 1 ]
      git switch $argv[2..]
    else
			# git branch --sort=committerdate | fzf --header "Switch Git Branch" --preview "git diff {1} --color=always" | xargs git switch
			git branch --sort=committerdate | fzf --header "Switch Git Branch" | xargs git switch
    end
    ;;
  case "ch"
    if [ (count $argv) -gt 1 ]
      git checkout $argv[2..]
    else
			# git log --decorate=full --format=oneline --abbrev-commit | fzf --header "Checkout Git Commit" --preview "git diff {1} --color=always" | sed -E 's/^(.{7}).*/\1/' | xargs git checkout
			git log --decorate=full --format=oneline --abbrev-commit | fzf --header "Checkout Git Commit" | sed -E 's/^(.{7}).*/\1/' | xargs git checkout
    end
    ;;
  case "*"
    command git $argv
    ;;
  end
end
