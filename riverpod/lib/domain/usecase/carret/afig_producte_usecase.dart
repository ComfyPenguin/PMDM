import 'package:healthys_app/domain/entities/carret.dart';
import 'package:healthys_app/domain/entities/itemCarret.dart';
import 'package:healthys_app/domain/entities/producte.dart';

class AfigProducteUsecase {
  Carret execute(Carret carretActual, Producte producte, int quantitat) {
    // Validar que la cantidad sea positiva
    if (quantitat <= 0) {
      throw ArgumentError(
        'La quantitat ha de ser major que 0. Valor rebut: $quantitat',
      );
    }

    // Copiar la lista de items actual
    final List<ItemCarret> itemsActualitzats = List.from(carretActual.items);

    // Buscar si el producto ya existe en el carrito (comparando por nombre)
    final int indexExistent = itemsActualitzats.indexWhere(
      (item) => item.producte.name == producte.name,
    );

    if (indexExistent != -1) {
      // Si el producto ya existe incrementar la cantidad
      final ItemCarret itemExistent = itemsActualitzats[indexExistent];
      final int novaQuantitat = itemExistent.quantitat + quantitat;

      // Crear un nuevo ItemCarret con la cantidad actualizada
      itemsActualitzats[indexExistent] = ItemCarret(
        producte: itemExistent.producte,
        quantitat: novaQuantitat,
      );
    } else {
      // Si el producto no existe agregar como un nuevo item
      itemsActualitzats.add(
        ItemCarret(producte: producte, quantitat: quantitat),
      );
    }

    // Devolver un nuevo Carret con los items actualizados
    return Carret(items: itemsActualitzats);
  }
}
