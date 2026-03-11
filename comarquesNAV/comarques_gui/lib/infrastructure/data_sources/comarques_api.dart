// Aquesta classe és la que interactúa amb l'API per obtenir la informació
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ComarquesApi {
  // Aquesta és la URL base, que es proporcionarà en el moment de la instanciació.
  String baseURL;

  // Constructor
  ComarquesApi(this.baseURL);

  // Obté una llista de JSON amb el resultat de l'API
  Future<List<dynamic>> getComarques(String provincia) async {
    String url = "$baseURL/comarquesAmbImatge/$provincia";

    http.Response data = await http.get(Uri.parse(url));
    if (data.statusCode == HttpStatus.ok) {
      String body = utf8.decode(data.bodyBytes);
      final bodyJSON = jsonDecode(body) as List;

      return bodyJSON;
    } else {
      return [];
    }
  }

  // Obté informació sobre una comarca concreta
  Future<Map<String, dynamic>> infoComarca(String comarca) async {
    String url = "$baseURL/infoComarca/$comarca";

    http.Response data = await http.get(Uri.parse(url));
    if (data.statusCode == HttpStatus.ok) {
      String body = utf8.decode(data.bodyBytes);
      final bodyJSON = jsonDecode(body);

      return bodyJSON;
    } else {
      return {};
    }
  }

  // Obté la llista de províncies
  Future<List<dynamic>> obtenirProvincies() async {
    String url = baseURL;

    http.Response data = await http.get(Uri.parse(url));
    if (data.statusCode == HttpStatus.ok) {
      String body = utf8.decode(data.bodyBytes);
      final bodyJSON = jsonDecode(body) as List;

      return bodyJSON;
    } else {
      return [];
    }
  }
}
