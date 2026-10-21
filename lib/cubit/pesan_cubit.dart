
import 'package:flutter_bloc/flutter_bloc.dart';

class Pesan {
  final String isi;
  final bool dariPengguna;
  final DateTime waktu;

  Pesan({
    required this.isi,
    required this.dariPengguna,
    DateTime? waktu,
  }) : waktu = waktu ?? DateTime.now();
}

class PesanCubit extends Cubit<List<Pesan>> {
  PesanCubit() : super(<Pesan>[]);

  void kirimPesan(String isi) {
    final teks = isi.trim();

    if (teks.isEmpty) return;

    final pesanBaru = Pesan(
      isi: teks,
      dariPengguna: true,
    );

    emit([...state, pesanBaru]);
  }

  void tambahBalasan(String isi) {
    final teks = isi.trim();

    if (teks.isEmpty) return;

    final balasan = Pesan(
      isi: teks,
      dariPengguna: false,
    );

    emit([...state, balasan]);
  }

  void hapusSemuaPesan() {
    emit(<Pesan>[]);
  }
}
