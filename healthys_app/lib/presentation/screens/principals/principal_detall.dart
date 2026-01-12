import 'package:flutter/material.dart';
import 'package:healthys_app/domain/entities/principal.dart';
import 'package:healthys_app/presentation/widgets/llista_alergens.dart';

// Widget amb estat, ja que incorporarà la quantitat de productes afegits.

class PrincipalDetall extends StatefulWidget {
  final Principal principal;
  final int quantitat;

  const PrincipalDetall({
    super.key,
    required this.principal,
    this.quantitat = 0, // Proporcionem la quantitat inicial
  });

  @override
  State<PrincipalDetall> createState() => _PrincipalDetallState();
}

class _PrincipalDetallState extends State<PrincipalDetall> {
  // L'estat del widget ve determinat per la
  // quantitat d'aquest producte que volem afegir
  late int _quantitat;

  @override
  void initState() {
    super.initState();
    // Agafem la quantitat inicial del widget
    // i la limitem entre 0 i 9999
    _quantitat = widget.quantitat.clamp(0, 9999);
  }

  // Métode privat per actualitzar la quantitat de producte
  void _actualitzaQuantitat(int value) {
    final newValue = value.clamp(0, 9999); // Limitem entre 0 i 9999
    // Si el valor a actualitzar és el mateix que la quantitat guardada
    // en l'estat, no hem de fer res
    if (newValue == _quantitat) return;
    // En cas que el nou valor siga diferent a l'emmagatzemat,
    // invoquem a setState per actualitzar l'estat i la interfície.
    setState(() => _quantitat = newValue);
  }

  // Funció per formatar el preu
  String _formatPrice(double price) {
    return "${price.toStringAsFixed(2)} €";
  }

  @override
  Widget build(BuildContext context) {
    final principal =
        widget.principal; // Agafem la principal del widget associat a l'estat
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
            // Carreguem la imatge de la principal
            principal.img ?? "",
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
                _RoundIconButton(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.of(context).maybePop(),
                ),
                const Spacer(),
                _RoundIconButton(
                  icon: Icons.favorite_border,
                  onTap: () {
                    // Aci afegiriem la lògica per afegir el plat als favorits
                    // De moment podria ser un booleà a l'estat, i actualitzar
                    // la icona segons siga favorit o no (i altternar entre
                    // Icons.favorite_border i Icons.favorite)
                    // TO-DO...
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
        // Compte que aci tenim un widget nou!!
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
                          // Nom de la beguda. Observeu que partim dels
                          // estils definits al tema.
                          principal.name,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Descripció del plat (ingredients)
                        Text(
                          principal.description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Informació addicional (la mateixa que en les targetes)
                        Text(
                          principal.additionalInfo ?? "",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Widget amb la llista d'al·lèrgens (la que teniem
                        // per a la pizzeria)
                        LlistaAlergens(alergens: principal.allergens),
                        const SizedBox(height: 18),

                        // Fila amb el preu i la quantitat que tenim a la comanda
                        Row(
                          children: [
                            //Espaiador per espentar el preu a la dreta
                            const Spacer(),
                            // Preu formatat
                            Text(
                              _formatPrice(principal.price ?? 0.0),
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

                        // _InfoRow és una classe privada pe formatar aquesta informació
                        // Li proporcionem una etiqueta i el valor
                        _InfoRow(
                          label: "Categoría",
                          value: "${principal.tipus}",
                        ),
                        _InfoRow(
                          label: "Tipues de dietes",
                          // Aci tenim unexemple de programació declarativa:
                          // Especifiquem què volem que es mostre en funció de
                          // l'estat actual de l'aplicació.
                          value: principal.dietType!.isNotEmpty
                              ? principal.dietType.toString()
                              : "-",
                        ),
                        _InfoRow(
                          label: "Calories",
                          value: "${principal.calories}Kcal",
                        ),
                        // espai per no tapar amb el botó per afegir al carret
                        // Això es coneix com CTA (Call to Action), i és una
                        // estratègia de màrqueting per "convidar" l'usuari
                        // a fer una acció (en este cas afegir el producte
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
                        child: _quantitat == 0
                            ? SizedBox(
                                // Primer contenidor del switch
                                width: double.infinity,
                                height: 54,
                                child: FilledButton.icon(
                                  // Les key són necessàries per fer l'animació
                                  // en el switch
                                  key: const ValueKey("add"),
                                  onPressed: () => _actualitzaQuantitat(1),
                                  icon: const Icon(Icons.add_shopping_cart),
                                  label: Text("Afegir · ${principal.price}€"),
                                ),
                              )
                            : _QuantityBar(
                                // Segon contenidor del switch: Widget proivat defnit més avall
                                key: const ValueKey("quantitat"),
                                quantity: _quantitat,
                                unitPrice: principal.price ?? 0.0,
                                formatPrice: _formatPrice,
                                onMinus: () =>
                                    _actualitzaQuantitat(_quantitat - 1),
                                onPlus: () =>
                                    _actualitzaQuantitat(_quantitat + 1),
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

// Widget privat per mostrar el comptador de productes
// Li proporcionem la quantitat inicial, el pereu unitari,
// la funció de format, i dos funcions de callback (de tipus VoidCallback),
// per a afegir o eliminar productes.

class _QuantityBar extends StatelessWidget {
  final int quantity;
  final double unitPrice;
  final String Function(double) formatPrice;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const _QuantityBar({
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

//Widget auxiliar per als botons de l'Appbar simulat. Li passem
// la icona i una funció de callback a executar quan es fa clic
class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    // Widget nou! Defineix un component Material (hereta les propeitats
    // de disseny de Material). En el nostre cas tindrà un detector de
    // gestos de tipus Inkwell de forma circular
    return Material(
      color: Colors.black.withValues(alpha: 0.28),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

// Classe pe mostrar parells etiqueta-valor, amb un espaiador entr ells.
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
