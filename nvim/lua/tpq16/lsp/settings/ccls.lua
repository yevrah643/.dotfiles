local util = require 'lspconfig.util'

local root_files = {
	'compile_commands.json',
	'.ccls',
	'.git'
}

return {
	default_config = {
		cmd = {'ccls'},
		filetypes = { 'c', 'cpp', 'objc', 'objcpp'},
		root_dir = function (fname)
			return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
		end,

		offset_encoding = 'utf-32',
		single_file_support = false,
	};

	init_options = {
	    compilationDatabaseDirectory = "build";
	    index = {
	      threads = 0;
	    };
	    clang = {
	      excludeArgs = { "-frounding-math"} ;
	    };
	}
}
