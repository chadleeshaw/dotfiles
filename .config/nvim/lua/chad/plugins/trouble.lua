local ok, trouble = pcall(require, "trouble")
if not ok then
	return
end

trouble.setup({
	modes = {
		diagnostics = { auto_close = true },
	},
})

local keymap = vim.keymap
keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",        { desc = "Diagnostics (workspace)" })
keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Diagnostics (buffer)" })
keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle<cr>",             { desc = "Symbols" })
keymap.set("n", "<leader>xl", "<cmd>Trouble lsp toggle<cr>",                 { desc = "LSP references / defs" })
keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>",              { desc = "Quickfix list" })
keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>",             { desc = "Location list" })
