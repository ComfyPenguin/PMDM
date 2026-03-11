import 'package:client_pizzeria/domain/repository/pizza_repository.dart';
import 'package:client_pizzeria/infrastructure/data_sources/pizza_api.dart';
import 'package:client_pizzeria/infrastructure/repository/pizza_repository_impl.dart';

class RepoSingleton {
  // Instància privada estàtica
  static RepoSingleton? _instancia;

  // Referència al repositori (classe abstracta)
  late PizzaRepository repo;

  // Constructor de factoria:
  // per assegurar que retornem una única instància
  factory RepoSingleton() {
    _instancia ??= RepoSingleton._();
    return _instancia!;
  }

  // Constructor privat
  RepoSingleton._() {
    // Inicialització del repositori
    final api = PizzaApi(
      "https://pizza-rest-server-production.up.railway.app/api/pizzeria/pizzes",
    );

    // Injecció de dependències (injectem el repositori)
    repo = PizzaRepositoryImpl(api);
  }
}
