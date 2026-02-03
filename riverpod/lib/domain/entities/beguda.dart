import 'package:healthys_app/domain/entities/producte.dart';

class Beguda extends Producte {
  final bool isAlcoholic;
  Beguda({
    required super.name,
    required super.description,
    super.tipus,
    required this.isAlcoholic,
    required super.allergens,
    required super.price,
    required super.calories,
    required super.dietType,
    super.additionalInfo,
    super.img,
  });

  @override
  String toString() {
    return 'Beguda(name: $name, description: $description, alcoholica: $isAlcoholic,tipus: $tipus, allergens: $allergens, price: $price, calories: $calories, dietType: $dietType, additionalInfo: $additionalInfo)';
  }

  @override
  ProductsType getTipus() {
    return ProductsType.beguda;
  }
}
