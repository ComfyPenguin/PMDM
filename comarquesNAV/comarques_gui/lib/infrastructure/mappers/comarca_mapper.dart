import 'package:comarques_gui/domain/entities/comarca.dart';

class ComarcaeMapper {
  // Mètode estàtic que rep un JSON i retorna una istància de Comarca
  static Comarca fromJson(Map<String, dynamic> json) {
    return Comarca(
      comarca: json["comarca"],
      capital: json["capital"],
      //poblacio: int.parse(json["poblacio"].replaceAll(".", "")),
      poblacio: json["poblacio"],
      img: json["img"],
      desc: json["desc"],
      latitud: json["latitud"] ?? 0.0,
      longitud: json["longitud"] ?? 0.0,
    );
  }
}
