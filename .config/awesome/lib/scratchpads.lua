local bling = require("modules.bling")

Scratchy = bling.module.scratchpad {
  command                 = "alacritty -t scratchy -e lvim ~/.md/scratch.md ~/.md/todo.md ~/.md/routine.md ~/.md/reference.md ~/.md/ideas.md", -- How to spawn the scratchpad
  rule                    = { instance = "scratchy" }, -- The rule that the scratchpad will be searched by
  sticky                  = true, -- Whether the scratchpad should be sticky
  autoclose               = true, -- Whether it should hide itself when losing focus
  floating                = true, -- Whether it should be floating (MUST BE TRUE FOR ANIMATIONS)
  geometry                = { x = 600, y = 90, height = 700, width = 800 }, -- The geometry in a floating state
  reapply                 = true, -- Whether all those properties should be reapplied on every new opening of the scratchpad (MUST BE TRUE FOR ANIMATIONS)
  dont_focus_before_close = false, -- When set to true, the scratchpad will be closed by the toggle function regardless of whether its focused or not. When set to false, the toggle function will first bring the scratchpad into focus and only close it on a second call
  -- rubato                  = { x = anim_x, y = anim_y } -- Optional. This is how you can pass in the rubato tables for animations. If you don't want animations, you can ignore this option.
}
