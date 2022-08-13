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
  use {"wbthomason/packer.nvim"} -- Have packer manage itself

  -- Necessary Plugins 
    -- Lua 
    use {"nvim-lua/plenary.nvim"} -- Useful lua functions used by lots of plugins{telescope, gitsigns, ..}
    use {"lewis6991/impatient.nvim"} -- Speed up loading Lua modules in Neovim to improve startup time
    use {"folke/lua-dev.nvim"} -- Dev setup for init.lua and plugin development 
    -- Easy look into and manage: 
    use {"nvim-telescope/telescope.nvim"}
    use 'nvim-telescope/telescope-file-browser.nvim'
    use {"ahmedkhalf/project.nvim"} -- Project management 
    -- Explorer:
    use {"kyazdani42/nvim-tree.lua"}
    -- Git
    use {"lewis6991/gitsigns.nvim"}

    use 'windwp/nvim-ts-autotag'
  -------------- Important Plugins -----------------
  --Notes: 
    -- Those are quite tricky to configure those plugins
    -- command ":checkhealth" to scan out errors

  -- Syntax:
  use {"nvim-treesitter/nvim-treesitter"}
    -- Better skimming
    use {"lukas-reineke/indent-blankline.nvim"} -- Adds indentation guides to all lines (including empty lines).
    use {"RRethy/vim-illuminate"} -- Automatically highlighting Other Uses of the current word under the cursor

  -- Cmp plugins
  use {"hrsh7th/nvim-cmp"} -- The completion plugin
  use {"hrsh7th/cmp-buffer"} -- buffer completions
  use {"hrsh7th/cmp-path"} -- path completions
  use {"saadparwaiz1/cmp_luasnip"} -- snippet completions
  use {"hrsh7th/cmp-nvim-lsp"}
  use {"hrsh7th/cmp-nvim-lua"}
    -- Better completion (undependences) 
    use {"numToStr/Comment.nvim"}
    use {"JoosepAlviste/nvim-ts-context-commentstring"}
    use {"windwp/nvim-autopairs"} -- Autopairs, integrates with both cmp and treesitter

  -- Snippets
  use {"L3MON4D3/LuaSnip"} --snippet engine
  use {"rafamadriz/friendly-snippets"}

  -- LSP
  use {"neovim/nvim-lspconfig"} -- enable LSP
  use {"williamboman/nvim-lsp-installer"} -- simple to use language server installer
  use {'onsails/lspkind-nvim'} -- vscode-like pictograms
  use {"jose-elias-alvarez/null-ls.nvim"} -- for formatters and linters
  use {"SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig"}
  use {'MunifTanjim/prettier.nvim'}
  use {'williamboman/mason.nvim'}
  use {'williamboman/mason-lspconfig.nvim'}
  use {'glepnir/lspsaga.nvim'} -- LSP UIs

    -- Dap: Debug Adapter
  use{"mfussenegger/nvim-dap"}
  use{"rcarriga/nvim-dap-ui"}
  use{"nvim-telescope/telescope-dap.nvim"}
  use{"theHamsta/nvim-dap-virtual-text"}
  -------------- End -----------------
  -- Themes & Fonts & Icons: 
    use {"kyazdani42/nvim-web-devicons"}
  -- Colorschemes
    use {"folke/tokyonight.nvim"}
    --use {"lunarvim/darkplus.nvim"}
    --use {"dracula/vim",name = "dracula"}
    --use {
    --'svrana/neosolarized.nvim',
    --requires = { 'tjdevries/colorbuddy.nvim' }
    --}
    use 'norcalli/nvim-colorizer.lua'
    use 'folke/zen-mode.nvim'
	  use({
	    "iamcco/markdown-preview.nvim",
	    run = function() vim.fn["mkdp#util#install"]() end,
	  }) 
    use 'dinhhuy258/git.nvim' -- For git blame & browse
  -- Outlook:
    -- Dashboard 
    use {"goolord/alpha-nvim"}
    -- Bar:
    use {"akinsho/bufferline.nvim"}
    use {"nvim-lualine/lualine.nvim"}

  -- Better experience:
    use {"moll/vim-bbye"} -- delete buffers (close files) without closing your windows or messing up your layout
    use {"akinsho/toggleterm.nvim"} -- persist and toggle multiple terminals during an editing session
    use {"folke/which-key.nvim"}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
