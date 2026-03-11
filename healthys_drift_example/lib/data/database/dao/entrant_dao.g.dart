// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrant_dao.dart';

// ignore_for_file: type=lint
mixin _$EntrantDaoMixin on DatabaseAccessor<AppDatabase> {
  $EntrantTable get entrant => attachedDatabase.entrant;
  $DietaTable get dieta => attachedDatabase.dieta;
  $EntrantDietaTable get entrantDieta => attachedDatabase.entrantDieta;
  EntrantDaoManager get managers => EntrantDaoManager(this);
}

class EntrantDaoManager {
  final _$EntrantDaoMixin _db;
  EntrantDaoManager(this._db);
  $$EntrantTableTableManager get entrant =>
      $$EntrantTableTableManager(_db.attachedDatabase, _db.entrant);
  $$DietaTableTableManager get dieta =>
      $$DietaTableTableManager(_db.attachedDatabase, _db.dieta);
  $$EntrantDietaTableTableManager get entrantDieta =>
      $$EntrantDietaTableTableManager(_db.attachedDatabase, _db.entrantDieta);
}
