import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthys_app/presentation/providers/carret_notifier.dart';
import 'package:healthys_app/presentation/screens/carret/carret_screen.dart';

class CarretWidget extends ConsumerWidget {
  const CarretWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchar los cambios del carrito
    final carret = ref.watch(carretProvider);
    final quantitatTotal = carret.quantitatTotal;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // Navegar a la pantalla del carrito
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CarretScreen()),
          );
        },
        child: Chip(
          // Mostrar icono y cantidad total en el Chip
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.shopping_cart, size: 18),
              const SizedBox(width: 6),
              Text('$quantitatTotal'),
            ],
          ),
        ),
      ),
    );
  }
}
