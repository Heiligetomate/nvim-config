require("nvchad.options")

vim.opt.swapfile = false

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.opt_local.spell = false
	end,
})

vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	float = {
		max_width = 80,
		wrap = true,
		border = "rounded",
	},
})

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		vim.defer_fn(function()
			vim.opt_local.foldmethod = "expr"
			vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.opt_local.foldenable = true
			vim.opt_local.foldlevel = 99
		end, 100)
	end,
})
