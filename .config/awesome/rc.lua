pcall(require, "luarocks.loader")

-- First check for errors
require "awful.autofocus"
require "errors"

-- Load the UI
Theme = "sun"
Titlebar = "lightsaber"
require "rice"

-- config
require "conf"

-- tag retained restart
-- require "lib.save_tag"
-- LoadLastActiveTag()
