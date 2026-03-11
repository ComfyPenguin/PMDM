import 'package:healthys_drift_example/data/database/dao/entrant_dao.dart';
import 'package:healthys_drift_example/data/mappers/entrant_mapper.dart';
import 'package:healthys_drift_example/domain/entities/entrant_entity.dart';

class EntrantRepository {
  final EntrantDao _dao;

  EntrantRepository(this._dao);

  Stream<List<EntrantEntity>> watchAll() {
    return _dao.watchAllEntrants().map(
      (rows) => rows.map(EntrantMapper.toDomain).toList(),
    );
  }

  Future<int> add(EntrantEntity entrant) {
    return _dao.insertEntrant(EntrantMapper.toInsertCompanion(entrant));
  }

  Future<int> update(EntrantEntity entrant) {
    // Update per id (unique)
    return _dao.updateEntrantById(
      entrant.id,
      EntrantMapper.toUpdateCompanion(entrant),
    );
  }

  Future<void> delete(String id) {
    return _dao.deleteEntrantById(id);
  }
}
