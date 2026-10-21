import 'package:flutter_bloc/flutter_bloc.dart';

class PengajuanCubit extends Cubit<List<String>> {
  PengajuanCubit() : super(<String>[]);

  int get totalPengajuan => state.length;

  void tambahPengajuan(String namaLayanan) {
    emit([...state, namaLayanan]);
  }

  void hapusPengajuan(String namaLayanan) {
    final pengajuanBaru = List<String>.from(state);
    pengajuanBaru.remove(namaLayanan);
    emit(pengajuanBaru);
  }

  void kosongkanPengajuan() {
    emit(<String>[]);
  }
}