import 'package:comarques_gui/domain/repositories/comarques_repositori.dart';
import 'package:comarques_gui/infrastructure/data_sources/comarques_api.dart';
import 'package:comarques_gui/infrastructure/repository/comarques_repository_impl.dart';

class RepoSingleton {
  // Instància privada estàtica
  static RepoSingleton? _instancia;

  // Referència al repositori (classe abstracta)
  late ComarquesRepository repo;

  // Constructor de factoria:
  // per assegurar que retornem una única instància
  factory RepoSingleton() {
    _instancia ??= RepoSingleton._();
    return _instancia!;
  }

  // Constructor privat
  RepoSingleton._() {
    // Inicialització del repositori
    final api = ComarquesApi(
      "https://node-comarques-rest-server-production.up.railway.app/api/comarques",
    );

    // Injecció de dependències (injectem el repositori)
    repo = ComarquesRepositoryImpl(api); // Injecció de dependències
  }
}
