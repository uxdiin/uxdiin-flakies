-- First read our docs (completely) then check the example_config repo

local opt = vim.opt
--
opt.shiftwidth = 4
-- vim.o.statusline = vim.o.statusline .. ' %F'

local M = {}

-- M.ui = {
--   theme = "catppuccin",
-- }


M.plugins = "custom.plugins"

-- M.mappings = {}
--
-- -- gvim
local g = vim.g
-- vim.o.guifont = { "CartographCF", ":h12" }
-- vim.o.guifont = "CartographCF,Delugia Nerd Font:h12"
g.neovide_scale_factor = 0.5
--
return M
