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

1. *Widget tree* merupakan struktur hierarki yang menggambarkan hubungan antar-widget dalam aplikasi Flutter. Setiap widget dapat memiliki widget lain sebagai *child*, sehingga membentuk susunan dari root widget hingga komponen paling kecil. Hubungan *parent-child* ini memungkinkan tampilan aplikasi dibangun secara bertingkat. Contohnya, `MaterialApp` menjadi induk dari `Scaffold`, kemudian `Scaffold` memiliki `AppBar` dan `body` sebagai bagian dari tampilannya.

2. Beberapa widget yang digunakan dalam proyek ini antara lain:
   - `MaterialApp`: menjadi konfigurasi utama aplikasi.
   - `Scaffold`: menyediakan struktur dasar halaman, seperti AppBar dan body.
   - `AppBar`: menampilkan bagian header aplikasi.
   - `Column`: menyusun widget secara vertikal.
   - `Row`: menyusun widget secara horizontal.
   - `Text`: menampilkan teks.
   - `Icon`: menampilkan ikon.
   - `Container`: menyediakan wadah untuk mengatur ukuran, warna, dan dekorasi komponen.
   - `Padding` dan `SizedBox`: mengatur jarak antar-widget.
   - `Card`: menampilkan komponen dalam bentuk kartu.
   - `InfoCard`: widget khusus yang dibuat untuk menampilkan informasi NPM, nama, dan kelas.
   - `ItemCard`: widget khusus yang dibuat untuk menampilkan menu beserta ikon dan interaksinya.
   - `ElevatedButton` / widget tombol yang digunakan: menyediakan tombol interaktif.
   - `SnackBar`: menampilkan pesan sementara ketika tombol ditekan.
   - `AlertDialog`: menampilkan dialog konfirmasi Login dan Logout.
   - `TextButton`: menyediakan pilihan aksi pada dialog.
   - `SnackBar`: menampilkan feedback sementara setelah pengguna melakukan interaksi.
   - `Navigator dan MaterialPageRoute`: menangani navigasi dari halaman utama menuju halaman proyek.
   - `ProjectPage`: widget khusus yang menampilkan halaman proyek beserta empty state.

3. `MaterialApp` merupakan widget yang menyediakan konfigurasi dasar aplikasi dengan desain Material Design. Widget ini umumnya digunakan sebagai *root widget* karena mengatur hal-hal mendasar seperti tema, navigasi, dan halaman awal aplikasi. Dengan menjadikannya root, widget lain di dalam aplikasi dapat mengakses konfigurasi Material Design yang disediakan, sehingga pengembangan tampilan dan navigasi menjadi lebih terstruktur.

4. `StatelessWidget` merupakan widget yang tidak memiliki state internal yang dapat berubah selama siklus hidupnya, sehingga tampilannya bergantung pada konfigurasi yang diterima. Sementara itu, `StatefulWidget` memiliki state yang dapat berubah dan menyebabkan tampilan dibangun ulang, biasanya melalui pemanggilan `setState()`. `StatelessWidget` cocok digunakan untuk komponen statis seperti seperti `InfoCard` dan `ProjectPage`., sedangkan `StatefulWidget` digunakanpada `MyHomePage` karena perlu mengelola perubahan status Login dan Logout yang memengaruhi teks serta ikon tombol secara dinamis.

5. `BuildContext` merupakan referensi terhadap posisi sebuah widget di dalam widget tree. `BuildContext` penting karena memungkinkan widget mengakses informasi dari widget induknya, seperti tema, navigasi, maupun konfigurasi lainnya. Di dalam metode `build(BuildContext context)`, context digunakan untuk mengakses informasi tersebut, contohnya `Theme.of(context)` untuk memperoleh tema aplikasi atau `ScaffoldMessenger.of(context)` untuk menampilkan `SnackBar`.

6. *Hot reload* merupakan fitur Flutter yang memungkinkan perubahan kode diterapkan ke aplikasi yang sedang berjalan tanpa mengulang seluruh proses dari awal. State aplikasi umumnya tetap dipertahankan sehingga proses pengembangan menjadi lebih cepat. Berbeda dengan *hot restart*, yang menjalankan ulang aplikasi dari awal dan menghilangkan state yang sedang tersimpan. *Hot reload* tidak selalu cukup, misalnya ketika mengubah konfigurasi yang memengaruhi proses inisialisasi aplikasi atau melakukan perubahan pada struktur tertentu yang tidak dapat diterapkan melalui hot reload. Dalam kondisi tersebut, hot restart diperlukan. Sementara itu, *full restart* atau menjalankan ulang aplikasi diperlukan ketika perubahan melibatkan proses build, native code, atau konfigurasi platform yang tidak dapat diperbarui hanya dengan hot restart.


### Progress Mingguan

**Full commit history dapat dilihat pada repository Tutorial 08.**

- 11 November 2026:
  1. menyelesaikan tutorial 8 (basic flutter)

- 12 November 2026:
  1. Membuat perubahan pada komponen `InfoCard` untuk menampilkan informasi NPM, nama lengkap, dan kelas.
  2. Melakukan penyesuaian ikon dan warna pada setiap menu agar memiliki tampilan yang berbeda.

- 13 November 2026:
  1. Mengembangkan halaman Project dengan menambahkan navigasi menggunakan `Navigator.push()` serta tampilan empty state ketika belum terdapat proyek.
  2. Mengimplementasikan fitur simulasi Login/Logout menggunakan `StatefulWidget` dan `setState()` untuk mengelola perubahan status pengguna.
  3. Menambahkan `AlertDialog` sebagai konfirmasi sebelum melakukan Login maupun Logout.


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
- Membantu mengembangkan navigasi antarhalaman menggunakan Navigator.push() dan memahami konsep empty state pada halaman proyek.
- Membantu memahami implementasi StatefulWidget, setState(), dan pengelolaan state untuk membuat tombol Login/Logout yang dinamis.

AI membantu mempercepat proses pengerjaan, terutama dalam memahami konsep dasar Flutter dan mengatasi kendala teknis selama proses pengembangan. Namun, setiap implementasi tetap diperiksa dan diuji secara langsung melalui emulator untuk memastikan tampilan dan interaksi aplikasi berjalan sesuai dengan yang diharapkan.