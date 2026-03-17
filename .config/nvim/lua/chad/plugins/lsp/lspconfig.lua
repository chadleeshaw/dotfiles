-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(_, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- navigation
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
	keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- go to definition
	keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- go to implementation
	keymap.set("n", "gr", vim.lsp.buf.references, opts) -- show references
	keymap.set("n", "K", vim.lsp.buf.hover, opts) -- hover docs

	-- code actions
	keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- code action
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

	-- diagnostics
	keymap.set("n", "<leader>D", vim.diagnostic.open_float, opts) -- line diagnostics
	keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- previous diagnostic
	keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- next diagnostic

	-- workspace
	keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- restart lsp
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

lspconfig["bashls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["dockerls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["jsonls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["remark_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["pyright"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["gopls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["salt_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["yamlls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["taplo"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
