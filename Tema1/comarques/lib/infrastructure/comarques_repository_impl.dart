import 'package:comarquescli/domain/entities/comarca.dart';
import 'package:comarquescli/domain/entities/comarca_simple.dart';
import 'package:comarquescli/domain/entities/provincia.dart';
import 'package:comarquescli/domain/repositories/comarques_repositori.dart';
import 'package:comarquescli/infrastructure/data_sources/comarques_api.dart';
import 'package:comarquescli/infrastructure/mappers/comarca_simple_mapper.dart';
import 'package:comarquescli/infrastructure/mappers/comarca_mapper.dart';
import 'package:comarquescli/infrastructure/mappers/provincia_mapper.dart';

// Part d'infrastructura del repositori
// Implementa les funcionalitats de la classe abstracta ComarquesRepository
// Cal notar que a Dart no existeixen intefaces com a tal, però totes les
// classes poden actuar com a interfaces.
// La forma de definir una interface és declarant una classe abstracta
// i implementant els mètodes d'aquesta.

class ComarquesRepositoryImpl implements ComarquesRepository {
  // Referència a l'API remota
  final ComarquesApi remote;
  // L'API s'inicialitza en el constructor
  ComarquesRepositoryImpl(this.remote);

// Obté la llista de províncies
  @override
  Future<List<Provincia>> obtenirProvincies() async {
    try {
      final jsonProvincies = await remote.obtenirProvincies();
      return jsonProvincies
          .map((provinciaJSON) => ProvinciaMapper.fromJson(provinciaJSON))
          .toList();
    } catch (e) {
      print("\x1B[31mError al recuperar les provincies: $e\x1B[0m");
      return [];
    }
  }

  // Obté una llista de Comarques (pertanyents a la província)
  @override
  Future<List<ComarcaSimple>> obtenirComarques(String provincia) async {
    try {
      // Posem l'await per esperar-nos a obtenir la resposta
      final jsonComarques = await remote.obtenirComarques(provincia);
      // TO-DO Hecho 
      // Descomentar quan implementem el Mapper
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
    // TO-DO Hecho
    // Fer ús del data source (remote) per obtenir la informació de la comarca
    // Fer ús de ComarcaMapper (per implementar) per convertir el JSON
    // rebut en un objecte de tipus Comarca i retornar-lo.
    try {
      // Posem l'await per esperar-nos a obtenir la resposta
      final jsonComarca = await remote.infoComarca(comarca);
      return ComarcaMapper.fromJson(jsonComarca);
    } catch (e) {
      print("\x1B[31mError al recuperar la comarca: $e\x1B[0m");
      return null;
    }
  }
}
