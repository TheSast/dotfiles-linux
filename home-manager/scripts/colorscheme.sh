#!/bin/sh

case $(date "+%A") in # fuck sh and bash arrays
Monday)
	COLORSCHEME="catppuccin"
	;;
Tuesday)
	COLORSCHEME="nord"
	;;
Thursday)
	COLORSCHEME="kanagawa"
	;;
Wednesday)
	COLORSCHEME="rose-pine"
	;;
Friday)
	COLORSCHEME="tokyonight"
	;;
Saturday)
	COLORSCHEME="solarized"
	;;
Sunday)
	COLORSCHEME="gruvbox"
	;;
esac

echo "$COLORSCHEME"
