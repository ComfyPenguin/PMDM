import 'package:comarques_gui/domain/entities/provincia.dart';

class ProvinciaeMapper {
  // Mètode estàtic que rep un JSON i retorna una istància de Comarca
  static Provincia fromJson(Map<String, dynamic> json) {
    return Provincia(nom: json["provincia"], imatge: json["img"] ?? "");
  }
}
