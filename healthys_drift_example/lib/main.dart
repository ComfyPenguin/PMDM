import 'package:flutter/material.dart';
import 'package:healthys_drift_example/data/database/app_database.dart';
import 'package:healthys_drift_example/data/database/dao/entrant_dao.dart';
import 'package:healthys_drift_example/data/entrant_repository.dart';
import 'package:healthys_drift_example/ui/screens/entrant_screen.dart';

void main() {
  final db = AppDatabase();
  final entrantDao = EntrantDao(db);
  final entrantRepo = EntrantRepository(entrantDao);

  runApp(MyApp(entrantRepository: entrantRepo));
}

class MyApp extends StatelessWidget {
  final EntrantRepository entrantRepository;

  const MyApp({super.key, required this.entrantRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: EntrantsScreen(repository: entrantRepository));
  }
}
