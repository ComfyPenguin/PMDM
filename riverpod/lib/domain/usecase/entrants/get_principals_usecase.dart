import 'package:healthys_app/domain/entities/principal.dart';
import 'package:healthys_app/domain/repository/carta_repository.dart';

class GetPrincipalssUseCase {
  late final CartaRepository repository;

  GetPrincipalssUseCase(this.repository);

  // El cas d'ús, a través del mètode execute és qui
  // invoca al mètode del repositori.
  Future<List<Principal>> execute() async {
    return await repository.getPrincipals();
  }
}
