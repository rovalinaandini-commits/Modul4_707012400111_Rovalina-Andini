import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorit_cubit.dart';
import '../navigation/app_routes.dart';
import '../cubit/pengajuan_cubit.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});
  @override
  Widget build(BuildContext context) {
    final pengajuan = context.watch<PengajuanCubit>().state;
    return Scaffold(
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Warga', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('Kelola aktivitas dan layanan Anda sebagai warga.'),
        const SizedBox(height: 20),
        Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(18)), child: const Row(children: [
          CircleAvatar(radius: 30, backgroundColor: Colors.white, child: Icon(Icons.person, color: Colors.blue, size: 34)),
          SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Rovalina Andini', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Pantau pengajuan dan akses layanan kota.', style: TextStyle(color: Colors.white70)),
          ])),
        ])),
        const SizedBox(height: 22),
Row(
  children: [
    Expanded(
      child: _stat(
        'Total Pengajuan',
        '${context.watch<PengajuanCubit>().totalPengajuan}',
        Icons.assignment_outlined,
      ),
    ),
    const SizedBox(width: 12),
    Expanded(
      child: _stat(
        'Layanan Favorit',
        '${context.watch<FavoritCubit>().state.length}',
        Icons.star_outline,
      ),
    ),
  ],
),
        const SizedBox(height: 24),
        const Text(
  'Layanan Favorit',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 12),

BlocBuilder<FavoritCubit, Set<String>>(
  builder: (context, daftarFavorit) {
    if (daftarFavorit.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text('Belum ada layanan favorit.'),
        ),
      );
    }

    return Column(
      children: daftarFavorit.map((namaLayanan) {
        return Card(
          child: ListTile(
            leading: const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            title: Text(namaLayanan),
            trailing: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
        );
      }).toList(),
    );
  },
),

const SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Pengajuan Terbaru', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.riwayatLaporan), child: const Text('Lihat semua')),
        ]),
 if (pengajuan.isEmpty)
  const Card(
    child: Padding(
      padding: EdgeInsets.all(22),
      child: Center(
        child: Text('Belum ada pengajuan.'),
      ),
    ),
  )
else
  ...pengajuan.take(3).map(
    (namaLayanan) => Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.assignment),
        ),
        title: Text(namaLayanan),
        subtitle: const Text('Pengajuan layanan'),
        trailing: const Icon(
          Icons.hourglass_top,
          color: Colors.orange,
        ),
      ),
    ),
  ),
        const SizedBox(height: 20),
        _menu(context, Icons.chat_outlined, 'Tanya Petugas', AppRoutes.tanyaPetugas),
        _menu(context, Icons.map_outlined, 'Lokasi Kantor', AppRoutes.lokasiKantor),
        _menu(context, Icons.bar_chart, 'Statistik Layanan', AppRoutes.statistikLayanan),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.detailLayanan),
        icon: const Icon(Icons.add), label: const Text('Pengajuan Baru'),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, color: Colors.blue, size: 28), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)), Text(title, style: const TextStyle(color: Colors.grey)),
  ])));
  Widget _menu(BuildContext context, IconData icon, String title, String route) => Card(child: ListTile(leading: Icon(icon, color: Colors.blue), title: Text(title), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.pushNamed(context, route)));
}
