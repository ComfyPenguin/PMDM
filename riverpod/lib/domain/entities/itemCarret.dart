import 'package:healthys_app/domain/entities/producte.dart';

class ItemCarret {
  final Producte producte;
  final int quantitat;

  ItemCarret({required this.producte, required this.quantitat});
  @override
  String toString() {
    return 'ItemCarret(producte: $producte, quantitat: $quantitat)';
  }

  double get preuTotal => producte.price * quantitat;
}
