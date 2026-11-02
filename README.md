# AnimeVerse

Proyek praktikum Flutter yang mengikuti tampilan dan struktur
[IKLC-anime-verse milik mhddzakwan](https://github.com/mhddzakwan/IKLC-anime-verse),
commit acuan `ce20c72`.

Halaman: Sign In, Sign Up, Home, Favorite, Profile, dan Detail Anime.
Font Urbanist, aset anime, latar gradien, dan komponen mengikuti contoh aslab.

## Menjalankan

```sh
flutter pub get
flutter run
```

Versi lokal memakai Dart 3.9.2 dan `go_router` 16.2.1 agar cocok dengan
Flutter yang terpasang. Konfigurasi Android lokal tetap dipakai.

## Status fitur contoh

Sign In dan Sign Up langsung menuju Home sebagai demo; belum ada autentikasi
atau penyimpanan akun. Login Google, lupa password, pencarian, filter genre,
pengaturan profil, dan perubahan favorit masih placeholder seperti repository
acuan. Halaman favorit menggunakan data dummy. Detail menampilkan anime yang
dipilih dari katalog.

## Verifikasi

```sh
flutter analyze
flutter test
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
