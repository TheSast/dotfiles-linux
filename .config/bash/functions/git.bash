git() {
	case "$1" in
	"root")
		repository_root=$(command git rev-parse --show-toplevel 2>/dev/null)
		if [ "$repository_root" ]; then
			if ! [ "$PWD" = "$repository_root" ]; then
				cd "$repository_root"
			fi
			if [ "$2" ]; then
				git "${@:2}"
			fi
		else
			echo "unable to find repo root"
		fi
		;;
	"sw")
		if [ "$2" ]; then
			git switch "${@:2}"
		else
			# git branch --sort=committerdate | fzf --header "Switch Git Branch" --preview "git diff {1} --color=always" | xargs git switch
			git branch --sort=committerdate | fzf --header "Switch Git Branch" | xargs git switch
		fi
		;;
	"ch")
		if [ "$2" ]; then
			git checkout "${@:2}"
		else
			# git log --decorate=full --format=oneline --abbrev-commit | fzf --header "Checkout Git Commit" --preview "git diff {1} --color=always" | sed -E 's/^(.{7}).*/\1/' | xargs git checkout
			git log --decorate=full --format=oneline --abbrev-commit | fzf --header "Checkout Git Commit" | sed -E 's/^(.{7}).*/\1/' | xargs git checkout
		fi
		;;
	*)
		command git "$@"
		;;
	esac
}
