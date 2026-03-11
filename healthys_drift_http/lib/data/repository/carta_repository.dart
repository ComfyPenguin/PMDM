// Defineix el repositori d'accés a les dades
// Aquesta capa és la que s'usa des de l'aplicació, per abstraure
// l'accés a les dades.

import 'package:healthys_drift_http/data/services/healthys_api.dart';
import 'package:healthys_drift_http/domain/entities/entrant_entity.dart';

class CartaRepository {
  late final String urlBase;

  // Amb late indiquem que aquest valor
  // s'inicialitza posteriorment (al constructor)
  late HealthysApi api;

  CartaRepository(this.urlBase) {
    api = HealthysApi(urlBase);
  }

  // Retorna una llista amb els entrants
  Future<List<EntrantEntity>> getEntrants() async {
    return (await api.getEntrants()).map((entrant) {
      return EntrantEntity.fromJson(entrant, urlBase);
    }).toList();
  }
}
