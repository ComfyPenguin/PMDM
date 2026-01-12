import 'package:healthys_app/domain/repository/carta_repository.dart';
import 'package:healthys_app/domain/usecase/productes/get_begudes_usecase.dart';
import 'package:healthys_app/domain/usecase/productes/get_entrants_usecase.dart';
import 'package:healthys_app/domain/usecase/productes/get_principals_usecase.dart';
import 'package:healthys_app/infrastructure/data_sources/healthys_api.dart';
import 'package:healthys_app/infrastructure/repository/carta_repository_impl.dart';

class ServiceLocator {
  // Patró Service Locator. És un patró de disseny utilitzat per encapsular
  // processos relacionats amb l'obtenció de serveis.
  // Aquest "localitzador" proporciona un punt centralitzat per tal
  // d'accedir a totes les dependències.

  String remoteUrl = "https://healthys-backend.globeapp.dev";

  // Instància privada estàtica (Patró Singleton)
  static ServiceLocator? _instancia;

  // Referència al repositori (classe abstracta)
  late CartaRepository _cartaRepository;

  /* Data Sources. */

  // Referència a l'API
  late final HealthysApi _api;

  /* Casos d'ús */
  late final GetEntrantsUseCase getEntrantsUseCase;
  late final GetBegudesUseCase getBegudesUseCase;
  late final GetPrincipalsUseCase getPrincipalsUseCase;

  // Constructor de factoria:
  // per assegurar que retornem una única instància
  factory ServiceLocator() {
    _instancia ??= ServiceLocator._();
    return _instancia!;
  }

  // Constructor privat
  ServiceLocator._() {
    // Inicialització del repositori
    _api = HealthysApi(remoteUrl);

    // Injecció de dependències (injectem el repositori)
    _cartaRepository = CartaRepositoryImpl(_api);

    // Injectem el repositori al cas d'ús
    getEntrantsUseCase = GetEntrantsUseCase(_cartaRepository);
    getBegudesUseCase = GetBegudesUseCase(_cartaRepository);
    getPrincipalsUseCase = GetPrincipalsUseCase(_cartaRepository);
  }

  // Retornem la URL
  String getRemoteUrl() => remoteUrl;
}
