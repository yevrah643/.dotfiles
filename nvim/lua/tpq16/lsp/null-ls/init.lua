local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local null_ls_utils_status_ok, null_ls_utils = pcall(require, "null_ls_utils")
if not null_ls_utils_status_ok then
  return
end

local with_diagnostics_code = function(builtin)
  return builtin.with {
    diagnostics_format = "#{m} [#{c}]",
  }
end

local with_root_file = function(builtin, file)
  return builtin.with {
    condition = function(utils)
      return utils.root_has_file(file)
    end,
  }
end

local nls_builtin = null_ls.builtins
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local sources = {
  formatting.prettier.with {
      extra_filetypes = { "toml" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
  },
  formatting.shfmt,
  formatting.fixjson,
  formatting.black.with {extra_args = {"--fast"}},
  formatting.isort,
  formatting.google_java_format,
  with_root_file(formatting.stylua, "stylua.toml"),

	--diagnostics
 	diagnostics.write_good,
  -- b.diagnostics.markdownlint,
  -- b.diagnostics.eslint_d,
  diagnostics.flake8,
  diagnostics.tsc,
  with_root_file(diagnostics.selene, "selene.toml"),
  with_diagnostics_code(diagnostics.shellcheck),

  -- code actions
  nls_builtin.code_actions.gitsigns,
  nls_builtin.code_actions.gitrebase,

  -- hover
  nls_builtin.hover.dictionary
}

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup {
  debug = false,
  sources = sources,
	debounce = 150,
  save_after_format = false,
	root_dir = null_ls_utils.root_pattern ".git",
}
