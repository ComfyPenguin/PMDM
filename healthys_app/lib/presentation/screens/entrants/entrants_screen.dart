import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthys_app/domain/entities/entrant.dart';
import 'package:healthys_app/core/service_locator.dart';
import 'package:healthys_app/presentation/screens/entrants/widgets/grid_entrants.dart';

// Pantalla per als entrants
// Es tracta d'un widget amb estat

class EntrantsScreen extends StatefulWidget {
  const EntrantsScreen({super.key});

  @override
  State<EntrantsScreen> createState() => _EntrantsScreenState();
}

class _EntrantsScreenState extends State<EntrantsScreen> {
  // L'estat del widget vindrà definit per la llista d'entrants
  Future<List<Entrant>?>? _llistaEntrants;

  @override
  void initState() {
    // Inicialització de l'estat
    super.initState();
    // Executem el cas d'ús d'obtenir la llista d'entrants
    _llistaEntrants = ServiceLocator().getEntrantsUseCase.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      // La construcció del widget dependrà del Future que se'ns retorne
      // a la llista d'entrants. Segons l'estat de la connexió i les dades
      // mostrarem una o altra cosa.
      child: FutureBuilder(
        future: _llistaEntrants,
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
            // el cas d'ús per obtenir la llista d'entrants
            debugPrint('[EntrantsScreen] ERROR: ${snapshot.error}');
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
                        _llistaEntrants = ServiceLocator().getEntrantsUseCase
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
          final llistaEntrants = snapshot.data!;

          if (llistaEntrants.isEmpty) {
            return const Center(child: Text('No hi ha entrants disponibles'));
          }

          // Finalment, si hi ha dades, les mostrem.
          // Aci tenim diferents formes per representar aquests widgets
          // de tipus entrant: Amb una llista simple, una llista de widgets
          // i finalment un grid. Podeu descomentar i comentar les diferents
          // línies per veure'n els efectes.

          //return LlistaEntrantsSimple(llistaEntrants);
          //return LlistaEntrants(llistaEntrants);
          return GridEntrants(llistaEntrants);
        },
      ),
    );
  }
}
