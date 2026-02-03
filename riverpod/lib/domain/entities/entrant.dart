import 'package:healthys_app/domain/entities/producte.dart';

class Entrant extends Producte {
  Entrant({
    required super.name,
    required super.description,
    super.tipus,
    required super.allergens,
    required super.price,
    required super.calories,
    required super.dietType,
    super.additionalInfo,
    super.img,
  });

  @override
  String toString() {
    return 'Entrant(name: $name, description: $description, tipus: $tipus, allergens: $allergens, price: $price, calories: $calories, dietType: $dietType, additionalInfo: $additionalInfo)';
  }

  @override
  ProductsType getTipus() {
    return ProductsType.entrant;
  }
}
