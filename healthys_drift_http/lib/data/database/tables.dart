import 'package:drift/drift.dart';

// Taula per emmagatzemar entrants
class Entrant extends Table {
  // Aquesta taula es dirà Entrants en la BD SQLite
  IntColumn get idIntern => integer().autoIncrement()(); // ID Autoincremental
  TextColumn get id => text().withLength(min: 1, max: 5).unique()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description =>
      text().nullable().withLength(min: 0, max: 200)();
  RealColumn get price => real()();
  IntColumn get calories => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Taula de dietes
class Dieta extends Table {
  // Amb aquest override especifiquem el nom de la taula a la BD
  // Si no diem res, Drifts fa el plural afegint una 's'
  @override
  String get tableName => 'dietes';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get description =>
      text().nullable()(); // La desrcripció és un text que pot se nul
}

// Taula de relació N:M
class EntrantDieta extends Table {
  @override
  String get tableName => 'entrant_dietes';
  IntColumn get entrantId => integer().references(Entrant, #idIntern)();
  IntColumn get dietaId => integer().references(Dieta, #id)();

  // Clau primària composta (per evitar duplicats)
  @override
  Set<Column> get primaryKey => {entrantId, dietaId};
}
