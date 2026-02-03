import 'package:healthys_app/domain/entities/carret.dart';
import 'package:healthys_app/domain/entities/itemCarret.dart';
import 'package:healthys_app/domain/entities/producte.dart';

class EliminaProducteUsecase {
  Carret execute(Carret carretActual, Producte producte, int quantitat) {
    // Validar que la cantidad sea positiva
    if (quantitat <= 0) {
      throw ArgumentError(
        'La quantitat ha de ser major que 0. Valor rebut: $quantitat',
      );
    }

    // Copia la lista de items actual
    final List<ItemCarret> itemsActualitzats = List.from(carretActual.items);

    // Buscar el índice del producto existente en el carrito
    final int indexExistent = itemsActualitzats.indexWhere(
      (item) => item.producte.name == producte.name,
    );

    // Comprobar que el producto existe
    if (indexExistent == -1) {
      throw ArgumentError(
        'El producte "${producte.name}" no existeix al carret',
      );
    }

    // Obtener el item existente
    final ItemCarret itemExistent = itemsActualitzats[indexExistent];

    // Calcular la nueva cantidad
    final int novaQuantitat = itemExistent.quantitat - quantitat;

    if (novaQuantitat <= 0) {
      // Si la nueva cantidad es 0 o negativa eliminar el item completamente
      itemsActualitzats.removeAt(indexExistent);
    } else {
      // Si no reducir la cantidad
      itemsActualitzats[indexExistent] = ItemCarret(
        producte: itemExistent.producte,
        quantitat: novaQuantitat,
      );
    }

    // Devolver un nuevo Carret con los items actualizados
    return Carret(items: itemsActualitzats);
  }
}
