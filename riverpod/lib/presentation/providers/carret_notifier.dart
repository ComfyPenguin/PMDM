import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthys_app/domain/entities/carret.dart';
import 'package:healthys_app/domain/entities/producte.dart';
import 'package:healthys_app/domain/usecase/carret/afig_producte_usecase.dart';
import 'package:healthys_app/domain/usecase/carret/elimina_producte_usecase.dart';
import 'package:healthys_app/domain/usecase/carret/buida_carret_usecase.dart';

// Notifier que gestiona el estado del Carret
class CarretNotifier extends Notifier<Carret> {
  // Casos de uso
  late final AfigProducteUsecase _afigProducteUsecase;
  late final EliminaProducteUsecase _eliminaProducteUsecase;
  late final BuidaCarretUsecase _buidaCarretUsecase;

  @override
  Carret build() {
    // Inicializar casos de uso
    _afigProducteUsecase = AfigProducteUsecase();
    _eliminaProducteUsecase = EliminaProducteUsecase();
    _buidaCarretUsecase = BuidaCarretUsecase();

    // Estado inicial: carrito vacío
    return Carret(items: []);
  }

  // Añade un producto al carrito
  void afigProducte(Producte producte, int quantitat) {
    state = _afigProducteUsecase.execute(state, producte, quantitat);
  }

  // Elimina un producto del carrito
  void eliminaProducte(Producte producte, int quantitat) {
    state = _eliminaProducteUsecase.execute(state, producte, quantitat);
  }

  // Vacía completamente el carrito
  void buidaCarret() {
    state = _buidaCarretUsecase.execute();
  }

  // Comprueba si un producto ya está en el carrito
  bool conteProducte(String nomProducte) {
    return state.conteProducte(nomProducte);
  }

  // Obtiene la cantidad de un producto en el carrito, devuelve 0 si el producto no está en el carrito
  int quantitatProducte(String nomProducte) {
    return state.quantitatProducte(nomProducte);
  }

  // Obtiene la cantidad total de artículos en el carrito
  int get quantitatTotal => state.quantitatTotal;

  // Obtiene el precio total del carrito
  double get preuTotal => state.preuTotal;

  // Comprueba si el carrito está vacío
  bool get esBuit => state.esBuit;
}

// Provider global del carrito
final carretProvider = NotifierProvider<CarretNotifier, Carret>(() {
  return CarretNotifier();
});
