/*import 'package:drift/drift.dart';
import 'package:healthys_drift_http/data/database/app_database.dart';
import 'package:healthys_drift_http/data/database/tables.dart';


part 'entrant_dao.g.dart';

@DriftAccessor(tables: [Entrant])
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  
  TasksDao(super.db);

  // --- CONSULTES ---

  // Obté tots els entrants com a Stream (reactiu!)
  Stream<List<EntrantData>> watchAllTasks() => select(entrants).watch();

  // Tasques filtrades per estat
  Stream<List<Entrant>> watchTasksByStatus(bool completed) {
    return (select(tasks)
          ..where((t) => t.completed.equals(completed))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  // Una sola tasca per ID
  Future<Task?> getTaskById(int id) {
    return (select(tasks)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  // Buscar per títol
  Stream<List<Task>> searchTasks(String query) {
    return (select(tasks)
          ..where((t) => t.title.like('%$query%')))
        .watch();
  }

  // --- INSERCIONS ---

  Future<int> insertTask(TasksCompanion task) {
    return into(tasks).insert(task);
  }

  // --- ACTUALITZACIONS ---

  Future<bool> updateTask(Task task) {
    return update(tasks).replace(task);
  }

  // Actualització parcial
  Future<void> toggleTask(int id, bool completed) {
    return (update(tasks)..where((t) => t.id.equals(id)))
        .write(TasksCompanion(completed: Value(completed)));
  }

  // --- ESBORRATS ---

  Future<int> deleteTask(int id) {
    return (delete(tasks)..where((t) => t.id.equals(id))).go();
  }

  Future<int> deleteCompletedTasks() {
    return (delete(tasks)..where((t) => t.completed.equals(true))).go();
  }
}

*/

// lib/data/database/entrant_dao.dart

import 'package:drift/drift.dart';
import 'package:healthys_drift_http/data/database/app_database.dart';
import 'package:healthys_drift_http/data/database/tables.dart';

part 'entrant_dao.g.dart';

@DriftAccessor(tables: [Entrant, EntrantDieta])
class EntrantDao extends DatabaseAccessor<AppDatabase> with _$EntrantDaoMixin {
  EntrantDao(super.db);

  // -----------------
  // CONSULTES (Entrants)
  // -----------------

  // Tots els entrants (reactiu)
  Stream<List<EntrantData>> watchAllEntrants() {
    return (select(
      entrant,
    )..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();
  }

  // Un entrant per idIntern (PK autoincrement)
  Future<EntrantData?> getEntrantByInternalId(int idIntern) {
    return (select(
      entrant,
    )..where((t) => t.idIntern.equals(idIntern))).getSingleOrNull();
  }

  // Un entrant per id (camp amb restricció d'unicitat)
  Future<EntrantData?> getEntrantById(String id) {
    return (select(entrant)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /*
  // Cerca per nom o descripció
  Stream<List<EntrantData>> searchEntrants(String query) {
    final q = '%$query%';
    return (select(entrant)
          ..where((t) => t.name.like(q) | t.description.like(q))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }

  // Filtrar per rang de calories
  Stream<List<EntrantData>> watchEntrantsByCalories({
    required int min,
    required int max,
  }) {
    return (select(entrant)
          ..where((t) => t.calories.isBetweenValues(min, max))
          ..orderBy([(t) => OrderingTerm.asc(t.calories)]))
        .watch();
  }

  // Filtrar per preu màxim
  Stream<List<EntrantData>> watchEntrantsCheaperThan(double maxPrice) {
    return (select(entrant)
          ..where((t) => t.price.isSmallerOrEqualValue(maxPrice))
          ..orderBy([(t) => OrderingTerm.asc(t.price)]))
        .watch();
  }
*/
  // -----------------
  // INSERCIONS (Entrants)
  // -----------------

  Future<int> insertEntrant(EntrantCompanion item) {
    return into(entrant).insert(item);
  }

  // Inserció “còmoda” amb el constructor insert
  Future<int> addEntrant({
    required String id,
    required String name,
    String? description,
    required double price,
    required int calories,
  }) {
    return into(entrant).insert(
      EntrantCompanion.insert(
        id: id,
        name: name,
        description: description == null
            ? const Value.absent()
            : Value(description),
        price: price,
        calories: calories,
      ),
    );
  }

  // -----------------
  // ACTUALITZACIONS (Entrants)
  // -----------------

  Future<bool> updateEntrant(EntrantData item) {
    return update(entrant).replace(item);
  }

  /*
  // Actualització parcial: canviar preu
  Future<int> updatePrice(int idIntern, double newPrice) {
    return (update(entrant)..where((t) => t.idIntern.equals(idIntern))).write(
      EntrantCompanion(price: Value(newPrice)),
    );
  }

  // Actualització parcial: canviar descripció
  Future<int> updateDescription(int idIntern, String? newDescription) {
    return (update(entrant)..where((t) => t.idIntern.equals(idIntern))).write(
      EntrantCompanion(
        description: newDescription == null
            ? const Value(null) // explícit: guarda NULL
            : Value(newDescription),
      ),
    );
  }
*/
  // -----------------
  // ESBORRATS (Entrants)
  // -----------------

  // IMPORTANT: com tenim FK a entrant_dietes, convé esborrar primer relacions
  // (si no han activat cascade, fallarà per aquesta restricció).
  Future<void> deleteEntrant(int idIntern) async {
    await (delete(
      entrantDieta,
    )..where((t) => t.entrantId.equals(idIntern))).go();
    await (delete(entrant)..where((t) => t.idIntern.equals(idIntern))).go();
  }

  Future<int> updateEntrantById(String id, EntrantCompanion changes) {
    return (update(entrant)..where((t) => t.id.equals(id))).write(changes);
  }

  Future<void> deleteEntrantById(String id) async {
    // Primer esborrem relacions de la taula pont.
    // Però ací necessitem l'idIntern per entrant_dietes. El resolem amb una consulta.
    final row = await (select(
      entrant,
    )..where((t) => t.id.equals(id))).getSingleOrNull();

    if (row == null) return;

    await (delete(
      entrantDieta,
    )..where((t) => t.entrantId.equals(row.idIntern))).go();

    await (delete(entrant)..where((t) => t.id.equals(id))).go();
  }
}
