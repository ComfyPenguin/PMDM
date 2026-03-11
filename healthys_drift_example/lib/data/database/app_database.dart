import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables.dart';

// Incorporem el fitxer amb les classes que generarà Drift
part 'app_database.g.dart';

// Declarem les classe per a les taules de la base de dades
@DriftDatabase(tables: [Entrant, Dieta, EntrantDieta])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openDatabase());

  @override
  int get schemaVersion => 1; // Defineix la versió de la BD

  // Executor natiu (SQLite en Android/iOS/Desktop)
  static QueryExecutor _openDatabase() {
    return driftDatabase(name: 'app_database');
  }

  // Opcional: migració entre versions
  // Quan canviem l'esquema d'una base de dades,
  // necessitem definir com es produeix la migració entre versions.
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll(); // crea totes les taules
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // Exemple: afegir columna en v2
        // await m.addColumn(entrant, entrant.img);
      }
    },
  );
}
