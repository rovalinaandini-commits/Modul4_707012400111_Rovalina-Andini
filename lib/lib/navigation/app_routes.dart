import 'package:flutter/material.dart';
import '../pages/detail_layanan_page.dart';
import '../pages/tanya_petugas_page.dart';
import '../pages/lokasi_kantor_page.dart';
import '../pages/statistik_layanan_page.dart';
import '../pages/warga_page.dart';
import '../pages/riwayat_laporan_page.dart';
import '../pages/pengaturan_kota_page.dart';
import '../pages/tentang_aplikasi_page.dart';
import '../pages/route_tidak_dikenal_page.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String layanan = '/layanan';
  static const String detailLayanan = '/detail-layanan';
  static const String warga = '/warga';
  static const String riwayatLaporan = '/riwayat-laporan';
  static const String tanyaPetugas = '/tanya-petugas';
  static const String lokasiKantor = '/lokasi-kantor';
  static const String statistikLayanan = '/statistik-layanan';
  static const String pengaturanKota = '/pengaturan-kota';
  static const String tentangAplikasi = '/tentang-aplikasi';

  static Map<String, WidgetBuilder> daftarRoute() => {
    beranda: (_) => const KerangkaNavigasi(),
    layanan: (_) => const KerangkaNavigasi(indeksAwal: 1),
    warga: (_) => const WargaPage(),
    riwayatLaporan: (_) => const RiwayatLaporanPage(),
    tanyaPetugas: (_) => const TanyaPetugasPage(),
    lokasiKantor: (_) => const LokasiKantorPage(),
    statistikLayanan: (_) => const StatistikLayananPage(),
    pengaturanKota: (_) => const PengaturanKotaPage(),
    tentangAplikasi: (_) => const TentangAplikasiPage(),
  };

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == detailLayanan) {
      final args = settings.arguments;
      final layanan = args is Map<String, String> ? args : <String, String>{
        'nama': 'Pengajuan Layanan Umum',
        'dinas': 'Dinas Komunikasi dan Informatika',
        'jam': '08.00 - 15.00',
        'keterangan': 'Formulir pengajuan layanan warga Nusantara Cerdas Mobile.',
      };
      return MaterialPageRoute(builder: (_) => DetailLayananPage(layanan: layanan));
    }
    return null;
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) =>
      MaterialPageRoute(builder: (_) => const RouteTidakDikenalPage());
}
