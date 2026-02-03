import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthys_app/domain/entities/beguda.dart';
import 'package:healthys_app/domain/entities/producte.dart';
import 'package:healthys_app/presentation/providers/carret_notifier.dart';
import 'package:healthys_app/presentation/screens/productes/widgets/info_row.dart';
import 'package:healthys_app/presentation/screens/productes/widgets/quantity_bar.dart';
import 'package:healthys_app/presentation/screens/productes/widgets/round_icon_button.dart';
import 'package:healthys_app/presentation/widgets/llista_alergens.dart';

// Widget amb estat, ja que incorporarà la quantitat de productes afegits.

class ProducteDetall extends ConsumerStatefulWidget {
  final Producte producte;

  const ProducteDetall({super.key, required this.producte});

  @override
  ConsumerState<ProducteDetall> createState() => _ProducteDetallState();
}

class _ProducteDetallState extends ConsumerState<ProducteDetall> {
  // Ya no necesitamos estado local _quantitat
  // Se obtiene reactivamente del carretProvider

  // Funció per formatar el preu
  String _formatPrice(double price) {
    return "${price.toStringAsFixed(2)} €";
  }

  @override
  Widget build(BuildContext context) {
    final producte =
        widget.producte; // Agafem l'producte del widget associat a l'estat

    // Obtener la cantidad del producto desde el carrito
    final carret = ref.watch(carretProvider);
    final quantitat = carret.quantitatProducte(producte.name);

    final theme = Theme.of(context); // Agafem el tema del context
    final cs = theme.colorScheme; // Agafem l'esquema de color del tema

    // Fem ús de MediaQuery per agafar l'alçada de la pantalla, i ajustar
    // la grandària de la imatge al 42%
    final topImageHeight = MediaQuery.of(context).size.height * 0.42;

    // El contenidor principal serà un Stack, on apilarem diferents components
    return Stack(
      children: [
        // Imatge superior
        SizedBox(
          height: topImageHeight, // Alçada per a la imatge
          width: double.infinity, // Tot l'ample possible
          child: Image.network(
            // Carreguem la imatge de l'producte
            producte.img ?? "",
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) {
              // Si hi ha errors en la càrrega, mostrem una icona genèrica
              return Container(
                color: cs.surfaceContainerHighest,
                alignment: Alignment.center,
                child: Icon(
                  Icons.fastfood,
                  size: 64,
                  color: cs.onSurfaceVariant,
                ),
              );
            },
            // Widget mentre carreguem la imatge: Indicador de progrés circular
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: cs.surfaceContainerHighest,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            },
          ),
        ),

        // Gradient fosc a la part de dalt, per afegir un parell de botons
        // Fem un contenidor, la decoració del qual serà el gradient
        Container(
          height: topImageHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.55),
                Colors.transparent,
                Colors.black.withValues(alpha: 0.25),
              ],
            ),
          ),
        ),

        // Simulem l'AppBar amb un SafeArea
        // (contenidor que "evita" superposar-se a la interfície de l'usuari)
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            // Afegim dins d'aquest una fila amb dos IconButtons:
            // - Un per tornar enrere en la navegació
            // - Altre que ens servirà per afegir-lo a favorits
            child: Row(
              children: [
                RoundIconButton(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.of(context).maybePop(),
                ),
                const Spacer(),
                RoundIconButton(
                  icon: Icons.favorite_border,
                  onTap: () {
                    // Aci afegiriem la lògica per afegir el plat als favorits
                    // De moment podria ser un booleà a l'estat, i actualitzar
                    // la icona segons siga favorit o no (i alternar entre
                    // Icons.favorite_border i Icons.favorite)
                    // Ho farem més endavant
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("S'ha afegit als favorits..."),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        // Sheet inferior
        // Compte que aquest widget np l'haviem vist encara!

        // Aquest DraggableScrollableSheet ens mostra un contenidor que permet
        // fer scroll i arrossegar-lo per la pantalla.
        DraggableScrollableSheet(
          // Inicialment ocupa el 62% de l'espai disponible al contenidor pare
          initialChildSize: 0.62,
          // Com a mínim deixarem que ocupe el 55% del contenidor pare
          minChildSize: 0.55,
          // Com a màxim deixarem que ocupe el 92% del contenidor pare
          maxChildSize: 0.92,
          builder: (context, scrollController) {
            // Creem un contenidor amb les vores arrodonides i ombra
            return Container(
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    spreadRadius: 4,
                    color: Colors.black.withValues(alpha: 0.12),
                  ),
                ],
              ),

              // Contingut del contenidor en forma de columna
              child: Column(
                children: [
                  // Fem ús de diversos SizedBox per afegir espaiat entre
                  // els diferents elements de la columna
                  const SizedBox(height: 10),
                  // Aquest contenidor és el que fa de "tirador" del contenidor
                  Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: cs.outlineVariant.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Afegim altre contenidor que ocupe tot l'espai disponible
                  Expanded(
                    child: ListView(
                      // Afegim una llsita d'elements, amb scroll
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                      children: [
                        Text(
                          // Nom de l'producte. Observeu que partim dels
                          // estils definits al tema.
                          producte.name,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Descripció del plat (ingredients)
                        Text(
                          producte.description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Informació addicional (la mateixa que en les targetes)
                        Text(
                          producte.additionalInfo ?? "",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Widget amb la llista d'al·lèrgens (la que teniem
                        // per a la pizzeria)
                        LlistaAlergens(alergens: producte.allergens),
                        const SizedBox(height: 18),

                        // Fila amb el preu i la quantitat que tenim a la comanda
                        Row(
                          children: [
                            //Espaiador per espentar el preu a la dreta
                            const Spacer(),
                            // Preu formatat
                            Text(
                              _formatPrice(producte.price),
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),
                        // Línia divisòria
                        Divider(
                          color: cs.outlineVariant.withValues(alpha: 0.6),
                        ),
                        const SizedBox(height: 14),

                        //  Zona amb informació addicional
                        Text(
                          "Informació",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // InfoRow és una classe privada pe formatar aquesta informació
                        // Li proporcionem una etiqueta i el valor
                        if (producte.tipus != null)
                          InfoRow(
                            label: "Categoría",
                            value: "${producte.tipus}",
                          ),
                        InfoRow(
                          label: "Tipues de dietes",
                          // Aci tenim unexemple de programació declarativa:
                          // Especifiquem què volem que es mostre en funció de
                          // l'estat actual de l'aplicació.
                          value: producte.dietType.isNotEmpty
                              ? producte.dietType.toString()
                              : "-",
                        ),

                        InfoRow(
                          label: "Calories",
                          value: "${producte.calories}Kcal",
                        ),
                        // Si es tracta d'un widget de tipus beguda, mostrem
                        // si conté o no alcohol.
                        // Altre exemple de programació declarativa
                        // aplicat a la creació d'interfícies.
                        if (producte.getTipus() == ProductsType.beguda)
                          InfoRow(
                            label: "Amb/Sense Alcohol",
                            value: (producte as Beguda).isAlcoholic
                                ? "Amb alcohol"
                                : "Sense Alcohol",
                          ),
                        // espai per no tapar amb el botó per afegir al carret
                        // Això es coneix com CTA (Call to Action), i és una
                        // estratègia de màrqueting per "convidar" l'usuari
                        // a fer una acció (en este cas afegir´ el producte
                        // a la comanda)
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),

                  // CTA inferior: Altre SafeArea per no "estorbar" amb la
                  // interfície del sistema
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),

                      // Widget AnimatedSwitcher (https://api.flutter.dev/flutter/widgets/AnimatedSwitcher-class.html)
                      // Aquest widget permet fer una animació entre dos widgets
                      // que s'intercanvien entre ells.
                      child: AnimatedSwitcher(
                        // Definim algunes propietats de l'animació
                        duration: const Duration(milliseconds: 180),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,

                        // I com a fills, tornem a utilitzar Programació declarativa.
                        // Si la quantitat de productes a la comanda és 0, afegim
                        // un botó per afegir-lo, i si no, un altre contenidor
                        // per afegir o llevar més quantitat (bàsicament un comptador)
                        child: quantitat == 0
                            ? SizedBox(
                                // Primer contenidor del switch
                                width: double.infinity,
                                height: 54,
                                child: FilledButton.icon(
                                  // Les key són necessàries per fer l'animació
                                  // en el switch
                                  key: const ValueKey("add"),
                                  onPressed: () {
                                    // Usar el notifier para añadir el producto
                                    ref
                                        .read(carretProvider.notifier)
                                        .afigProducte(producte, 1);
                                  },
                                  icon: const Icon(Icons.add_shopping_cart),
                                  label: Text("Afegir · ${producte.price}€"),
                                ),
                              )
                            : QuantityBar(
                                // Segon contenidor del switch: Widget proivat defnit més avall
                                key: const ValueKey("quantitat"),
                                quantity: quantitat,
                                unitPrice: producte.price,
                                formatPrice: _formatPrice,
                                onMinus: () {
                                  // Usar el notifier para eliminar cantidad
                                  ref
                                      .read(carretProvider.notifier)
                                      .eliminaProducte(producte, 1);
                                },
                                onPlus: () {
                                  // Usar el notifier para añadir cantidad
                                  ref
                                      .read(carretProvider.notifier)
                                      .afigProducte(producte, 1);
                                },
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
