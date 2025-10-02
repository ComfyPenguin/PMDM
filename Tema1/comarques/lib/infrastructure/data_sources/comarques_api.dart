// Aquesta classe és la que interactúa amb l'API per obtenir la informació
import 'dart:convert';
import 'dart:io';
import 'package:comarquescli/domain/entities/provincia.dart';
import 'package:http/http.dart' as http;

class ComarquesApi {
  // Aquesta és la URL base, que es proporcionarà en el moment de la instanciació.
  String baseURL;

  // Constructor
  ComarquesApi(this.baseURL);

// Obté la llista de províncies
  Future<List<dynamic>> obtenirProvincies() async {
    String url = baseURL;

    // Fem una petició HTTP i retornem el resultat com a una llista

    http.Response data = await http.get(Uri.parse(url));
    if (data.statusCode == HttpStatus.ok) {
      String body = utf8.decode(data.bodyBytes);
      final bodyJSON = jsonDecode(body) as List;

      return bodyJSON;
    } else {
      return [];
    }
  }

  // Obté una llista de JSON amb el resultat de l'API
  Future<List<dynamic>> obtenirComarques(String provincia) async {
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
    // TO-DO Hecho

    // Retorna la informació sobre la comarca, en format JSON, tal qual
    // ve de l'API.

    // Compte!! que ara no és una llista, sinò un objecte, pel que
    // no cal indicar el `as List`.
    
    String url = "$baseURL/infoComarca/$comarca";

    http.Response data = await http.get(Uri.parse(url));
    if (data.statusCode == HttpStatus.ok) {
      String body = utf8.decode(data.bodyBytes);
      final objecte = jsonDecode(body);

      return objecte;
    } else {
      return {};
    }
  }
}
