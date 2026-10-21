import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LokasiKantorPage extends StatelessWidget {
  const LokasiKantorPage({super.key});
  static const _pusat = LatLng(-6.5950, 106.8166);
  static final Set<Marker> _markers = {
    const Marker(markerId: MarkerId('diskominfo'), position: LatLng(-6.5950, 106.8166), infoWindow: InfoWindow(title: 'Kantor Diskominfo', snippet: 'Pusat layanan digital warga')),
    const Marker(markerId: MarkerId('dpmptsp'), position: LatLng(-6.5910, 106.7970), infoWindow: InfoWindow(title: 'Kantor Pelayanan Terpadu', snippet: 'Layanan perizinan')),
    const Marker(markerId: MarkerId('dinkes'), position: LatLng(-6.5800, 106.8060), infoWindow: InfoWindow(title: 'Kantor Dinas Kesehatan', snippet: 'Layanan kesehatan masyarakat')),
  };
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Lokasi Kantor')),
    body: Column(children: [
      const Padding(padding: EdgeInsets.all(16), child: Align(alignment: Alignment.centerLeft, child: Text('Peta Kantor Layanan', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)))),
      Expanded(child: GoogleMap(
        initialCameraPosition: const CameraPosition(target: _pusat, zoom: 13),
        markers: _markers,
        myLocationButtonEnabled: false,
        mapToolbarEnabled: true,
      )),
      const Padding(padding: EdgeInsets.all(12), child: Text('Lokasi contoh di wilayah Kota Bogor. Ketuk penanda untuk melihat nama kantor.', style: TextStyle(color: Colors.grey))),
    ]),
  );
}
