require("nvchad.configs.lspconfig").defaults()

vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			inlayHints = {
				bindingModeHints = { enable = true },
				chainingHints = { enable = true },
				closingBraceHints = { enable = true },
				parameterHints = { enable = true },
				typeHints = { enable = true },
			},
		},
	},
})

local servers = { "html", "cssls", "rust_analyzer", "tinymist" }
vim.lsp.enable(servers)
