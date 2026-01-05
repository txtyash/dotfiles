### Environment Variables (from shellInit)
set -gx EDITOR nvim
set -g fish_greeting
set --global fish_key_bindings fish_vi_key_bindings
set --erase --universal fish_key_bindings

### Interactive Settings (from interactiveShellInit)
if status is-interactive
    # Enable Vi Key Bindings

    # Emacs-style bindings for Insert Mode
    bind -M insert \cA beginning-of-line
    bind -M insert \cE end-of-line
    bind -M insert \cU backward-kill-line
    bind -M insert \cK kill-line
    bind -M insert \cW backward-kill-word
    bind -M insert \cY yank
    bind -M insert \cB backward-char
    bind -M insert \cF forward-char
    bind -M insert \cp up-or-search
    bind -M insert \cn down-or-search
    bind -M insert \cr history-pager

    # Repaint function to avoid artifacts
    function cancel-cmd
        commandline ""
        emit fish_cancel
        commandline -f repaint
    end

    # Tool Initializations
    starship init fish | source
    zoxide init fish | source
    direnv hook fish | source
end
