import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pengajuan_model.dart';
import '../pages/beranda_page.dart';
import '../pages/layanan_page.dart';
import '../pages/warga_page.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key, this.indeksAwal = 0});
  final int indeksAwal;
  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  late int _index;
  final _halaman = const [BerandaPage(), LayananPage(), WargaPage()];
  @override
  void initState() { super.initState(); _index = widget.indeksAwal.clamp(0, 2); }

  void _buka(String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 700;
    final total = context.select<PengajuanModel, int>((m) => m.totalPengajuan);
    return Scaffold(
      appBar: AppBar(title: const Text('Nusantara Cerdas Mobile', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      drawer: NavigationDrawer(
        children: [
          const Padding(padding: EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(Icons.location_city, size: 42, color: Colors.blue),
            SizedBox(height: 8), Text('Nusantara Cerdas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Layanan digital warga'),
          ])),
          const Divider(),
          _dest(Icons.home_outlined, 'Beranda', () { Navigator.pop(context); setState(() => _index = 0); }),
          _dest(Icons.miscellaneous_services_outlined, 'Layanan', () { Navigator.pop(context); setState(() => _index = 1); }),
          _dest(Icons.person_outline, 'Warga ($total)', () { Navigator.pop(context); setState(() => _index = 2); }),
          _dest(Icons.chat_outlined, 'Tanya Petugas', () => _buka(AppRoutes.tanyaPetugas)),
          _dest(Icons.map_outlined, 'Lokasi Kantor', () => _buka(AppRoutes.lokasiKantor)),
          _dest(Icons.bar_chart, 'Statistik Layanan', () => _buka(AppRoutes.statistikLayanan)),
          _dest(Icons.history, 'Riwayat Pengajuan', () => _buka(AppRoutes.riwayatLaporan)),
          _dest(Icons.settings_outlined, 'Pengaturan Kota', () => _buka(AppRoutes.pengaturanKota)),
          _dest(Icons.info_outline, 'Tentang Aplikasi', () => _buka(AppRoutes.tentangAplikasi)),
        ],
      ),
      body: Row(children: [
        if (wide) NavigationRail(selectedIndex: _index, onDestinationSelected: (i) => setState(() => _index = i), labelType: NavigationRailLabelType.all, destinations: const [
          NavigationRailDestination(icon: Icon(Icons.home_outlined), label: Text('Beranda')),
          NavigationRailDestination(icon: Icon(Icons.miscellaneous_services_outlined), label: Text('Layanan')),
          NavigationRailDestination(icon: Icon(Icons.person_outline), label: Text('Warga')),
        ]),
        Expanded(child: IndexedStack(index: _index, children: _halaman)),
      ]),
      bottomNavigationBar: wide ? null : NavigationBar(selectedIndex: _index, onDestinationSelected: (i) => setState(() => _index = i), destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Beranda'),
        NavigationDestination(icon: Icon(Icons.miscellaneous_services_outlined), label: 'Layanan'),
        NavigationDestination(icon: Icon(Icons.person_outline), label: 'Warga'),
      ]),
    );
  }

  Widget _dest(IconData icon, String label, VoidCallback tap) => ListTile(leading: Icon(icon), title: Text(label), onTap: tap);
}
