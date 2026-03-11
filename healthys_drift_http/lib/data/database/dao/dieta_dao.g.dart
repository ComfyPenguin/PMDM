// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dieta_dao.dart';

// ignore_for_file: type=lint
mixin _$DietaDaoMixin on DatabaseAccessor<AppDatabase> {
  $DietaTable get dieta => attachedDatabase.dieta;
  $EntrantTable get entrant => attachedDatabase.entrant;
  $EntrantDietaTable get entrantDieta => attachedDatabase.entrantDieta;
  DietaDaoManager get managers => DietaDaoManager(this);
}

class DietaDaoManager {
  final _$DietaDaoMixin _db;
  DietaDaoManager(this._db);
  $$DietaTableTableManager get dieta =>
      $$DietaTableTableManager(_db.attachedDatabase, _db.dieta);
  $$EntrantTableTableManager get entrant =>
      $$EntrantTableTableManager(_db.attachedDatabase, _db.entrant);
  $$EntrantDietaTableTableManager get entrantDieta =>
      $$EntrantDietaTableTableManager(_db.attachedDatabase, _db.entrantDieta);
}
