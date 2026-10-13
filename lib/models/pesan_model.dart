import 'package:flutter/foundation.dart';

class Pesan {
  Pesan({required this.teks, required this.dariWarga, required this.waktu});
  final String teks;
  final bool dariWarga;
  final DateTime waktu;
}

class PesanModel extends ChangeNotifier {
  final List<Pesan> _pesan = [
    Pesan(teks: 'Selamat datang di layanan Tanya Petugas. Ada yang bisa kami bantu?', dariWarga: false, waktu: DateTime.now()),
  ];
  List<Pesan> get daftarPesan => List.unmodifiable(_pesan);
  void kirim(String teks, {bool dariWarga = true}) {
    if (teks.trim().isEmpty) return;
    _pesan.add(Pesan(teks: teks.trim(), dariWarga: dariWarga, waktu: DateTime.now()));
    notifyListeners();
  }
}
