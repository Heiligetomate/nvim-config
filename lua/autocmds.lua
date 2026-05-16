require("nvchad.autocmds")

vim.api.nvim_create_autocmd("BufReadPost", {
	once = true,
	callback = function()
		vim.diagnostic.config({
			virtual_text = false,
			signs = true,
			float = {
				max_width = 80,
				wrap = true,
				border = "rounded",
			},
		})
	end,
})

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_config(win).relative ~= "" then
				return
			end
		end
		vim.diagnostic.open_float(nil, {
			focus = false,
			max_width = 80,
			wrap = true,
			border = "rounded",
		})
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*.rs",
	callback = function()
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt_local.foldenable = true
		vim.opt_local.foldlevel = 99
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	once = true,
	callback = function(args)
		vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
		vim.diagnostic.config({
			virtual_text = false,
			signs = true,
			float = {
				max_width = 80,
				wrap = true,
				border = "rounded",
			},
		})
	end,
})

local function update_array_hints(bufnr)
	local ns = vim.api.nvim_create_namespace("json_array_hints")
	vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

	local parser = vim.treesitter.get_parser(bufnr, "json")
	if not parser then
		return
	end
	local tree = parser:parse()[1]
	if not tree then
		return
	end

	local query = vim.treesitter.query.parse("json", "(array) @arr")

	for _, node in query:iter_captures(tree:root(), bufnr) do
		local count = 0
		for child in node:iter_children() do
			if child:named() then
				count = count + 1
			end
		end
		local row = select(1, node:start())
		vim.api.nvim_buf_set_extmark(bufnr, ns, row, -1, {
			virt_text = { { "  󰅪 " .. count .. " items", "Comment" } },
			virt_text_pos = "eol",
		})
	end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged" }, {
	pattern = "*.json",
	callback = function(args)
		update_array_hints(args.buf)
	end,
})
