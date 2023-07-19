#!/bin/bash

file="$HOME/.alacritty-theme"
dark='wez'
light='gruvbox'

if [ "$1" == 'l' ]; then
	if theme.sh $light; then
		echo 'light' >$file
	fi
elif [ "$1" == 'd' ]; then
	if theme.sh $dark; then
		echo 'dark' >$file
	fi
else
	if ! [ -s $file ]; then
		if theme.sh $dark; then
			echo 'dark' >$file
		fi
	else
		if [ "$(cat $file)" == "dark" ]; then
			if theme.sh $light; then
				echo 'light' >$file
			fi
		else
			if theme.sh $dark; then
				echo 'dark' >$file
			fi
		fi
	fi
fi
