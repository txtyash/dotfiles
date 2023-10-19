set -gx ATUIN_NOBIND true

# Set available editor to open in current directory
if command -v neovide >/dev/null
    set -gx EDITOR (which neovide)
    set -gx VISUAL (which neovide)
else
    set -gx EDITOR (which neovim)
    set -gx VISUAL (which neovim)
end

if status is-interactive
    fish_vi_key_bindings
    function fish_user_key_bindings
        for mode in default insert
            bind -M $mode \cz "fg %(jobs | fzf | cut -c1)"
            bind -M $mode \cc cancel-cmd
            bind -M $mode \cp history-search-backward
            bind -M $mode \cn history-search-forward
            bind -M $mode \ca beginning-of-buffer
            bind -M $mode \ce end-of-buffer forward-char
            bind -M $mode \cw backward-kill-word
            bind -M $mode \ef forward-word
            bind -M $mode \ch _atuin_search
            bind -M $mode \en $EDITOR .
        end
    end
end

function cancel-cmd
    commandline ""
    emit fish_cancel
    commandline -f repaint
end

fzf_configure_bindings --directory=\cf --history=\cr

alias l="eza"
alias ll="eza -l"
alias la="eza -la"

alias d="z"
alias di="zi"
alias dp="cd -"

alias v="nvim"
alias top="btm"

zoxide init fish | source
starship init fish | source
atuin init fish | source

# My plugins:
# jorgebucaran/fisher
# jorgebucaran/autopair.fish
# nickeb96/puffer-fish
# patrickf1/fzf.fish
