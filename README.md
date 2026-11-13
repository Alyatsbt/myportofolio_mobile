# Informasi Pribadi

Nama: Alya Tsabita Imani  
NPM: 2506620192  
Kelas: PBP A

# Panduan Setup Lokal

Ikuti langkah-langkah berikut untuk mengunduh dan menjalankan proyek ini di komputer lokal.

### 1. Clone Repositori

Buka terminal (PowerShell/Git Bash), lalu jalankan:

```bash
git clone https://github.com/Alyatsbt/myportofolio_mobile.git
cd myportofolio_mobile
```

### 2. Persiapkan Flutter Environment

Pastikan Flutter SDK sudah terinstal dan PATH sudah dikonfigurasi dengan benar.

Untuk memeriksa instalasi Flutter, jalankan:

```bash
flutter doctor
```

Pastikan komponen yang diperlukan, seperti Flutter SDK dan Android toolchain, sudah siap digunakan.

### 3. Instalasi Dependencies

Jalankan perintah berikut pada direktori utama proyek (direktori yang berisi `pubspec.yaml`):

```bash
flutter pub get
```

Perintah ini akan mengunduh seluruh dependencies yang dibutuhkan oleh proyek berdasarkan konfigurasi `pubspec.yaml`.

### 4. Jalankan Aplikasi

Pastikan emulator Android sudah berjalan atau perangkat fisik sudah terhubung, kemudian jalankan:

```bash
flutter run
```

Flutter akan melakukan proses build dan menjalankan aplikasi pada perangkat yang dipilih.

### 5. Pemeriksaan Kode

Untuk memastikan tidak terdapat masalah pada kode, jalankan:

```bash
flutter analyze
```

Aplikasi ini telah melalui pemeriksaan dengan hasil `No issues found!`.

---

# Tugas 7

### Pertanyaan Reflektif

[Masukkan enam pertanyaan reflektif beserta jawabannya sesuai requirement Tugas 7.]

### Progress Mingguan

**Full commit history dapat dilihat pada repository Tutorial 08.**

- 11 November 2026:
  1. menyelesaikan tutorial 8 (basic flutter)

- 12 November 2026:
  1. Membuat perubahan pada komponen `InfoCard` untuk menampilkan informasi NPM, nama lengkap, dan kelas.
  2. Melakukan penyesuaian ikon dan warna pada setiap menu agar memiliki tampilan yang berbeda.
  5. Mengimplementasikan interaksi tombol menggunakan `SnackBar` yang menampilkan pesan sesuai dengan tombol yang ditekan.

### AI Disclosure

Menjelaskan penggunaan AI untuk membantu pengerjaan Tugas 7 dan memperdalam pemahaman mengenai pengembangan aplikasi mobile menggunakan Flutter.

**Tools:** ChatGPT

**Link:** [Masukkan link percakapan jika tersedia]

**Penggunaan:**
- Membantu memahami struktur proyek Flutter serta fungsi file seperti `main.dart` dan `menu.dart`.
- Menjelaskan konsep widget dan implementasinya, termasuk `InfoCard` dan `ItemCard`.
- Membantu memahami penggunaan properti widget seperti `color`, `icon`, dan `onPressed` untuk mengatur tampilan serta interaksi aplikasi.
- Membantu mengimplementasikan interaksi tombol menggunakan `SnackBar`.
- Membantu melakukan troubleshooting ketika menjalankan aplikasi melalui emulator serta memahami perbedaan proses hot reload dan hot restart.

AI membantu mempercepat proses pengerjaan, terutama dalam memahami konsep dasar Flutter dan mengatasi kendala teknis selama proses pengembangan. Namun, setiap implementasi tetap diperiksa dan diuji secara langsung melalui emulator untuk memastikan tampilan dan interaksi aplikasi berjalan sesuai dengan yang diharapkan.