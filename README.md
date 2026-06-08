# tenun.nvim

Plugin Neovim untuk bahasa **Tenun**: syntax highlighting + integrasi formatter `tenun fmt`.

## Fitur

- **Syntax highlighting** lengkap: keyword (`biar`, `fungsi`, `kalau`, `coba`, `cocok`, ...), tipe (`bulat`, `teks`, `peta`, ...), konstanta (`benar`/`salah`/`kosong`), builtin (97 fungsi: `cetak`, `httpKirim`, `sha256`, `tegas`, ...), string + escape, angka, komentar `//`.
- **Deteksi filetype** otomatis untuk `*.tenun`.
- **Format** lewat `tenun fmt`: `:TenunFmt`, `gq`, atau format-saat-simpan (opsional).
- Indentasi 4 spasi + `commentstring` `//` (mendukung `gc`).

Daftar keyword/builtin disinkronkan dengan `src/lexer/token.zig` dan `src/builtins/spec.zig` di repo compiler.

## Prasyarat

Biner `tenun` ada di `PATH` (untuk formatter). Cek: `tenun version`.

## Pasang

**lazy.nvim** — taruh di `~/.config/nvim/lua/plugins/tenun.lua`:

```lua
return {
  "TenunLang/tenun-nvim",
  ft = "tenun",        -- muat saat buka berkas .tenun
  opts = {             -- diteruskan ke require("tenun").setup(opts)
    bin = "tenun",            -- path biner tenun (default: cari di PATH)
    format_on_save = false,   -- true = rapikan otomatis saat simpan
  },
}
```

`opts = {}` cukup untuk default. Restart Neovim lalu cek `:Lazy`.

**packer.nvim**

```lua
use({ "TenunLang/tenun-nvim", config = function() require("tenun").setup() end })
```

**vim-plug**

```vim
Plug 'TenunLang/tenun-nvim'
```

**Tanpa plugin manager (git clone via CLI)** — Neovim native package, clone ke `pack/*/start/`:

Linux / macOS:

```bash
git clone https://github.com/TenunLang/tenun-nvim \
  ~/.local/share/nvim/site/pack/tenun/start/tenun-nvim
```

Windows (cmd):

```bat
git clone https://github.com/TenunLang/tenun-nvim "%LOCALAPPDATA%\nvim-data\site\pack\tenun\start\tenun-nvim"
```

Windows (PowerShell):

```powershell
git clone https://github.com/TenunLang/tenun-nvim "$env:LOCALAPPDATA\nvim-data\site\pack\tenun\start\tenun-nvim"
```

Update: `git -C <path-di-atas> pull`. Hapus: hapus folder itu.

Highlighting + deteksi filetype jalan tanpa `setup()`. `setup()` hanya perlu untuk opsi (mis. format-saat-simpan).

## Pakai

- `:TenunFmt` — rapikan buffer aktif.
- `gqap` / `gggqG` — format via `formatexpr`.

## Konfigurasi

```lua
require("tenun").setup({
  bin = "tenun",          -- path biner tenun
  format_on_save = false, -- rapikan otomatis di BufWritePre
})
```

> **Peringatan:** `tenun fmt` saat ini berbasis AST dan **menghapus komentar**. Karena itu `format_on_save` default `false`. Aktifkan hanya bila kode tak punya komentar penting, atau tunggu formatter mempertahankan komentar.

## Lisensi

MIT.
