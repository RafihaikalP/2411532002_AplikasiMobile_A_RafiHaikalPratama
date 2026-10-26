# Expense Tracker — Gabungan Praktikum 1–5 (Flutter)

Satu project dari hasil Praktikum 1–5 dengan tambahan:

| Ketentuan tugas | Implementasi |
|---|---|
| 1. Local storage | **SQLite** (`sqflite`) — tabel `users` & `transactions`, data tidak hilang saat app ditutup |
| 2. Login & Register | `login_screen.dart`, `register_screen.dart`; password di-hash (SHA-256 + salt); sesi login disimpan (`shared_preferences`) |
| 3. Video penjelasan | lihat `NASKAH_VIDEO.md` |
| 4. File APK | lihat "Build APK" di bawah |
| Catatan: UI/UX dipertahankan | Dashboard, Form, Detail, Bottom Nav, Riwayat, Profil mengikuti modul; hanya Login & Register yang baru |

## Asal tiap bagian (dari modul)
- **Prak 1** — `GreetingWidget` (Stateless), `BalanceCardWidget` + ikon mata (Stateful, `setState`) → `dashboard_screen.dart`
- **Prak 2** — tombol aksi (`Row`), daftar transaksi (`Column` + `ListTile`), `SingleChildScrollView` → `dashboard_screen.dart`
- **Prak 3** — form (`TextFormField`, `Dropdown`, validasi, `showDatePicker`) → `add_transaction_screen.dart`
- **Prak 4** — `Navigator.push` + passing data lewat constructor, `Navigator.pop` → `transaction_detail_screen.dart`
- **Prak 5** — Named Routes + `BottomNavigationBar` (Beranda, Riwayat, Profil) → `main.dart`, `main_screen.dart`, `history_screen.dart`, `profile_screen.dart`

## Perubahan dari data statis → database
- Saldo dihitung dari transaksi (pemasukan − pengeluaran) milik user yang login.
- Daftar "Transaksi Terakhir" & Riwayat dibaca dari SQLite. Geser item di Riwayat untuk menghapus.
- Tombol Masuk / Keluar / Transfer membuka form dengan jenis yang sesuai.
- Satu-satunya tambahan di form: dropdown **Jenis** (Pemasukan/Pengeluaran), karena saldo butuh membedakannya.
- Warna AppBar memakai tema amber (Prak 5) dengan teks gelap agar terbaca.

## Cara menjalankan
```bash
# di dalam folder project ini
flutter create --project-name expense_tracker --org com.example --platforms=android .
flutter pub get
flutter run
```
> `flutter create .` hanya membuat folder `android/` (dan file pendukung). Jika ia menimpa `lib/main.dart`,
> kembalikan `main.dart` dari project ini. Hapus `test/widget_test.dart` jika muncul error.

## Build APK
```bash
flutter build apk --release
```
Hasil: `build/app/outputs/flutter-apk/app-release.apk`

**Alternatif tanpa install Flutter:** upload project ke GitHub → tab **Actions** → *Build APK* → Run workflow
→ unduh artifact `app-release-apk`.

## Struktur
```
lib/
  main.dart                      # named routes
  db/database_helper.dart        # SQLite
  models/                        # AppUser, TransactionItem
  services/auth_service.dart     # register, login, logout, sesi
  utils/format.dart              # format Rupiah & tanggal
  screens/                       # splash, login, register, main, dashboard,
                                 # add_transaction, transaction_detail, history, profile
```
