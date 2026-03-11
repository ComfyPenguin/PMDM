// lib/data/database/dieta_dao.dart

import 'package:drift/drift.dart';
import 'package:healthys_drift_example/data/database/app_database.dart';
import 'package:healthys_drift_example/data/database/tables.dart';

part 'dieta_dao.g.dart';

@DriftAccessor(tables: [Dieta, EntrantDieta])
class DietaDao extends DatabaseAccessor<AppDatabase> with _$DietaDaoMixin {
  DietaDao(super.db);

  // --- CONSULTES ---

  Stream<List<DietaData>> watchAllDietes() {
    return (select(dieta)..orderBy([(d) => OrderingTerm.asc(d.name)])).watch();
  }

  Future<DietaData?> getDietaById(int id) {
    return (select(dieta)..where((d) => d.id.equals(id))).getSingleOrNull();
  }

  Stream<List<DietaData>> searchDietes(String query) {
    final q = '%$query%';
    return (select(dieta)
          ..where((d) => d.name.like(q) | d.description.like(q))
          ..orderBy([(d) => OrderingTerm.asc(d.name)]))
        .watch();
  }

  // --- INSERCIONS ---

  Future<int> insertDieta(DietaCompanion item) {
    return into(dieta).insert(item);
  }

  // --- ACTUALITZACIONS ---

  Future<bool> updateDieta(DietaData item) {
    return update(dieta).replace(item);
  }

  Future<int> updateDescription(int id, String? newDescription) {
    return (update(dieta)..where((d) => d.id.equals(id))).write(
      DietaCompanion(
        description: newDescription == null
            ? const Value(null)
            : Value(newDescription),
      ),
    );
  }

  // --- ESBORRATS ---

  Future<void> deleteDieta(int id) async {
    // Esborra relacions (si no tens cascade)
    await (delete(entrantDieta)..where((t) => t.dietaId.equals(id))).go();
    await (delete(dieta)..where((d) => d.id.equals(id))).go();
  }
}
