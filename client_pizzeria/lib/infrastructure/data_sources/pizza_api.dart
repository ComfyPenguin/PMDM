import 'dart:convert'; // Per a utf8 i jsondecode
import 'dart:io'; // Per a HttpStatus
import 'package:http/http.dart'
    as http; // Importem la llibreria http l'àlias http

class PizzaApi {
  String urlBase;

  // Constructor
  PizzaApi(this.urlBase);

  Future<List<dynamic>> getPizzes({
    int pageNumber = 0,
    int pageSize = 6,
  }) async {
    //'https://pizza-rest-server-production.up.railway.app/api/pizzeria/pizzes';

    String url = "$urlBase?pageNumber=$pageNumber&pageSize=$pageSize";

    http.Response data = await http.get(Uri.parse(url));
    if (data.statusCode == HttpStatus.ok) {
      String body = utf8.decode(data.bodyBytes);
      final bodyJSON = jsonDecode(body);
      return bodyJSON["records"]
          as List; // Retornem només la propietat "records" com a llista
    } else {
      return [];
    }
  }
}
