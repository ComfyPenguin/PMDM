import 'package:flutter/rendering.dart';
import 'package:healthys_app/core/service_locator.dart';
import 'package:healthys_app/domain/entities/beguda.dart';

class BegudaMapper {
  static String urlBase = ServiceLocator().getRemoteUrl();

  // Mètode estàtic que rep un JSON i retorna una instància de Pizza
  static Beguda fromJson(Map<String, dynamic> json) {
    try {
      return Beguda(
        name: json["name"] ?? "-",
        description: json["description"] ?? "-",
        tipus: json["tipus"] ?? "-",
        allergens: List.from(json["allergens"]),
        price: json["price"],
        calories: json["calories"],
        isAlcoholic: json["isAlcoholic"],
        additionalInfo: json["additionalInfo"] ?? "Desconegut",
        img: "$urlBase/${json['img'] ?? 'Desconegut'}",
      );
    } catch (error) {
      debugPrint("[Beguda Mapper] Error:  $error");
      return (Beguda(
        name: 'NomBeguda',
        description: 'DescBeguda',
        allergens: [],
        price: 0.0,
        calories: 0,
        isAlcoholic: false,
      ));
    }
  }
}
