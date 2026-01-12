import 'package:healthys_app/domain/entities/producte.dart';

class Beguda extends Producte {
  final bool? isAlcoholic;

  Beguda({
    required super.name,
    required super.description,
    super.tipus,
    super.allergens,
    super.price,
    super.calories,
    this.isAlcoholic,
    super.additionalInfo,
    super.img,
  });

  @override
  String toString() {
    return 'Entrant(name: $name, description: $description, tipus: $tipus, allergens: $allergens, price: $price, calories: $calories, isAlcoholic: $isAlcoholic, additionalInfo: $additionalInfo, img: $img)';
  }
}
