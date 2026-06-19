# Batasan Scope Website Sultan Cell

Dokumen ini dibuat sebagai batasan pengembangan website agar fitur yang dibuat tetap sesuai kebutuhan operasional Sultan Cell dan tidak melebar ke ranah yang tidak diminta.

## Tujuan Website

Website ini dibuat sebagai sistem operasional internal Sultan Cell untuk membantu admin yang merangkap sebagai kasir dalam mencatat dan mengelola aktivitas toko.

Fokus utama website:

- Kasir penjualan konter.
- Pengelolaan stok barang.
- Pendataan layanan BRILink.
- Pengaturan biaya admin BRILink per layanan dan range nominal.
- Laporan penjualan.
- Backup data.
- Riwayat aktivitas.

## Aktor Sistem

Aktor utama pada website ini hanya:

**Admin yang merangkap sebagai kasir**

Admin/kasir bertugas:

- Login ke sistem.
- Menginput barang.
- Melakukan transaksi penjualan.
- Mencatat layanan BRILink.
- Mengelola aturan biaya admin BRILink per layanan dan range nominal.
- Melihat laporan.
- Melakukan backup data.

Pelanggan tidak menggunakan website secara langsung.

## Scope Yang Termasuk Dalam Website

### 1. Login Admin

Website menyediakan login untuk admin/kasir agar hanya pengguna internal yang dapat masuk ke dashboard.

### 2. Dashboard

Dashboard digunakan untuk menampilkan ringkasan operasional, seperti penjualan hari ini, transaksi BRILink, stok menipis, transaksi terbaru, dan aktivitas sistem.

### 3. Data Barang

Data barang digunakan untuk mencatat produk yang dijual di konter, seperti HP, aksesoris, kartu perdana, dan produk lain.

Fitur yang termasuk:

- Tambah barang.
- Edit barang.
- Hapus barang.
- Stok barang.
- Harga beli dan harga jual.
- Scan barcode/kode barang.

### 4. Transaksi Penjualan

Transaksi penjualan digunakan untuk mencatat penjualan barang kepada pelanggan.

Fitur yang termasuk:

- Pilih produk.
- Hitung total belanja.
- Pembayaran tunai.
- Pembayaran QRIS sandbox Midtrans untuk simulasi.
- Cetak struk penjualan.
- Riwayat transaksi penjualan.

### 5. Laporan Penjualan

Laporan penjualan digunakan untuk melihat dan mencetak hasil transaksi kasir.

Fitur yang termasuk:

- Filter tanggal.
- Export PDF/print.
- Export Excel.
- Reset laporan.
- Detail transaksi.
- Pembatalan transaksi.
- Retur barang.

### 6. Pendataan Layanan BRILink

Modul BRILink pada website ini hanya digunakan untuk pendataan transaksi layanan, bukan untuk menjalankan transaksi bank secara langsung.

Layanan yang dicatat:

- Transfer.
- Tarik Tunai.
- Setor Tunai.
- Pembayaran Tagihan.
- Pulsa & Paket Data.
- Top Up / Cair E-Wallet.
- Riwayat BRILink.

Biaya admin dihitung berdasarkan aturan yang diatur di menu Biaya Admin BRILink.

### 7. Biaya Admin BRILink

Biaya admin BRILink digunakan untuk mengatur tarif pencatatan layanan BRILink berdasarkan jenis layanan dan range nominal transaksi.

Fitur yang termasuk:

- Mengatur biaya admin berdasarkan jenis layanan dan range nominal.
- Mengatur range nominal minimum dan maksimum.
- Mengatur biaya admin untuk setiap range.
- Menghitung total bayar otomatis dengan rumus:

```text
total_bayar = nominal_transaksi + biaya_admin
```

Untuk layanan berikut, biaya admin dibedakan berdasarkan Nasabah Internal dan Nasabah Eksternal:

- Transfer.
- Tarik Tunai.
- Setor Tunai.
- Pembayaran Tagihan.
- Pulsa & Paket Data.

Jenis kartu ditentukan otomatis oleh sistem:

- Nasabah Internal = Kartu Nasabah.
- Nasabah Eksternal = Kartu Konter.

Untuk layanan **Top Up / Cair E-Wallet**, biaya admin memiliki aturan range nominal sendiri dan tidak menggunakan jenis nasabah maupun jenis kartu.

Biaya admin yang diatur pada website ini adalah biaya pencatatan internal Sultan Cell, bukan biaya resmi dari sistem BRILink atau BRI.

### 8. Backup Data

Backup data digunakan untuk menyimpan cadangan data website dalam bentuk file.

Fitur yang termasuk:

- Download backup.
- Restore backup.

### 9. Riwayat Aktivitas

Riwayat aktivitas digunakan untuk mencatat aktivitas penting yang dilakukan admin/kasir di website.

Contoh aktivitas:

- Backup data.
- Restore data.
- Transaksi.
- Pengaturan biaya admin.
- Login atau reset password.

## Scope Yang Tidak Termasuk Dalam Website

Website ini tidak menjangkau fitur berikut:

### 1. Transaksi Bank Secara Langsung

Website tidak melakukan transfer uang secara langsung ke bank atau rekening tujuan.

Data transfer, tarik tunai, dan setor tunai hanya dicatat sebagai pendataan layanan.

### 2. Integrasi Resmi BRILink/BRI

Website tidak terhubung langsung ke sistem resmi BRILink atau BRI.

Tidak ada fitur:

- Cek saldo rekening BRI secara langsung.
- Transfer bank otomatis.
- Tarik tunai otomatis.
- Setor tunai otomatis.
- Validasi rekening melalui sistem BRI.

### 3. Pulsa dan Paket Data Otomatis

Website tidak langsung mengirim pulsa atau paket data ke nomor pelanggan.

Jika ingin otomatis, dibutuhkan API pihak ketiga atau distributor pulsa.

Pada website ini, pulsa dan paket data hanya dicatat sebagai pendataan transaksi.

### 4. E-Wallet Otomatis

Website tidak melakukan top up atau pencairan e-wallet secara otomatis.

Jika ingin otomatis, dibutuhkan API pihak ketiga.

Pada website ini, e-wallet hanya dicatat sebagai pendataan layanan.

### 5. Portal Pelanggan

Pelanggan tidak memiliki akun dan tidak login ke website.

Semua input dilakukan oleh admin/kasir.

### 6. Multi Role Pengguna

Website tidak membedakan banyak role seperti owner, kasir, admin gudang, atau supervisor.

Aktor sistem hanya admin yang merangkap sebagai kasir.

### 7. Akuntansi Lengkap

Website tidak dibuat sebagai sistem akuntansi penuh.

Fitur seperti neraca, jurnal umum, buku besar, hutang piutang lengkap, dan laporan pajak tidak termasuk dalam scope.

### 8. KYC atau Verifikasi Identitas Resmi

Website tidak melakukan verifikasi KTP, validasi rekening resmi, atau pengecekan identitas pelanggan ke lembaga keuangan.

### 9. Midtrans Production

QRIS Midtrans yang digunakan pada pengembangan ini diarahkan untuk sandbox/simulasi.

Penggunaan production membutuhkan akun merchant aktif, verifikasi data, biaya transaksi, dan konfigurasi resmi dari Midtrans.

## Batasan Penjelasan Untuk Laporan KP

Website ini dapat dijelaskan sebagai:

> Sistem operasional internal Sultan Cell yang digunakan oleh admin yang merangkap sebagai kasir untuk mengelola kasir penjualan, stok barang, pendataan layanan BRILink, laporan transaksi, backup data, dan riwayat aktivitas.

Penjelasan untuk layanan BRILink:

> Modul layanan BRILink pada website ini bersifat pendataan, bukan integrasi langsung dengan sistem perbankan atau sistem resmi BRILink.

Penjelasan untuk biaya admin BRILink:

> Biaya Admin BRILink pada website ini adalah pengaturan tarif pencatatan layanan internal Sultan Cell, bukan biaya yang diambil otomatis dari sistem resmi BRILink atau BRI.

## Kesimpulan Scope

Website ini berfokus pada pencatatan dan pengelolaan operasional internal.

Website tidak dibuat untuk menggantikan aplikasi resmi BRILink, aplikasi bank, sistem pembayaran resmi, atau sistem akuntansi lengkap.
