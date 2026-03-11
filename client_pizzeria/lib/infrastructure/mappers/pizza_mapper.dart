import 'package:client_pizzeria/domain/entities/pizza.dart';

class PizzaMapper {
  // Mètode estàtic que rep un JSON i retorna una instància de Pizza
  static Pizza fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: json["id"],
      nom: json["nom"],
      desc: json["desc"],
      vegetariana: json["vegetariana"],
      img: json["img"],
      preu: json["preu"],
      alergens:
          json["alergens"] != null ? List<String>.from(json["alergens"]) : null,
    );
  }
}
