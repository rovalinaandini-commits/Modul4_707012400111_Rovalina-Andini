import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class RiwayatLaporanPage extends StatelessWidget {
  const RiwayatLaporanPage({super.key});
  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();
    final data = model.daftarPengajuan;
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Pengajuan')),
      body: data.isEmpty
        ? const Center(child: Padding(padding: EdgeInsets.all(24), child: Text('Belum ada riwayat pengajuan. Tekan tombol + untuk membuat pengajuan baru.', textAlign: TextAlign.center)))
        : ListView.builder(
          padding: const EdgeInsets.all(16), itemCount: data.length,
          itemBuilder: (context, i) {
            final p = data[i];
            return GestureDetector(
              onTap: () => showDialog(context: context, builder: (_) => AlertDialog(
                title: Text(p.bidang), content: Text('Nama: ${p.nama}\nEmail: ${p.email}\nSesi: ${p.sesi}\nStatus: ${p.selesai ? "Selesai ditindaklanjuti" : "Menunggu tindak lanjut"}'),
                actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup'))],
              )),
              onLongPress: () {
                model.tandaiSelesai(p.id);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pengajuan ditandai selesai ditindaklanjuti.')));
              },
              child: Card(margin: const EdgeInsets.only(bottom: 12), child: ListTile(
                leading: CircleAvatar(backgroundColor: p.selesai ? Colors.green.shade50 : Colors.orange.shade50, child: Icon(p.selesai ? Icons.check_circle : Icons.assignment_outlined, color: p.selesai ? Colors.green : Colors.orange)),
                title: Text(p.bidang, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${p.nama} • ${p.email}\nSesi ${p.sesi} • ${p.tanggal.day}/${p.tanggal.month}/${p.tanggal.year}\nTekan lama untuk tandai selesai'),
                isThreeLine: true,
                trailing: Icon(p.selesai ? Icons.verified : Icons.pending_actions, color: p.selesai ? Colors.green : Colors.orange),
              )),
            );
          },
        ),
      floatingActionButton: FloatingActionButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.detailLayanan), child: const Icon(Icons.add)),
    );
  }
}
