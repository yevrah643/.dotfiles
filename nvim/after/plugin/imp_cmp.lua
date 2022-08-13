local status, cmp = pcall(require, "cmp")
  if not status then return 
end

local status, luasnip = pcall(require, "luasnip")
  if (not status) then return
end

local status, lspkind = pcall(require, "lspkind")
  if not status then return  
end

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

-- Calling:
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),

    -- Super Tab
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  }), -- End of Mappings module

  formatting = {
    format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
  }, -- End of Formatting module

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip'},
    { name = 'buffer' },
    { name = 'path'},
  }),-- End of Sources 

  confirm_opts = {
		bebehavior = cmp.ConfirmBehavior.Replace,
		seselect = false,
  },
	wwindow = {
		cocompletion = cmp.config.window.bordered(),
		documentation = false,
  },
  completion = { completeopt = "menu,menuone,noinsert", keyword_length = 1 },
  experimental = { native_menu = false, ghost_text = false },

  -- For snippet works! 
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
})--End Configuration

-- Use buffer source for `/`
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
  -- Mapping keys <TAB> and <CR> 
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
    { name = "cmdline" },
  }),
  -- Mapping keys <TAB> and <CR> 
})

-- Auto pairs
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

-- 
vim.cmd [[
  highlight! default link CmpItemKind CmpItemMenuDefault
]]
