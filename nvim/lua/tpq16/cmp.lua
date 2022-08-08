local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local icons = require "tpq16.icons"
local kind_icons = icons.kind

--local compare = require "cmp.config.compare"
cmp.setup({
-- Start Configuration
  -- Start of Mappings
  mapping = cmp.mapping.preset.insert({

    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),

    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = true }),

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

    -- [Shift] Super Tab
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
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Menu order
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        --nvim_lua = "[Lua]",
        --cmp_tabnine = "[Tab9]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
		  return vim_item
		end,
	},

	sources = {
		--{ name = "nvim_lsp", max_item_count = 10 },
		{
      name = "luasnip",
      max_item_count = 2,
      group_index = 1,
      keyword_length = 1,
    },

    {
      name = "nvim_lsp",
      filter = function(entry, ctx)
        -- vim.pretty_print()
        local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
        -- vim.bo.filetype
        if kind == "Snippet" and ctx.prev_context.filetype == "java" then
          return true
        end
      end,
      max_item_count = 4,
      group_index = 1,
      keyword_length = 2,
    },
    --{name = "nvim_lua", group_index = 2 },
    --{ name = "cmp_tabnine", group_index = 3 },
		{
      name = "buffer",
      max_item_count = 2,
      group_index = 1,
      keyword_length = 2,
    },
		{
      name = "path",
      group_index = 2,
      keyword_length = 4,
    },
	},

  -- sorting = {
  --   priority_weight = 2,
  --   comparators = {
  --     compare.offset,
  --     compare.exact,
  --     compare.score,
  --     compare.recently_used,
  --     compare.locality,
  --     compare.sort_text,
  --     compare.length,
  --     compare.order,
  --   },
  -- },

	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},

	window = {
		completion = cmp.config.window.bordered(),
    -- completion = {
    --   border = "rounded",
    --   winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    -- },
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
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- Auto pairs
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
