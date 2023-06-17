function dfgit --wraps='git --git-dir=$HOME/.dotfiles --work-tree=$HOME' --description 'alias dfgit git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
  git --git-dir=$HOME/.dotfiles --work-tree=$HOME $argv 
end
