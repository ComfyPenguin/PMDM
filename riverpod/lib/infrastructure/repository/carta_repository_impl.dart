import 'package:healthys_app/domain/entities/beguda.dart';
import 'package:healthys_app/domain/entities/entrant.dart';
import 'package:healthys_app/domain/entities/principal.dart';
import 'package:healthys_app/domain/repository/carta_repository.dart';
import 'package:healthys_app/infrastructure/data_sources/healthys_api.dart';
import 'package:healthys_app/infrastructure/mappers/beguda_mapper.dart';
import 'package:healthys_app/infrastructure/mappers/entrant_mapper.dart';
import 'package:healthys_app/infrastructure/mappers/principal_mapper.dart';

class CartaRepositoryImpl extends CartaRepository {
  // Referència a l'API remota
  final HealthysApi remote;

  // L'API s'inicialitza en el constructor
  CartaRepositoryImpl(this.remote);

  @override
  Future<List<Entrant>> getEntrants() async {
    print("Retorne Entrants");
    return (await remote.getEntrants()).map((entrant) {
      return EntrantMapper.fromJson(entrant);
    }).toList();
  }

  @override
  Future<List<Principal>> getPrincipals() async {
    print("Retorne Principals");
    return (await remote.getPrincipals()).map((principal) {
      return PrincipalMapper.fromJson(principal);
    }).toList();
  }

  @override
  Future<List<Beguda>> getBegudes() async {
    print("Retorne Begudes");
    return (await remote.getBegudes()).map((beguda) {
      return BegudaMapper.fromJson(beguda);
    }).toList();
  }
}
