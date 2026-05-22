return {
	{
		"stevearc/conform.nvim",
		lazy = false,
		opts = require("configs.conform"),
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup({})
			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		ft = { "markdown" },
		opts = {},
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			diagnostics = {
				enable = true,
				show_on_dirs = true,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			highlight = {
				enable = false,
			},
			indent = {
				enable = true,
			},
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		build = "bash -c 'cd app && npm install'",
		cmd = { "MarkdownPreview" },
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Trouble",
		config = function()
			require("trouble").setup({
				position = "float",
				focus = true,
				win = {
					type = "float",

					border = "rounded",
					size = { width = 0.8, height = 0.4 },
					position = { 0.5, 0.5 },
				},
			})
		end,
	},
	{
		"sudormrfbin/cheatsheet.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {},
	},
	{
		"rcarriga/nvim-notify",
		lazy = false,
		config = function()
			vim.notify = require("notify")
		end,
	},
	{
		"sindrets/diffview.nvim",
		lazy = false,
		config = function() end,
	},
}
