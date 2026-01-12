abstract class Producte {
  final String name; // Nom de l'entrant
  final String description; // Descripció amb ingredients
  final String? tipus;
  final List<String>? allergens; // Alèrgens
  final double? price; // Preu
  final int? calories; // Calories
  final List<String>? dietType; // Tipus de dieta (ex: vegà, sense gluten, etc.)
  final String? additionalInfo; // Qualsevol informació addicional
  final String? img;

  Producte({
    required this.name,
    required this.description,
    this.tipus,
    this.allergens,
    this.price,
    this.calories,
    this.dietType,
    this.additionalInfo,
    this.img,
  });
}
