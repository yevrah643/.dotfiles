local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup({
  options = {
    mode = "tabs",
    --always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true,
    show_tab_indicator = true,
    separator_style = 'slant',
    diagnostic = "nvim_lsp",
    close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
  },
  highlights = {
    separator = {
      guifg = '#073642',
      guibg = '#002b36',
    },
    separator_selected = {
      guifg = '#073642',
    },
    background = {
      guifg = '#657b83',
      guibg = '#002b36'
    },
    buffer_selected = {
      guifg = '#fdf6e3',
      gui = "bold",
    },
    fill = {
      guibg = '#073642'
    }
  },
})

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
