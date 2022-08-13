vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
-------------
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.backup = false                          -- creates a backup file
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.undofile = true                         -- enable persistent undo
--
vim.opt.showcmd = true
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.laststatus = 2  			-- default value
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
--
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.breakindent = true
--
vim.opt.smarttab = true
vim.opt.expandtab = true                        -- Tab == Space in Insert, Ctr+V+Tab == real Tab
vim.opt.tabstop = 1
vim.opt.showtabline = 0                         -- always show tabs
vim.opt.shiftwidth = 2
--
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.number = true                           -- set numbered lines
vim.opt.ruler = false
vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}
--highlights
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.pumblend = 5
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.winblend = 0
vim.opt.wildoptions = 'pum'
--
vim.opt.scrolloff = 10                           -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
--
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.fillchars.eob=" "
vim.opt.inccommand = 'split'
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.backspace = {'start', 'eol', 'indent'}
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append {'*.git'}
--
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 300                        -- faster completion (4000ms default)

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})
-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }
vim.opt.shortmess:append "c"
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")
