$env.config = {
  buffer_editor: "nvim"
  edit_mode: 'vi'
  show_banner: false
  keybindings: [
    {
      name: change_dir_with_fzf
      modifier: CONTROL
      keycode: Char_y
      mode: [ emacs, vi_insert, vi_normal ]
      event: {
        send: executehostcommand,
        cmd: "cd (ls | where type == dir | each { |row| $row.name} | str join (char nl) | tv | decode utf-8 | str trim)"
      }
    }
    {
      name: ls
      modifier: Alt
      keycode: Char_l
      mode: [ emacs, vi_insert, vi_normal ]
      event: {
        send: executehostcommand,
        cmd: "print "\n"; ls"
      }
    }
    {
      name: fuzzy_history
      modifier: control
      keycode: char_r
      mode: [emacs, vi_normal, vi_insert]
      event: [
        {
          send: ExecuteHostCommand
          cmd: "commandline edit --insert (
            history
              | get command
              | reverse
              | uniq
              | str join (char -i 0)
              | fzf
                --scheme history
                --read0
                --layout reverse
                --height 40%
                --query (commandline)
              | decode utf-8
              | str trim
          )"
        }
      ]
    }
  ]
}
# Set television as default fuzzy finder
$env.FZF_DEFAULT_COMMAND = "tv"

# Starship configuration
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Node version manager configuration
# fnm env --json | from json | load-env
# $env.path = $env.path | append $env.FNM_MULTISHELL_PATH

# Zoxide setup
source ~/.zoxide.nu
