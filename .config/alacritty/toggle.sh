#!/bin/bash

file="$HOME/.alacritty-theme"

if ! [ -s $file ]; then
	if theme.sh wez; then
		echo 'dark' >$file
	fi
else
	if [ "$(cat $file)" == "dark" ]; then
		if theme.sh gruvbox; then
			echo 'light' >$file
		fi
	else
		if theme.sh wez; then
			echo 'dark' >$file
		fi
	fi
fi
