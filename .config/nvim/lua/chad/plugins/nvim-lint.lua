local lint_status, lint = pcall(require, "lint")
if not lint_status then
	return
end

lint.linters_by_ft = {
	sh = { "shellcheck" },
	bash = { "shellcheck" },
	python = { "pylint" },
}

-- run linter on open and after save
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	callback = function()
		lint.try_lint()
	end,
})
