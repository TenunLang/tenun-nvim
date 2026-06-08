-- Pengaturan buffer untuk berkas .tenun.
if vim.b.did_ftplugin_tenun then
  return
end
vim.b.did_ftplugin_tenun = true

local bo = vim.bo

-- Komentar gaya C++ (//), dipakai gc / commentstring.
bo.commentstring = "// %s"
vim.opt_local.comments = "://"

-- Indentasi 4 spasi, kurawal K&R (sesuai output `tenun fmt`).
bo.expandtab = true
bo.shiftwidth = 4
bo.tabstop = 4
bo.softtabstop = 4

-- Sambungkan ke formatter Tenun lewat `gq` / `:Fmt`.
bo.formatexpr = "v:lua.require'tenun'.formatexpr()"

-- Perintah buffer-lokal untuk format manual.
vim.api.nvim_buf_create_user_command(0, "TenunFmt", function()
  require("tenun").format()
end, { desc = "Rapikan buffer Tenun dengan `tenun fmt`" })
