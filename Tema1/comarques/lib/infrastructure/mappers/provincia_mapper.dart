import 'package:comarquescli/domain/entities/provincia.dart';

class ProvinciaMapper {
  // Mètode estàtic que rep un JSON i retorna una istància de Comarca
  static Provincia fromJson(Map<String, dynamic> json) {
    return Provincia(nom: json["provincia"], imatge: json["img"] ?? "");
  }
}
