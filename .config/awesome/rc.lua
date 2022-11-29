pcall(require, "luarocks.loader")

-- First check for errors
require "awful.autofocus"
require "errors"

-- Load the UI
Theme = "sun"
Titlebar = "sun"
require "rice"

-- Load the configuration
require "conf"
