import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/pengajuan_model.dart';

class StatistikLayananPage extends StatelessWidget {
  const StatistikLayananPage({super.key});
  @override
  Widget build(BuildContext context) {
    final statistik = context.watch<PengajuanModel>().statistikBidang;
    final entries = statistik.entries.toList();
    final total = statistik.values.fold<int>(0, (a, b) => a + b);
    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Layanan')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Ringkasan Pengajuan', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6), const Text('Jumlah pengajuan berdasarkan bidang layanan.'),
        const SizedBox(height: 18),
        Card(child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [
          const Icon(Icons.assignment_turned_in, color: Colors.blue, size: 36), const SizedBox(width: 14),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('$total', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)), const Text('Total pengajuan')]),
        ]))),
        const SizedBox(height: 20),
        SizedBox(height: 300, child: Card(child: Padding(padding: const EdgeInsets.fromLTRB(12, 20, 20, 12), child: BarChart(BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: (entries.map((e) => e.value).fold<int>(0, (a, b) => a > b ? a : b) + 1).toDouble(),
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 28)),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 42, getTitlesWidget: (value, meta) {
              final i = value.toInt();
              if (i < 0 || i >= entries.length) return const SizedBox.shrink();
              return Padding(padding: const EdgeInsets.only(top: 8), child: Text(entries[i].key, style: const TextStyle(fontSize: 10)));
            })),
          ),
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(entries.length, (i) => BarChartGroupData(x: i, barRods: [BarChartRodData(toY: entries[i].value.toDouble(), width: 28, borderRadius: BorderRadius.circular(5), color: Colors.blue)])),
        ))))),
        const SizedBox(height: 12),
        ...entries.map((e) => ListTile(leading: const Icon(Icons.bar_chart, color: Colors.blue), title: Text(e.key), trailing: Text('${e.value} pengajuan', style: const TextStyle(fontWeight: FontWeight.bold)))),
      ]),
    );
  }
}
