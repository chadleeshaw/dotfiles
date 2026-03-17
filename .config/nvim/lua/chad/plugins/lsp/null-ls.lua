-- import none-ls (null-ls fork) plugin safely
local null_ls_status, null_ls = pcall(require, "null-ls")
if not null_ls_status then
	return
end

-- for conciseness
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	sources = {
		formatting.stylua, -- lua formatter
		formatting.gofmt, -- go formatter
		formatting.beautysh, -- bash formatter
		diagnostics.pylint, -- python linter
		diagnostics.codespell, -- spell checker
	},
	-- format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = "LspFormatting", buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("LspFormatting", {}),
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
