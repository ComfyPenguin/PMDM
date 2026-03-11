import 'package:client_pizzeria/domain/entities/pizza.dart';
import 'package:client_pizzeria/domain/repository/pizza_repository.dart';
import 'package:client_pizzeria/infrastructure/data_sources/pizza_api.dart';
import 'package:client_pizzeria/infrastructure/mappers/pizza_mapper.dart';

class PizzaRepositoryImpl extends PizzaRepository {
  // Referència a l'API remota
  final PizzaApi remote;
  // L'API s'inicialitza en el constructor
  PizzaRepositoryImpl(this.remote);

  @override
  Future<List<Pizza>> getPizzes({int pageNumber = 0, int pageSize = 6}) async {
    return (await remote.getPizzes(
      pageNumber: pageNumber,
      pageSize: pageSize,
    )).map((pizza) {
      return PizzaMapper.fromJson(pizza);
    }).toList();
  }
}
