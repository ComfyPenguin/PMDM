import 'package:healthys_app/domain/entities/producte.dart';

class Principal extends Producte {
  Principal({
    required super.name,
    required super.description,
    super.tipus,
    super.allergens,
    super.price,
    super.calories,
    super.dietType,
    super.additionalInfo,
    super.img,
  });

  @override
  String toString() {
    return 'Entrant(name: $name, description: $description, tipus: $tipus, allergens: $allergens, price: $price, calories: $calories, dietType: $dietType, additionalInfo: $additionalInfo, img: $img)';
  }
}
