# Nusantara Cerdas Mobile

Project Flutter lanjutan untuk tugas Modul 4.

## Menjalankan aplikasi
1. Pasang Flutter SDK dan Android Studio.
2. Jalankan `flutter pub get`.
3. Untuk Google Maps, aktifkan Maps SDK for Android di Google Cloud Console, buat API key, lalu ganti `YOUR_GOOGLE_MAPS_API_KEY` pada `android/app/src/main/AndroidManifest.xml`.
4. Jalankan `flutter run`.

## Fitur
- Form pengajuan dengan validasi nama/email, persetujuan data, sesi kunjungan dan indikator loading.
- Pengajuan tersimpan dalam `PengajuanModel` melalui Provider.
- Riwayat pengajuan: ketuk kartu untuk detail, tekan lama untuk menandai selesai.
- Chat lokal sederhana dengan `ListView.builder` dan `PesanModel`.
- Peta kantor dengan Google Maps dan tiga marker contoh di Kota Bogor.
- Statistik bidang layanan menggunakan `fl_chart`.
- Named routes terpusat di `lib/navigation/app_routes.dart`.

Catatan: data dan chat saat ini disimpan sementara dalam memori, belum menggunakan backend/database. Lokasi marker merupakan lokasi contoh untuk demonstrasi tugas dan perlu diverifikasi sebelum penggunaan nyata.
