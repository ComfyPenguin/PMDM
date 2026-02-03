import 'package:healthys_app/domain/entities/itemCarret.dart';

class Carret {
  List<ItemCarret> items = [];

  Carret({required this.items});

  @override
  String toString() {
    return 'Carret(items: $items)';
  }

  int get quantitatTotal {
    int total = 0;
    for (var item in items) {
      total += item.quantitat;
    }
    return total;
  }

  double get preuTotal {
    double total = 0.0;
    for (var item in items) {
      total += item.preuTotal;
    }
    return total;
  }

  bool get esBuit => items.isEmpty;

  bool conteProducte(String nom) {
    for (var item in items) {
      if (item.producte.name == nom) {
        return true;
      }
    }
    return false;
  }

  int quantitatProducte(String nom) {
    for (var item in items) {
      if (item.producte.name == nom) {
        return item.quantitat;
      }
    }
    return 0;
  }
}
