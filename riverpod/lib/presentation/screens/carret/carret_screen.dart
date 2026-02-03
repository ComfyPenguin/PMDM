import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthys_app/domain/entities/itemCarret.dart';
import 'package:healthys_app/presentation/providers/carret_notifier.dart';

class CarretScreen extends ConsumerWidget {
  const CarretScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carret = ref.watch(carretProvider);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
        actions: [
          // Botón para vaciar el carrito
          if (!carret.esBuit)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Vaciar carrito',
              onPressed: () {
                // Mostrar diálogo de confirmación
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Vaciar carrito'),
                    content: const Text(
                      '¿Estás seguro de que quieres vaciar el carrito?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      FilledButton(
                        onPressed: () {
                          ref.read(carretProvider.notifier).buidaCarret();
                          Navigator.pop(context);
                        },
                        child: const Text('Vaciar'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: carret.esBuit
          ? _buildEmptyCart(context, cs)
          : Column(
              children: [
                // Lista de productos
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: carret.items.length,
                    itemBuilder: (context, index) {
                      final item = carret.items[index];
                      return _buildCartItem(context, ref, item, theme, cs);
                    },
                  ),
                ),
                // Resumen del precio total
                _buildPriceTotal(context, ref, carret, theme, cs),
              ],
            ),
    );
  }

  /// Widget para mostrar cuando el carrito está vacío
  Widget _buildEmptyCart(BuildContext context, ColorScheme cs) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 120,
            color: cs.onSurfaceVariant.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 24),
          Text(
            'El carrito está vacío',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 12),
          Text(
            'Añade productos para empezar tu pedido',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: cs.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget para mostrar cada item del carrito
  Widget _buildCartItem(
    BuildContext context,
    WidgetRef ref,
    ItemCarret item,
    ThemeData theme,
    ColorScheme cs,
  ) {
    final producte = item.producte;
    final quantitat = item.quantitat;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 80,
                height: 80,
                color: cs.surfaceContainerHighest,
                child: producte.img != null
                    ? Image.network(
                        producte.img!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) {
                          return Icon(
                            Icons.fastfood,
                            size: 40,
                            color: cs.onSurfaceVariant,
                          );
                        },
                      )
                    : Icon(
                        Icons.fastfood,
                        size: 40,
                        color: cs.onSurfaceVariant,
                      ),
              ),
            ),
            const SizedBox(width: 12),
            // Información del producto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    producte.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${producte.price.toStringAsFixed(2)} €',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Controles de cantidad
                  Row(
                    children: [
                      // Botón decrementar
                      IconButton.outlined(
                        onPressed: () {
                          ref
                              .read(carretProvider.notifier)
                              .eliminaProducte(producte, 1);
                        },
                        icon: const Icon(Icons.remove, size: 18),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Cantidad
                      SizedBox(
                        width: 40,
                        child: Text(
                          '$quantitat',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Botón incrementar
                      IconButton.outlined(
                        onPressed: () {
                          ref
                              .read(carretProvider.notifier)
                              .afigProducte(producte, 1);
                        },
                        icon: const Icon(Icons.add, size: 18),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                      ),
                      const Spacer(),
                      // Precio total del item
                      Text(
                        '${item.preuTotal.toStringAsFixed(2)} €',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: cs.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget para mostrar el precio total
  Widget _buildPriceTotal(
    BuildContext context,
    WidgetRef ref,
    dynamic carret,
    ThemeData theme,
    ColorScheme cs,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Resumen
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total (${carret.quantitatTotal} artículos)',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                Text(
                  '${carret.preuTotal.toStringAsFixed(2)} €',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: cs.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Botón para finalizar pedido
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton.icon(
                onPressed: () {
                  // Aquí iría la lógica para finalizar el pedido
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Funcionalidad de pedido por implementar'),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_bag),
                label: const Text('Finalizar pedido'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
