import 'dart:convert'; // Per a utf8 i jsondecode
import 'dart:io'; // Per a HttpStatus
import 'package:http/http.dart'
    as http; // Importem la llibreria http l'àlias http

class HealthysApi {
  String urlBase;

  // Constructor
  HealthysApi(this.urlBase);

  Future<List<dynamic>> getEntrants() async {
    //'https://healthys-backend-vv2dvdf-joamuran.globeapp.dev/api/entrants';

    String url = "$urlBase/api/entrants";

    http.Response data = await http.get(Uri.parse(url));
    if (data.statusCode == HttpStatus.ok) {
      String body = utf8.decode(data.bodyBytes);
      final bodyJSON = jsonDecode(body);

      return bodyJSON
          as List; // Retornem només la propietat "records" com a llista
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getPrincipals() async {
    //'https://healthys-backend-vv2dvdf-joamuran.globeapp.dev/api/principals';

    String url = "$urlBase/api/principals";

    http.Response data = await http.get(Uri.parse(url));
    if (data.statusCode == HttpStatus.ok) {
      String body = utf8.decode(data.bodyBytes);
      final bodyJSON = jsonDecode(body);

      return bodyJSON
          as List; // Retornem només la propietat "records" com a llista
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getBegudes() async {
    //'https://healthys-backend-vv2dvdf-joamuran.globeapp.dev/api/begudes';

    String url = "$urlBase/api/begudes";

    http.Response data = await http.get(Uri.parse(url));
    if (data.statusCode == HttpStatus.ok) {
      String body = utf8.decode(data.bodyBytes);
      final bodyJSON = jsonDecode(body);

      return bodyJSON
          as List; // Retornem només la propietat "records" com a llista
    } else {
      return [];
    }
  }
}
