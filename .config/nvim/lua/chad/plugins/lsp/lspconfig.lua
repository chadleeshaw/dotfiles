-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- set capabilities globally for all servers
vim.lsp.config("*", {
	capabilities = cmp_nvim_lsp.default_capabilities(),
})

-- diagnostic signs in the gutter
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- keymaps applied whenever any LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
	callback = function(ev)
		local opts = { noremap = true, silent = true, buffer = ev.buf }
		local keymap = vim.keymap

		-- navigation
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts)       -- go to declaration
		keymap.set("n", "gd", vim.lsp.buf.definition, opts)         -- go to definition
		keymap.set("n", "gi", vim.lsp.buf.implementation, opts)     -- go to implementation
		keymap.set("n", "gr", vim.lsp.buf.references, opts)         -- show references
		keymap.set("n", "K", vim.lsp.buf.hover, opts)               -- hover docs

		-- code actions
		keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- code action
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)      -- smart rename

		-- diagnostics
		keymap.set("n", "<leader>D", vim.diagnostic.open_float, opts) -- line diagnostics
		keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)          -- previous diagnostic
		keymap.set("n", "]d", vim.diagnostic.goto_next, opts)          -- next diagnostic

		-- workspace
		keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts) -- restart lsp
	end,
})

-- configure and enable servers
local servers = {
	"bashls",
	"dockerls",
	"jsonls",
	"remark_ls",
	"pyright",
	"gopls",
	-- salt_ls removed: PyYAML fails to build on Python 3.14+
	"yamlls",
	"taplo",
}

for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end

-- lua_ls needs extra settings to recognise the vim global
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
vim.lsp.enable("lua_ls")
