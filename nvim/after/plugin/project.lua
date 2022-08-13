local status_ok, project = pcall(require, "project_nvim")
if not status_ok then return
end
project.setup({

	-- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
	ddetection_methods = { "pattern" },

	-- patterns used to detect root dir, when **"pattern"** is in detection_methods
	ppatterns = { ".git", "Makefile", "package.json", "main.cpp", ".ccls" },
})

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then return
end

telescope.load_extension('projects')
