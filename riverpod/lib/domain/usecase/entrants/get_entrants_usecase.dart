import 'package:healthys_app/domain/entities/entrant.dart';
import 'package:healthys_app/domain/repository/carta_repository.dart';

class GetEntrantsUseCase {
  late final CartaRepository repository;

  GetEntrantsUseCase(this.repository);

  // El cas d'ús, a través del mètode execute és qui
  // invoca al mètode del repositori.
  Future<List<Entrant>> execute() async {
    return await repository.getEntrants();
  }
}
