local ok, wk = pcall(require, "which-key")
if not ok then
	return
end

wk.setup({
	preset = "modern",
	delay = 400, -- ms before popup appears
	icons = {
		rules = false, -- don't override icons per-mapping
	},
})

-- register top-level group labels so the popup is readable
wk.add({
	{ "<leader>f",  group = "find (telescope)" },
	{ "<leader>g",  group = "git" },
	{ "<leader>h",  group = "git hunks" },
	{ "<leader>s",  group = "splits / session" },
	{ "<leader>t",  group = "tabs" },
	{ "<leader>x",  group = "trouble / diagnostics" },
	{ "<leader>o",  group = "outline" },
	{ "<leader>a",  group = "harpoon" },
	{ "<leader>d",  group = "diffview" },
})
