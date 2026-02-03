import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthys_app/core/service_locator.dart';
import 'package:healthys_app/domain/entities/producte.dart';
import 'package:healthys_app/presentation/screens/productes/widgets/grid_productes.dart';

// Pantalla per als diferents productes
// Es tracta d'un widget amb estat

class ProducteScreen extends StatefulWidget {
  final ProductsType tipus;
  const ProducteScreen({super.key, required this.tipus});

  @override
  State<ProducteScreen> createState() => _ProducteScreenState();
}

class _ProducteScreenState extends State<ProducteScreen> {
  // L'estat del widget vindrà definit per la llista de productes
  Future<List<Producte>?>? _llistaProductes;

  @override
  void initState() {
    // Inicialització de l'estat
    super.initState();
    // Executem el cas corresponent per obtenir la llista de productes concrets
    // Fem ús de switch com a expressió!´
    print("Incialitzant productes de tipus ${widget.tipus}");
    _llistaProductes = switch (widget.tipus) {
      ProductsType.entrant => ServiceLocator().getEntrantsUseCase.execute(),
      ProductsType.principal => ServiceLocator().getPrincipalsUseCase.execute(),
      _ => ServiceLocator().getBegudaUseCase.execute(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      // La construcció del widget dependrà del Future que se'ns retorne
      // a la llista de productes. Segons l'estat de la connexió i les dades
      // mostrarem una o altra cosa.
      child: FutureBuilder(
        future: _llistaProductes,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 1. Comprovar l'estat de connexió primer
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Si estem esperant dades, mostrem un indicador de progrés
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Comprovar errors
          if (snapshot.hasError) {
            // Si es produeix algun error, mostrem una icona d'error i el missatge
            // i afegim un botó per tornar a connectar, que torna a invocar
            // el cas d'ús per obtenir la llista de productes
            debugPrint('[ProducteScreen] ERROR: ${snapshot.error}');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _llistaProductes = ServiceLocator().getEntrantsUseCase
                            .execute();
                      });
                    },
                    child: const Text('Recarregar'),
                  ),
                ],
              ),
            );
          }

          // 3. Comprovar si tenim dades
          if (!snapshot.hasData || snapshot.data == null) {
            // Si no hi ha dades s'indica
            return const Center(child: Text('No hi ha dades disponibles'));
          }

          // 4. Mostrar les dades
          final llistaProductes = snapshot.data!;

          if (llistaProductes.isEmpty) {
            return const Center(child: Text('No hi ha productes disponibles'));
          }

          // Finalment, si hi ha dades, les mostrem.
          // Aci tenim diferents formes per representar aquests widgets
          // de tipus producte: Amb una llista simple, una llista de widgets
          // i finalment un grid. Podeu descomentar i comentar les diferents
          // línies per veure'n els efectes.

          //return LlistaProductesSimple(llistaProductes);
          //return LlistaProductes(llistaProductes);
          return GridProducts(llistaProductes);
        },
      ),
    );
  }
}
