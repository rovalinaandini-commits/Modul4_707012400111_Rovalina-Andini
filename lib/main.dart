import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/favorit_model.dart';
import 'models/pengajuan_model.dart';
import 'models/pesan_model.dart';
import 'navigation/app_routes.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FavoritModel()),
      ChangeNotifierProvider(create: (_) => PengajuanModel()),
      ChangeNotifierProvider(create: (_) => PesanModel()),
    ],
    child: const NusantaraCerdasApp(),
  ));
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Nusantara Cerdas Mobile',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1769AA)),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF7F9FC),
    ),
    initialRoute: AppRoutes.beranda,
    routes: AppRoutes.daftarRoute(),
    onGenerateRoute: AppRoutes.bentukRoute,
    onUnknownRoute: AppRoutes.routeTidakDikenal,
  );
}
