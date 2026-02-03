// Widget privat per mostrar el comptador de productes
// Li proporcionem la quantitat inicial, el pereu unitari,
// la funció de format, i dos funcions de callback (de tipus VoidCallback),
// per a afegir o eliminar productes.

import 'package:flutter/material.dart';

class QuantityBar extends StatelessWidget {
  final int quantity;
  final double unitPrice;
  final String Function(double) formatPrice;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const QuantityBar({
    super.key,
    required this.quantity,
    required this.unitPrice,
    required this.formatPrice,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final total = unitPrice * quantity;

    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          IconButton.filledTonal(
            onPressed: onMinus,
            icon: const Icon(Icons.remove),
          ),
          const SizedBox(width: 8),
          Text(
            "$quantity",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(width: 8),
          IconButton.filledTonal(
            onPressed: onPlus,
            icon: const Icon(Icons.add),
          ),
          const Spacer(),
          Text(
            "Total: ${formatPrice(total)}",
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
