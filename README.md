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

**Full commit history dapat dilihat pada repository Tugas 07.**

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

**Link:** https://chatgpt.com/share/6af69920-72cc-83ec-959c-852b299bd1b3 

**Penggunaan:**
- Membantu memahami struktur proyek Flutter serta fungsi file seperti `main.dart` dan `menu.dart`.
- Menjelaskan konsep widget dan implementasinya, termasuk `InfoCard` dan `ItemCard`.
- Membantu memahami penggunaan properti widget seperti `color`, `icon`, dan `onPressed` untuk mengatur tampilan serta interaksi aplikasi.
- Membantu mengimplementasikan interaksi tombol menggunakan `SnackBar`.
- Membantu melakukan troubleshooting ketika menjalankan aplikasi melalui emulator serta memahami perbedaan proses hot reload dan hot restart.
- Membantu mengembangkan navigasi antarhalaman menggunakan Navigator.push() dan memahami konsep empty state pada halaman proyek.
- Membantu memahami implementasi StatefulWidget, setState(), dan pengelolaan state untuk membuat tombol Login/Logout yang dinamis.

AI membantu mempercepat proses pengerjaan, terutama dalam memahami konsep dasar Flutter dan mengatasi kendala teknis selama proses pengembangan. Namun, setiap implementasi tetap diperiksa dan diuji secara langsung melalui emulator untuk memastikan tampilan dan interaksi aplikasi berjalan sesuai dengan yang diharapkan.


---

# Tugas 8

### Pertanyaan Reflektif

1. Navigator.push() digunakan untuk membuka halaman baru di atas halaman saat ini, sehingga pengguna dapat kembali ke halaman sebelumnya. Navigator.pushReplacement() digunakan untuk mengganti halaman saat ini dengan halaman baru, sedangkan Navigator.pop() digunakan untuk menutup halaman aktif dan kembali ke halaman sebelumnya. Pada proyek ini, Navigator.push() digunakan untuk membuka formulir dari kartu aksi. Sementara itu, opsi Home pada Drawer menggunakan navigasi untuk mengarahkan pengguna kembali ke halaman utama.

2. Scaffold menyediakan struktur dasar halaman, seperti AppBar, Drawer, dan body. AppBar berfungsi sebagai header, sedangkan Drawer menyediakan menu navigasi. Penggunaan struktur tersebut membantu menjaga layout antarhalaman tetap konsisten. Konsistensi juga diterapkan melalui penggunaan warna tema portfolio, misalnya warna utama yang digunakan pada AppBar halaman utama dan tombol pada halaman formulir.

3. Layout formulir menggunakan susunan vertikal agar input dapat diisi secara berurutan dan mudah dipahami. SizedBox digunakan untuk mengatur jarak antar-komponen agar tampilan lebih rapi, sedangkan SingleChildScrollView memungkinkan pengguna menggulir formulir ketika seluruh komponen tidak muat pada layar, sehingga setiap field dan tombol tetap dapat diakses.

4. GlobalKey<FormState> digunakan untuk mengakses state dan melakukan validasi pada form. validator berfungsi menentukan aturan validasi pada setiap input, sedangkan validate() menjalankan seluruh validator ketika tombol Save ditekan. Jika input tidak memenuhi aturan, proses penyimpanan tidak dilanjutkan dan pesan error akan ditampilkan. Contohnya, input kosong ditolak karena field wajib diisi. Pemilihan jenis input atau keyboard saja tidak cukup karena hanya membantu membatasi atau mempermudah input, tetapi tidak menjamin data yang dimasukkan telah memenuhi aturan validasi aplikasi.


### Progress Mingguan

**Full commit history dapat dilihat pada repository Tugas 08.**

- **18 November 2026:**
  1. Menyelesaikan Tutorial 9: Flutter Navigation, Layouts, Forms, and Navigation.

- **23 November 2026:**
  1. Mengimplementasikan form Experience untuk menambahkan data pengalaman pada portfolio.
  2. Mengembangkan navigasi menuju form Experience dari halaman utama.
  3. Merapikan struktur komponen form Experience dengan membaginya ke dalam beberapa section serta menyesuaikan styling.

**### AI Disclosure**

Menjelaskan penggunaan AI untuk membantu pengerjaan Tutorial 9 dan memperdalam pemahaman mengenai navigasi, layout, dan form pada Flutter.

**Tools:** ChatGPT

**Link:** https://chatgpt.com/share/6b03df75-240c-83ec-a46d-d64f5c85e70b 

**Penggunaan:**
- Membantu memahami konsep navigasi antarhalaman menggunakan `Navigator.push()`, `Navigator.pop()`, dan `Navigator.pushReplacement()`.
- Menjelaskan penggunaan `Drawer` sebagai komponen navigasi serta implementasinya untuk berpindah halaman.
- Membantu memahami susunan layout menggunakan widget seperti `Column`, `Row`, `Padding`, dan widget lainnya sesuai kebutuhan tampilan.
- Menjelaskan implementasi form menggunakan `TextFormField`, `DropdownButtonFormField`, `GlobalKey<FormState>`, dan validator untuk memvalidasi input pengguna.
- Membantu memahami penggunaan `AlertDialog` untuk menampilkan data yang telah dimasukkan melalui form.
- Membantu merapikan struktur kode dan memisahkan komponen form ke dalam beberapa section agar lebih terorganisir dan mudah dipahami.

AI digunakan sebagai sarana untuk membantu memahami konsep, memberikan arahan implementasi, serta mengatasi kendala selama pengembangan. Setiap implementasi kemudian diperiksa dan diuji secara langsung untuk memastikan aplikasi berjalan sesuai dengan yang diharapkan.


