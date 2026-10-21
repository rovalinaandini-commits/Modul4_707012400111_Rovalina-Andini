import 'package:flutter_bloc/flutter_bloc.dart';

class Pesan {
  const Pesan({
    required this.teks,
    required this.dariWarga,
    required this.waktu,
  });

  final String teks;
  final bool dariWarga;
  final DateTime waktu;
}

class PesanCubit extends Cubit<List<Pesan>> {
  PesanCubit()
      : super([
          Pesan(
            teks: 'Selamat datang di layanan Tanya Petugas. Ada yang bisa kami bantu?',
            dariWarga: false,
            waktu: DateTime.now(),
          ),
        ]);

  void kirim(String teks, {bool dariWarga = true}) {
    final isi = teks.trim();
    if (isi.isEmpty) return;

    emit([
      ...state,
      Pesan(
        teks: isi,
        dariWarga: dariWarga,
        waktu: DateTime.now(),
      ),
    ]);
  }
}
