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

**lazy.nvim**

```lua
{
  "TenunLang/tenun-nvim",
  ft = "tenun",
  opts = {},          -- panggil require("tenun").setup(opts)
}
```

**packer.nvim**

```lua
use({ "TenunLang/tenun-nvim", config = function() require("tenun").setup() end })
```

**vim-plug**

```vim
Plug 'TenunLang/tenun-nvim'
```

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
