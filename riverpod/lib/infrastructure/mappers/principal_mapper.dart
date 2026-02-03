import 'package:flutter/rendering.dart';
import 'package:healthys_app/core/service_locator.dart';
import 'package:healthys_app/domain/entities/principal.dart';

class PrincipalMapper {
  static String urlBase = ServiceLocator().getRemoteUrl();

  // Mètode estàtic que rep un JSON i retorna una instància de Pizza
  static Principal fromJson(Map<String, dynamic> json) {
    try {
      return Principal(
        name: json["name"] ?? "-",
        description: json["description"] ?? "-",
        tipus: json["tipus"] ?? "-",
        allergens: List.from(json["allergens"]),
        price: json["price"],
        calories: json["calories"],
        dietType: [],
        additionalInfo: json["additionalInfo"] ?? "Desconegut",
        img: "$urlBase/${json['img'] ?? 'Desconegut'}",
      );
    } catch (error) {
      debugPrint("[Entrant Mapper] Error:  $error");
      return (Principal(
        name: 'NomPrincipal',
        description: 'DescPrincipal',
        allergens: [],
        price: 0.0,
        calories: 0,
        dietType: [],
      ));
    }
  }
}
