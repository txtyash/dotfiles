# Only run this in interactive shells
if status is-interactive

  # Set the cursor shapes for the different vi modes.
  set fish_cursor_default     block      blink
  set fish_cursor_insert      line       blink
  set fish_cursor_replace_one underscore blink
  set fish_cursor_visual      block
  set fish_greeting

  function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
    for mode in default insert
        # bind -M $mode \ee 'nvim .'
        # bind -M $mode \ey 'yazi'
        # bind -M $mode \eg 'gitui'
    end
  end

end

function cancel-cmd
    commandline ""
    emit fish_cancel
    commandline -f repaint
end

if command -q nix-your-shell
  nix-your-shell fish | source
end

starship init fish | source
zoxide init fish | source
