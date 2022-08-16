local fn = vim.fn

-- Automatically install packer after cloning
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Protected call without errors first use:
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Foundation
  use { "wbthomason/packer.nvim" } -- Have packer manage itself

  -- Lua
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins{telescope, gitsigns, ..}
  use { "lewis6991/impatient.nvim" } -- Speed up loading Lua modules in Neovim to improve startup time
  use { "folke/lua-dev.nvim" } -- Dev setup for init.lua and plugin development
  use { "ahmedkhalf/project.nvim" } -- Project management

  use { "nvim-telescope/telescope.nvim" }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use { "kyazdani42/nvim-tree.lua" }
  use { "lewis6991/gitsigns.nvim" }

  use { "numToStr/Comment.nvim" }
  use { "JoosepAlviste/nvim-ts-context-commentstring" }
  -------------- Important Plugins -----------------
  --Notes:
  -- Those are quite tricky to configure those plugins
  -- command ":checkhealth" to scan out errors

  -- Syntax:
  use { "nvim-treesitter/nvim-treesitter" }
  use { 'nvim-treesitter/playground' }
  use { 'p00f/nvim-ts-rainbow' }
  use { "lukas-reineke/indent-blankline.nvim" } -- Adds indentation guides to all lines (including empty lines).
  use { "RRethy/vim-illuminate" } -- Automatically highlighting Other Uses of the current word under the cursor

  -- Cmp plugins
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path" } -- path completions
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-nvim-lua" }
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      local saga = require("lspsaga")

      saga.init_lsp_saga({
        -- your configuration
      })
    end,
  })

  -- Snippets
  use { "L3MON4D3/LuaSnip" } --snippet engine
  use { "rafamadriz/friendly-snippets" }

  -- LSP
  use { "neovim/nvim-lspconfig" } -- enable LSP
  use { "williamboman/nvim-lsp-installer" } -- simple to use language server installer
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters

  -- Dap: Debug Adapter
  use { "mfussenegger/nvim-dap" }
  use { "rcarriga/nvim-dap-ui" }
  use { "nvim-telescope/telescope-dap.nvim" }
  use { "theHamsta/nvim-dap-virtual-text" }
  -------------- End -----------------
  -- Themes & Fonts & Icons:
  use { "kyazdani42/nvim-web-devicons" }
  use { "folke/tokyonight.nvim" }
  --  use { "dracula/vim", name = "dracula" }

  -- Outlook:
  use { "goolord/alpha-nvim" }
  use { "akinsho/bufferline.nvim" }
  use { "nvim-lualine/lualine.nvim" }

  -- Better experience:
  use { "moll/vim-bbye" } -- delete buffers (close files) without closing your windows or messing up your layout
  use { "akinsho/toggleterm.nvim" } -- persist and toggle multiple terminals during an editing session
  use { "folke/which-key.nvim" }
  use { "windwp/nvim-autopairs" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
