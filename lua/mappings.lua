require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<S-Down>", ":m .+1<CR>==")
map("n", "<S-Up>", ":m .-2<CR>==")
map("v", "<S-Down>", ":m '>+1<CR>gv=gv")
map("v", "<S-Up>", ":m '<-2<CR>gv=gv")

map("n", "<S-Right>", ">>")
map("n", "<S-Left>", "<<")
map("v", "<S-Right>", ">gv")
map("v", "<S-Left>", "<gv")

vim.keymap.set("n", "<Esc>", function()
  vim.lsp.buf.clear_references()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, true)
    end
  end
end)

vim.keymap.set("n", "<leader>cy", function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line "." - 1 })
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
  local word = vim.fn.expand "<cWORD>"
  vim.fn.jobstart({ "xdg-open", word }, { detach = true })
end, { desc = "Open URL under cursor" })

vim.keymap.set("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<leader>tr", "<cmd>Trouble lsp_references toggle<cr>", { desc = "Toggle References" })
vim.keymap.set("n", "<leader>td", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle Diagnostics" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close tab" })

for i = 1, 9 do
  vim.keymap.set("n", "<leader>t" .. i, i .. "gt", { desc = "Go to tab " .. i })
end
