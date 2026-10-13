import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pengajuan_model.dart';

class DetailLayananPage extends StatefulWidget {
  final Map<String, String> layanan;
  const DetailLayananPage({super.key, required this.layanan});
  @override
  State<DetailLayananPage> createState() => _DetailLayananPageState();
}

class _DetailLayananPageState extends State<DetailLayananPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  bool _setuju = false;
  String? _sesi = 'Pagi';
  bool _sedangMengirim = false;

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _kirim() async {
    if (!_formKey.currentState!.validate() || !_setuju || _sesi == null) return;
    setState(() => _sedangMengirim = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    context.read<PengajuanModel>().tambahPengajuan(
      nama: _namaController.text.trim(),
      email: _emailController.text.trim(),
      bidang: widget.layanan['nama'] ?? 'Administrasi',
      sesi: _sesi!,
    );
    setState(() => _sedangMengirim = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pengajuan berhasil disimpan.')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final namaLayanan = widget.layanan['nama'] ?? 'Pengajuan Layanan';
    final formValid = _namaController.text.trim().isNotEmpty &&
        _emailController.text.trim().contains('@') && _setuju && _sesi != null;
    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Pengajuan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: double.infinity, padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Icon(Icons.assignment_outlined, size: 36, color: Colors.blue),
                const SizedBox(height: 8),
                Text(namaLayanan, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(widget.layanan['dinas'] ?? 'Dinas layanan warga'),
              ]),
            ),
            const SizedBox(height: 24),
            const Text('Data Pemohon', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextFormField(
              controller: _namaController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Nama lengkap', prefixIcon: Icon(Icons.person_outline), border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Nama lengkap wajib diisi.' : null,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined), border: OutlineInputBorder()),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email wajib diisi.';
                if (!v.contains('@')) return 'Email harus mengandung karakter @.';
                return null;
              },
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              value: _setuju,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Saya menyetujui penggunaan data pribadi untuk proses layanan.'),
              onChanged: (v) => setState(() => _setuju = v ?? false),
            ),
            const SizedBox(height: 8),
            const Text('Pilih sesi kunjungan', style: TextStyle(fontWeight: FontWeight.bold)),
            ...['Pagi', 'Siang', 'Sore'].map((s) => RadioListTile<String>(
              contentPadding: EdgeInsets.zero, title: Text(s), value: s, groupValue: _sesi,
              onChanged: (v) => setState(() => _sesi = v),
            )),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, height: 52, child: ElevatedButton.icon(
              onPressed: (!formValid || _sedangMengirim) ? null : _kirim,
              icon: _sedangMengirim ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.send),
              label: Text(_sedangMengirim ? 'Sedang mengirim...' : 'Kirim Pengajuan'),
            )),
            const SizedBox(height: 8),
            const Text('Pastikan nama, email, persetujuan, dan sesi kunjungan sudah diisi.', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ]),
        ),
      ),
    );
  }
}
