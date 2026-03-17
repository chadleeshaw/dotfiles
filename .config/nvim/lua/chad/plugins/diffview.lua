local ok, diffview = pcall(require, "diffview")
if not ok then
	return
end

diffview.setup({
	enhanced_diff_hl = true, -- better diff highlights
})

local keymap = vim.keymap
keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<cr>",          { desc = "Diffview: open" })
keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<cr>",         { desc = "Diffview: close" })
keymap.set("n", "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview: file history" })
keymap.set("n", "<leader>dH", "<cmd>DiffviewFileHistory<cr>",   { desc = "Diffview: repo history" })
