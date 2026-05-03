require("nvchad.mappings")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
vim.keymap.set("n", "<Esc>", function()
	vim.lsp.buf.clear_references()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			vim.api.nvim_win_close(win, true)
		end
	end
end)

vim.keymap.set("n", "<leader>cy", function()
	local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
	if #diagnostics == 0 then
		return
	end
	local msg = table.concat(
		vim.tbl_map(function(d)
			return d.message
		end, diagnostics),
		"\n"
	)
	vim.fn.setreg("+", msg)
	print("Copied diagnostic: " .. msg)
end, { desc = "Copy diagnostic message" })

vim.keymap.set("n", "<leader>u", function()
	local word = vim.fn.expand("<cWORD>")
	vim.fn.jobstart({ "xdg-open", word }, { detach = true })
end, { desc = "Open URL under cursor" })
