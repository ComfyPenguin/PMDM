// Part d'infrastructura del repositori
// Implementa les funcionalitats de la classe abstracta ComarquesRepository
// Cal notar que a Dart no existeixen intefaces com a tal, però totes les
// classes poden actuar com a interfaces.
// La forma de definir una interface és declarant una classe abstracta
// i implementant els mètodes d'aquesta.

import 'package:comarques_gui/domain/entities/comarca.dart';
import 'package:comarques_gui/domain/entities/comarca_simple.dart';
import 'package:comarques_gui/domain/entities/provincia.dart';
import 'package:comarques_gui/domain/repositories/comarques_repositori.dart';
import 'package:comarques_gui/infrastructure/data_sources/comarques_api.dart';
import 'package:comarques_gui/infrastructure/mappers/comarca_mapper.dart';
import 'package:comarques_gui/infrastructure/mappers/comarca_simple_mapper.dart';
import 'package:comarques_gui/infrastructure/mappers/provincia_mapper.dart';
import 'package:flutter/widgets.dart';

class ComarquesRepositoryImpl implements ComarquesRepository {
  // Referència a l'API remota
  final ComarquesApi remote;
  // L'API s'inicialitza en el constructor
  ComarquesRepositoryImpl(this.remote);

  // Obté una llista de Comarques (pertanyents a la província)
  @override
  Future<List<ComarcaSimple>> getComarques(String provincia) async {
    try {
      // Posem l'await per esperar-nos a obtenir la resposta
      final jsonComarques = await remote.getComarques(provincia);
      return jsonComarques
          .map((comarcaJSON) => ComarcaSimpleMapper.fromJson(comarcaJSON))
          .toList();
    } catch (e) {
      print("\x1B[31mError al recuperar les comarques: $e\x1B[0m");
      return [];
    }
  }

  // Obté informació sobre una comarca concreta
  @override
  Future<Comarca?> infoComarca(String comarca) async {
    try {
      final jsonComarca = await remote.infoComarca(comarca);
      // No cal fer un map perquè no és una llista!
      return ComarcaeMapper.fromJson(jsonComarca);
    } catch (e) {
      print(
        "\x1B[31mError al recuperar la informació de la comarca: $e\x1B[0m",
      );
      return null;
    }
  }

  // Obté la llista de províncies
  @override
  Future<List<Provincia>> obtenirProvincies() async {
    try {
      debugPrint("************");
      final jsonProvincies = await remote.obtenirProvincies();
      debugPrint(jsonProvincies.toString());
      return jsonProvincies
          .map((provinciaJSON) => ProvinciaeMapper.fromJson(provinciaJSON))
          .toList();
    } catch (e) {
      debugPrint("\x1B[31mError al recuperar les provincies: $e\x1B[0m");
      return [];
    }
  }
}
