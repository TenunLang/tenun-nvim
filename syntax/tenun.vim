" Vim syntax file
" Language: Tenun
" Maintainer: TenunLang
" Note: daftar keyword/builtin disinkronkan dengan src/lexer/token.zig dan
"       src/builtins/spec.zig di repo compiler Tenun.

if exists("b:current_syntax")
  finish
endif

" --- Komentar ---
syntax match tenunComment "//.*$" contains=@Spell

" --- String + escape ---
syntax region tenunString start=/"/ skip=/\\./ end=/"/ contains=tenunEscape
syntax match tenunEscape "\\[ntr0\"\\]" contained

" --- Angka ---
syntax match tenunNumber "\<[0-9]\+\(\.[0-9]\+\)\?\>"

" --- Keyword kontrol & deklarasi ---
syntax keyword tenunKeyword biar tetap fungsi kembali kalau lain selama untuk dari sampai impor henti lanjut coba tangkap cocok

" --- Konstanta literal ---
syntax keyword tenunBoolean benar salah
syntax keyword tenunNull kosong

" --- Tipe ---
syntax keyword tenunType bulat desimal teks bool peta dinamis

" --- Builtin (sinkron dgn spec.zig) ---
syntax keyword tenunBuiltin cetak panjang ambil akar pangkat mutlak bulatkan panjangTeks potong
syntax keyword tenunBuiltin bacaFile tulisFile layani layaniSoket statusKan headerKan cari ganti
syntax keyword tenunBuiltin pisah gabung mulaiDengan akhiriDengan tipeKonten jsonTeks jsonAngka jsonBool
syntax keyword tenunBuiltin adaFile kueri form headerMasuk cookie simpan muat hapus
syntax keyword tenunBuiltin sambung kirim terima terimaPasti tutup
syntax keyword tenunBuiltin sha256 sha1 md5 hmacSha256 sha256Raw hmacSha256Raw sha1Raw pbkdf2 base64 dariBase64
syntax keyword tenunBuiltin acak acakAngka acakDesimal xor keByte bacaInt bacaFloat keBulat keDesimal keTeks dorong
syntax keyword tenunBuiltin petaPunya petaKunci petaHapus httpKirim
syntax keyword tenunBuiltin sambungAman kirimAman terimaAman tutupAman siarkan
syntax keyword tenunBuiltin argumen waktu waktuMili pangkas keBesar keKecil tanggal
syntax keyword tenunBuiltin infoOS lingkungan jalankan daftarBerkas buatDir hapusBerkas hapusDir ukuranBerkas apakahDir
syntax keyword tenunBuiltin eksp ln log sin cos tan tanh lantai langit
syntax keyword tenunBuiltin desimalDari bulatDari teksDari bacaGambar
syntax keyword tenunBuiltin tegas tegasSama tegasSamaBulat

" --- Definisi fungsi: nama setelah `fungsi` ---
syntax match tenunFunction "\<fungsi\>\s\+\zs[a-zA-Z_][a-zA-Z0-9_]*"

" --- Pemanggilan fungsi (nama diikuti `(` ) ---
syntax match tenunCall "\<[a-zA-Z_][a-zA-Z0-9_]*\>\ze\s*(" contains=tenunBuiltin,tenunKeyword

" --- Operator ---
syntax match tenunOperator "==\|!=\|<=\|>=\|&&\|||\|[-+*/%<>!=]"

" --- Highlight links ---
highlight default link tenunComment   Comment
highlight default link tenunString    String
highlight default link tenunEscape    SpecialChar
highlight default link tenunNumber    Number
highlight default link tenunKeyword   Keyword
highlight default link tenunBoolean   Boolean
highlight default link tenunNull      Constant
highlight default link tenunType      Type
highlight default link tenunBuiltin   Function
highlight default link tenunFunction  Function
highlight default link tenunCall      None
highlight default link tenunOperator  Operator

let b:current_syntax = "tenun"
