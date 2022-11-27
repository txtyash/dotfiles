if status is-interactive
    # Commands to run in interactive sessions can go here

    # |=|=|=|=|=|=|=|=> UNAVAILABLE: C-d, C-h

    fish_vi_key_bindings
    function fish_user_key_bindings
        for mode in insert default visual
            # bind -M $mode \cc end-of-buffer kill-whole-line repaint
            bind -M $mode \cc my-cancel-commandline
            bind -M $mode \cz "fg"
            bind -M $mode \ec "gela t; commandline -f repaint"
        end
        for mode in insert default visual
            bind -M $mode \ca beginning-of-buffer
            bind -M $mode \cw backward-kill-word
            bind -M $mode \ce end-of-buffer
            bind -M $mode \cr forward-word
            bind -M $mode \cs forward-char
        end
    end
end

function my-cancel-commandline
    commandline ""
    emit fish_cancel
    # Repaint even if we haven't cancelled anything,
    # so the prompt refreshes and the terminal scrolls to it.
    commandline -f repaint
end

# # THEME.SH LOAD PREVIOUS THEME ON STARTUP
#   if type -q theme.sh
#     if test -e ~/.theme_history
#     theme.sh (theme.sh -l|tail -n1)
#     end
# 
#     # Optional
#     # Bind C-o to the last theme.
#     function last_theme
#       theme.sh (theme.sh -l|tail -n2|head -n1)
#     end
# 
#     bind \co last_theme
# 
#     alias th='theme.sh -i'
# 
#     # Interactively load a light theme
#     alias thl='theme.sh --light -i'
# 
#     # Interactively load a dark theme
#     alias thd='theme.sh --dark -i'
#   end

fzf_configure_bindings --directory=\cd --history=\ch

alias l="ls"
alias ll="ls -lh"
alias la="ls -lha"

alias x="exit"
alias c="z"

alias v="lvim"
alias fm="joshuto"
alias rgi="rg -i"
alias rmi="rm -i"
alias sv="sudo vim"
alias cop="xsel -b <"

alias off="xset dpms force off"
alias reb="systemctl reboot"
alias pow="systemctl poweroff"
alias hib="systemctl hibernate"
alias sus="systemctl suspend && slock"

# Start X at login
# if status is-login
#     if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
#         exec startx -- -keeptty
#     end
# end

starship init fish | source
zoxide init fish | source

# run this as a bash script
# fisher install jorgebucaran/fisher
# fisher install andreiborisov/sponge
# fisher install jorgebucaran/autopair.fish
# fisher install nickeb96/puffer-fish
# fisher install acomagu/fish-async-prompt
# fisher install patrickf1/fzf.fish
