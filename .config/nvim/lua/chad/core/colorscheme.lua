-- configure tokyonight before applying
local ok, tokyonight = pcall(require, "tokyonight")
if ok then
  tokyonight.setup({
    style = "night", -- night | storm | moon | day
    transparent = false,
  })
end

-- apply colorscheme
local status, _ = pcall(vim.cmd, "colorscheme tokyonight")
if not status then
  print("Colorscheme not found!")
end
