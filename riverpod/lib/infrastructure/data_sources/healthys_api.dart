import 'dart:convert'; // Per a utf8 i jsondecode
import 'dart:io'; // Per a HttpStatus
import 'package:http/http.dart'
    as http; // Importem la llibreria http l'àlias http

class HealthysApi {
  String urlBase;

  // Constructor
  HealthysApi(this.urlBase);

  // Aci també podem implementar una crida genèrica...

  Future<List<dynamic>> getProduct(String url) async {
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

  Future<List<dynamic>> getEntrants() async {
    String url = "$urlBase/api/entrants";
    return await getProduct(url);
  }

  Future<List<dynamic>> getPrincipals() async {
    String url = "$urlBase/api/principals";
    return await getProduct(url);
  }

  Future<List<dynamic>> getBegudes() async {
    String url = "$urlBase/api/begudes";
    return await getProduct(url);
  }
}
