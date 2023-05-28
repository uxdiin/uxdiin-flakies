-- custom/abc.lua must return a table

local st_modules = require "nvchad_ui.statusline.modules"

return {
   cwd = function()
      return st_modules.cwd()
   end,
}
