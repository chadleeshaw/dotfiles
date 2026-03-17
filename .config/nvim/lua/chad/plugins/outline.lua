local ok, outline = pcall(require, "outline")
if not ok then
	return
end

outline.setup({
	outline_window = {
		position = "right",
		width = 30,
		auto_close = true, -- close when jumping to a symbol
	},
	symbol_folding = {
		autofold_depth = 1, -- fold everything below top level on open
	},
})

vim.keymap.set("n", "<leader>oo", "<cmd>Outline<cr>", { desc = "Outline: toggle" })
