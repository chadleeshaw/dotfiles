local ok, dracula = pcall(require, "dracula")
if ok then
  dracula.setup({
    show_end_of_buffer = false, -- hide ~ at end of buffer
    transparent_bg = false,
    italic_comment = true,
  })
end

local status, _ = pcall(vim.cmd, "colorscheme dracula")
if not status then
  print("Colorscheme not found!")
end
