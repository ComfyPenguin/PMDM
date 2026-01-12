import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthys_app/domain/entities/principal.dart';
import 'package:healthys_app/core/service_locator.dart';
import 'package:healthys_app/presentation/screens/principals/widgets/grid_principals.dart';

// Pantalla per als entrants
// Es tracta d'un widget amb estat

class PrincipalsScreen extends StatefulWidget {
  const PrincipalsScreen({super.key});

  @override
  State<PrincipalsScreen> createState() => _PrincipalsScreenState();
}

class _PrincipalsScreenState extends State<PrincipalsScreen> {
  // L'estat del widget vindrà definit per la llista d'entrants
  Future<List<Principal>?>? _llistaPrincipals;

  @override
  void initState() {
    // Inicialització de l'estat
    super.initState();
    // Executem el cas d'ús d'obtenir la llista de principals
    _llistaPrincipals = ServiceLocator().getPrincipalsUseCase.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      // La construcció del widget dependrà del Future que se'ns retorne
      // a la llista d'entrants. Segons l'estat de la connexió i les dades
      // mostrarem una o altra cosa.
      child: FutureBuilder(
        future: _llistaPrincipals,
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
            debugPrint('[PrincipalsScreen] ERROR: ${snapshot.error}');
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
                        _llistaPrincipals = ServiceLocator()
                            .getPrincipalsUseCase
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
          final llistaPrincipals = snapshot.data!;

          if (llistaPrincipals.isEmpty) {
            return const Center(child: Text('No hi ha principals disponibles'));
          }

          // Finalment, si hi ha dades, les mostrem.
          // Aci tenim diferents formes per representar aquests widgets
          // de tipus entrant: Amb una llista simple, una llista de widgets
          // i finalment un grid. Podeu descomentar i comentar les diferents
          // línies per veure'n els efectes.

          //return LlistaEntrantsSimple(llistaPrincipals);
          //return LlistaEntrants(llistaPrincipals);
          return GridPrincipals(llistaPrincipals);
        },
      ),
    );
  }
}
