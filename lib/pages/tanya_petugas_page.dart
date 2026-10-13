import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pesan_model.dart';

class TanyaPetugasPage extends StatefulWidget {
  const TanyaPetugasPage({super.key});
  @override
  State<TanyaPetugasPage> createState() => _TanyaPetugasPageState();
}
class _TanyaPetugasPageState extends State<TanyaPetugasPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  @override
  void dispose() { _controller.dispose(); _scrollController.dispose(); super.dispose(); }
  void _kirim() {
    final teks = _controller.text;
    if (teks.trim().isEmpty) return;
    context.read<PesanModel>().kirim(teks);
    _controller.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    });
  }
  @override
  Widget build(BuildContext context) {
    final pesan = context.watch<PesanModel>().daftarPesan;
    return Scaffold(
      appBar: AppBar(title: const Text('Tanya Petugas')),
      body: Column(children: [
        Container(width: double.infinity, padding: const EdgeInsets.all(12), color: Colors.blue.shade50, child: const Row(children: [Icon(Icons.support_agent, color: Colors.blue), SizedBox(width: 8), Expanded(child: Text('Petugas layanan • Balasan simulasi lokal', style: TextStyle(fontWeight: FontWeight.w600)))])),
        Expanded(child: ListView.builder(
          controller: _scrollController, padding: const EdgeInsets.all(16), itemCount: pesan.length,
          itemBuilder: (context, i) {
            final p = pesan[i];
            return Align(alignment: p.dariWarga ? Alignment.centerRight : Alignment.centerLeft, child: Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .78),
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(color: p.dariWarga ? Colors.blue : Colors.white, borderRadius: BorderRadius.circular(16), border: p.dariWarga ? null : Border.all(color: Colors.black12)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.dariWarga ? 'Anda' : 'Petugas', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: p.dariWarga ? Colors.white70 : Colors.blue)),
                const SizedBox(height: 4), Text(p.teks, style: TextStyle(color: p.dariWarga ? Colors.white : Colors.black87)),
              ]),
            ));
          },
        )),
        SafeArea(top: false, child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
          Expanded(child: TextField(controller: _controller, textInputAction: TextInputAction.send, onSubmitted: (_) => _kirim(), decoration: const InputDecoration(hintText: 'Tulis pesan...', border: OutlineInputBorder(), isDense: true))),
          const SizedBox(width: 8), IconButton.filled(onPressed: _kirim, icon: const Icon(Icons.send)),
        ]))),
      ]),
    );
  }
}
