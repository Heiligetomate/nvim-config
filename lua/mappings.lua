require "nvchad.mappings"

local map = vim.keymap.set

map("i", "<C-f>", "∫", { desc = "Insert integral symbol" })
map("i", "<C-e>", "\u{02E3}", { desc = "Insert ˣ" })
map("n", "<C-q>", "<cmd>wq<cr>", { noremap = true, nowait = true, desc = "quit" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<S-Down>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<S-Up>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

map("n", "<S-Right>", ">>", { desc = "Indent" })
map("n", "<S-Left>", "<<", { desc = "Unindent" })
map("v", "<S-Right>", ">gv", { desc = "Indent selection" })
map("v", "<S-Left>", "<gv", { desc = "Unindent selection" })

map("n", "<leader>cs", "<cmd>Cheatsheet<cr>", { desc = "Cheatsheet" })

map("n", "<leader>n", "<Nop>")
map("n", "<leader>nn", function()
  require("notify").dismiss { silent = true, pending = true }
end, { desc = "Clear notifications" })

map("n", "<leader>nc", function()
  local history = require("notify").history()
  local last = history[#history]
  if last then
    vim.fn.setreg("+", table.concat(last.message, "\n"))
    vim.notify("Copied!", vim.log.levels.INFO)
  end
end, { desc = "Copy last notification" })

map("n", "<Esc>", function()
  vim.lsp.buf.clear_references()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, true)
    end
  end
end)

map("n", "<leader>cy", function()
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

map("n", "<leader>u", function()
  local word = vim.fn.expand "<cWORD>"
  vim.fn.jobstart({ "xdg-open", word }, { detach = true })
end, { desc = "Open URL under cursor" })

map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear search highlights" })

map("n", "<leader>tr", "<cmd>Trouble lsp_references toggle<cr>", { desc = "Toggle References" })
map("n", "<leader>td", "<cmd>Trouble diagnostics focus=true<cr>", { desc = "Open Diagnostics" })

map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader>do", "<cmd>DiffviewOpen<cr>", { desc = "Open diff view" })
map("n", "<leader>dc", "<cmd>DiffviewClose<cr>", { desc = "Close diff view" })

map("n", "<leader>rs", function()
  vim.cmd "normal crs"
end, { desc = "snake_case" })
map("n", "<leader>rc", function()
  vim.cmd "normal crc"
end, { desc = "camelCase" })
map("n", "<leader>rm", function()
  vim.cmd "normal crm"
end, { desc = "MixedCase" })
map("n", "<leader>ru", function()
  vim.cmd "normal cru"
end, { desc = "UPPER_CASE" })

for i = 1, 9 do
  map("n", "<leader>t" .. i, i .. "gt", { desc = "Go to tab " .. i })
end
