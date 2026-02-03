import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthys_app/presentation/screens/home/home_screen.dart';

void main() {
  // Inicialitzar el ServiceLocator amb la configuració
  /*
  
  No cal, però es pot provar...
  
  ServiceLocator.(
    api: HealthysApi(
      baseUrl: "https://healthys-backend-vv2dvdf-joamuran.globeapp.dev",
    ),
  );*/

  // ProviderScope para poder usar Riverpod
  runApp(const ProviderScope(child: HealthysApp()));
}

class HealthysApp extends StatelessWidget {
  const HealthysApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Healthys App",
      home: HomeScreen(),
    );
  }
}
