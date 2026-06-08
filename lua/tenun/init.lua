-- tenun.nvim — integrasi formatter `tenun fmt` untuk Neovim.
local M = {}

M.config = {
  -- Path biner tenun (default cari di PATH).
  bin = "tenun",
  -- Rapikan otomatis saat simpan (BufWritePre).
  -- PERINGATAN: `tenun fmt` saat ini berbasis AST dan MENGHAPUS komentar.
  -- Biarkan false sampai formatter mempertahankan komentar.
  format_on_save = false,
}

-- Jalankan `tenun fmt` atas isi buffer, kembalikan baris hasil atau nil + pesan error.
local function run_fmt(lines)
  local tmp = vim.fn.tempname() .. ".tenun"
  vim.fn.writefile(lines, tmp)
  local out = vim.fn.systemlist({ M.config.bin, "fmt", tmp, "--stdout" })
  local code = vim.v.shell_error
  vim.fn.delete(tmp)
  if code ~= 0 then
    return nil, table.concat(out, "\n")
  end
  return out
end

-- Rapikan seluruh buffer aktif, pertahankan posisi layar/kursor.
function M.format()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local out, err = run_fmt(lines)
  if not out then
    vim.notify("tenun fmt gagal:\n" .. (err or "?"), vim.log.levels.ERROR, { title = "tenun.nvim" })
    return
  end
  -- Lewati jika tak ada perubahan (hindari menandai buffer modified percuma).
  if table.concat(out, "\n") == table.concat(lines, "\n") then
    return
  end
  local view = vim.fn.winsaveview()
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, out)
  vim.fn.winrestview(view)
end

-- Untuk 'formatexpr' (gq). Saat mengetik (v:char tak kosong) serahkan ke Neovim.
function M.formatexpr()
  if vim.v.char ~= "" then
    return 1
  end
  M.format()
  return 0
end

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  vim.api.nvim_create_user_command("TenunFmt", function()
    M.format()
  end, { desc = "Rapikan buffer Tenun dengan `tenun fmt`" })

  if M.config.format_on_save then
    local grp = vim.api.nvim_create_augroup("TenunFormatOnSave", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = grp,
      pattern = "*.tenun",
      callback = function()
        M.format()
      end,
    })
  end
end

return M
