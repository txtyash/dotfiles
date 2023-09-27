set -gx ATUIN_NOBIND true

# Set available editor to open in current directory
if command -v neovide >/dev/null
    set -gx EDITOR (which neovide)
    set -gx VISUAL (which neovide)
else
    set -gx EDITOR (which neovim)
    set -gx VISUAL (which neovim)
end

bind \en $EDITOR

if status is-interactive
    fish_vi_key_bindings
    function fish_user_key_bindings
        for mode in normal default visual
            bind -M $mode / _atuin_search
        end
        for mode in insert default visual
            bind -M $mode \ca beginning-of-buffer
            bind -M $mode \ce end-of-buffer forward-char
            bind -M $mode \cw backward-kill-word
            bind -M $mode \ef forward-word
        end
        # ALL MODES
        for mode in normal insert default visual
            bind -M $mode \en $EDITOR
            bind -M $mode \ch _atuin_search
            bind -M $mode \cz "fg %(jobs | fzf | cut -c1)"
            bind -M $mode \cc my-cancel-commandline
            bind -M $mode \cp history-search-backward
            bind -M $mode \cn history-search-forward
        end
    end
end

function fish_prompt -d "Write out the prompt"
    printf '%s[%s] %s%s > ' \
        (set_color $fish_color_cwd) (jobs | wc -l) (pwd) (set_color normal)\n
end

function my-cancel-commandline
    commandline ""
    emit fish_cancel
    commandline -f repaint
end

fzf_configure_bindings --directory=\cf

alias l="eza"
alias ll="eza -l"
alias la="eza -la"

alias x="exit"
alias d="z"
alias di="zi"
alias dp="cd -"

alias v="nvim"
alias fm="joshuto"
alias drag="dragon-drop"
alias top="btm"

zoxide init fish | source
atuin init fish | source
starship init fish | source

# My plugins:
# jorgebucaran/fisher
# jorgebucaran/autopair.fish
# nickeb96/puffer-fish
# patrickf1/fzf.fish
