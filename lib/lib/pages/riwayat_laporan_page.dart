
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../navigation/app_routes.dart';

class RiwayatLaporanPage extends StatelessWidget {
  const RiwayatLaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pengajuan'),
      ),

      body: BlocBuilder<PengajuanCubit, List<String>>(
        builder: (context, data) {
          if (data.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Belum ada riwayat pengajuan. '
                  'Tekan tombol + untuk membuat pengajuan baru.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: data.length,
            itemBuilder: (context, i) {
              final namaLayanan = data[i];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.shade50,
                    child: const Icon(
                      Icons.assignment_outlined,
                      color: Colors.orange,
                    ),
                  ),

                  title: Text(
                    namaLayanan,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    'Pengajuan ke-${i + 1}\n'
                    'Status: Menunggu tindak lanjut',
                  ),

                  isThreeLine: true,

                  trailing: const Icon(
                    Icons.pending_actions,
                    color: Colors.orange,
                  ),

                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog(
                          title: const Text('Detail Pengajuan'),
                          content: Text(
                            'Layanan: $namaLayanan\n'
                            'Nomor pengajuan: ${i + 1}\n'
                            'Status: Menunggu tindak lanjut',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext);
                              },
                              child: const Text('Tutup'),
                            ),
                          ],
                        );
                      },
                    );
                  },

                  onLongPress: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Fitur penandaan selesai belum tersedia.',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.detailLayanan,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
