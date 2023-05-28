-- First read our docs (completely) then check the example_config repo

local opt = vim.opt

opt.shiftwidth = 4
vim.o.statusline = vim.o.statusline .. ' %F'

local M = {}

M.ui = {
  theme = "catppuccin",
}

M.plugins = {
  ["NvChad/ui"] = {
    override_options = {
      statusline = {
        separator_style = "round",
        overriden_modules = function()
          return require "custom.status_line"
        end,
      },
    },
  },
  ["lewis6991/gitsigns.nvim"] = {
    config = function()
      require("gitsigns").setup {
        -- your config goes here
        -- or just leave it empty :)
      }
    end,
  },
  ["tpope/vim-fugitive"] = {
    config = function()
      -- require("fugitive").setup {
      -- your config goes here
      -- or just leave it empty :)
      -- }
    end,
  },
  ["goolord/alpha-nvim"] = {
    disable = false,
  },
  ["Pocco81/auto-save.nvim"] = {
    config = function()
      require("auto-save").setup {
        -- your config goes here
        -- or just leave it empty :)
      }
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },

  ["nvim-telescope/telescope.nvim"] = {
    config = function()
      require('telescope').setup{
        pickers = {
          buffers = {
            sort_lastused = true,
          },
        },
      }
    end,
  },
}
M.mappings = {}

-- gvim
local g = vim.g
--vim.o.guifont = { "CartographCF", ":h12" }
vim.o.guifont = "CartographCF,Delugia Nerd Font:h12"
g.neovide_scale_factor = 0.5
return M
