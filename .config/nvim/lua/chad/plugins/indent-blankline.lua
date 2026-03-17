local ok, ibl = pcall(require, "ibl")
if not ok then
	return
end

ibl.setup({
	indent = {
		char = "│",
	},
	scope = {
		enabled = true,   -- highlight the current scope's indent level
		show_start = true,
		show_end = false,
	},
})
