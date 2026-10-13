import 'package:flutter/foundation.dart';

class DataPengajuan {
  DataPengajuan({
    required this.id,
    required this.nama,
    required this.email,
    required this.bidang,
    required this.sesi,
    required this.tanggal,
    this.selesai = false,
  });
  final String id;
  final String nama;
  final String email;
  final String bidang;
  final String sesi;
  final DateTime tanggal;
  bool selesai;
}

class PengajuanModel extends ChangeNotifier {
  final List<DataPengajuan> _daftarPengajuan = [];
  List<DataPengajuan> get daftarPengajuan => List.unmodifiable(_daftarPengajuan);
  int get totalPengajuan => _daftarPengajuan.length;

  void tambahPengajuan({
    required String nama,
    required String email,
    required String bidang,
    required String sesi,
  }) {
    _daftarPengajuan.insert(0, DataPengajuan(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      nama: nama,
      email: email,
      bidang: bidang,
      sesi: sesi,
      tanggal: DateTime.now(),
    ));
    notifyListeners();
  }

  void tandaiSelesai(String id) {
    final index = _daftarPengajuan.indexWhere((e) => e.id == id);
    if (index < 0) return;
    _daftarPengajuan[index].selesai = true;
    notifyListeners();
  }

  Map<String, int> get statistikBidang {
    final hasil = <String, int>{
      'Perizinan': 0, 'Kesehatan': 0, 'Transportasi': 0, 'Administrasi': 0,
    };
    for (final p in _daftarPengajuan) {
      final bidang = p.bidang.toLowerCase();
      if (bidang.contains('izin') || bidang.contains('bangunan')) {
        hasil['Perizinan'] = hasil['Perizinan']! + 1;
      } else if (bidang.contains('puskesmas') || bidang.contains('kesehatan') || bidang.contains('vaksin') || bidang.contains('ambulans')) {
        hasil['Kesehatan'] = hasil['Kesehatan']! + 1;
      } else if (bidang.contains('transportasi') || bidang.contains('rute')) {
        hasil['Transportasi'] = hasil['Transportasi']! + 1;
      } else {
        hasil['Administrasi'] = hasil['Administrasi']! + 1;
      }
    }
    return hasil;
  }
}
