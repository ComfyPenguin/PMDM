import 'package:healthys_app/domain/entities/beguda.dart';
import 'package:healthys_app/domain/repository/carta_repository.dart';

class GetBegudesUseCase {
  late final CartaRepository repository;

  GetBegudesUseCase(this.repository);

  // El cas d'ús, a través del mètode execute és qui
  // invoca al mètode del repositori.
  Future<List<Beguda>> execute() async {
    return await repository.getBegudes();
  }
}
