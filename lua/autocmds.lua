require "nvchad.autocmds"

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
