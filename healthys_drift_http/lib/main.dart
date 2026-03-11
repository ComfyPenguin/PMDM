import 'package:flutter/material.dart';
import 'package:healthys_drift_http/data/database/app_database.dart';
import 'package:healthys_drift_http/data/database/dao/entrant_dao.dart';
import 'package:healthys_drift_http/data/repository/carta_repository.dart';
import 'package:healthys_drift_http/data/repository/entrant_repository.dart';
import 'package:healthys_drift_http/ui/screens/entrant_screen.dart';

void main() {
  // NOU
  // Definim el repositori per a la carta, a partir de l'API
  // Referència al repositori, d'on obtindrem la llista de productes
  final CartaRepository repository = CartaRepository(
    "https://healthys-express-backend-production.up.railway.app",
  );

  // Definim igual la base de dades, però li passem al repositori
  // EntrantRepository el repositori de la carta
  final db = AppDatabase();
  final entrantDao = EntrantDao(db);
  final entrantRepo = EntrantRepository(entrantDao, repository);

  runApp(MyApp(entrantRepository: entrantRepo));
}

class MyApp extends StatelessWidget {
  final EntrantRepository entrantRepository;

  // Modifiquem MyApp pe a que reba també el repositori
  const MyApp({super.key, required this.entrantRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: EntrantsScreen(repository: entrantRepository));
  }
}
