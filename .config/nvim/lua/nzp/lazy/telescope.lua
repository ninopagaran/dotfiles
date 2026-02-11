return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	-- or                              , branch = '0.1.x',
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "Telescope" },
	config = function()
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-u>"] = false,
					},
				},
				file_ignore_patterns = {
					"node_modules",
				},
				-- Display path without leading './'
				path_display = function(_, path)
					return path:gsub("^%./", "")
				end,
			},
		})
	end,
	keys = {
		{
			"<leader>vh",
			function()
				require("telescope.builtin").help_tags()
			end,
		},
		{
			"<C-p>",
			function()
				require("telescope.builtin").git_files()
			end,
		},
		{
			"<leader>pf",
			function()
				require("telescope.builtin").find_files()
			end,
		},
		{
			"<leader>pws",
			function()
				local word = vim.fn.expand("<cword>")
				require("telescope.builtin").grep_string({ search = word })
			end,
		},
		{
			"<leader>pWs",
			function()
				local word = vim.fn.expand("<cWORD>")
				require("telescope.builtin").grep_string({ search = word })
			end,
		},
		{
			"<leader>ps",
			function()
				require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
			end,
		},
	},
}
