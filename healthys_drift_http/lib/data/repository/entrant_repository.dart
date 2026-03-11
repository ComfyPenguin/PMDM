import 'package:healthys_drift_http/data/database/app_database.dart';
import 'package:healthys_drift_http/data/database/dao/entrant_dao.dart';
import 'package:healthys_drift_http/data/mappers/entrant_mapper.dart';
import 'package:healthys_drift_http/data/repository/carta_repository.dart';
import 'package:healthys_drift_http/domain/entities/entrant_entity.dart';

class EntrantRepository {
  final EntrantDao _dao;
  final CartaRepository _carta;

  List<EntrantEntity> llistaEntrantsApi = [];

  EntrantRepository(this._dao, this._carta);

  Future<void> _updataInfoApi() async {
    if (llistaEntrantsApi.isEmpty) {
      llistaEntrantsApi = await _carta.getEntrants();
    }
  }

  Stream<List<EntrantEntity>> watchAll() {
    // En lloc de retornar directament el resultat del mapat, obtindrem primer
    // l'Stream, i completarem la informació d'aquest amb la informació de l'API

    return _dao.watchAllEntrants().asyncMap((rows) async {
      // Actualitzem la llista de la info de l'API
      await _updataInfoApi();
      // Agafem la llista d'entrants proporcionada per la base de dades,
      // i la mapegem a entitats del domini
      List<EntrantEntity> entrants = rows.map(EntrantMapper.toDomain).toList();
      // Completem amb la informació de la llista
      // Busquem l'ID per tota la llista d'entrants de l'API
      for (var entrantApi in llistaEntrantsApi) {
        for (var entrantBD in entrants) {
          if (entrantBD.id == entrantApi.id) {
            entrantBD.img = entrantApi.img;
            entrantBD.tipus = entrantApi.tipus;
            entrantBD.allergens = entrantApi.allergens;
            entrantBD.additionalInfo =
                entrantApi.additionalInfo; // Qualsevol informació addicional
          }
        }
      }

      return entrants;
    });
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
