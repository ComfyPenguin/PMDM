import 'dart:io';
import 'package:comarquescli/domain/entities/comarca.dart';
import 'package:comarquescli/domain/entities/comarca_simple.dart';
import 'package:comarquescli/domain/entities/provincia.dart';
import 'package:comarquescli/domain/repositories/comarques_repositori.dart';
import 'package:comarquescli/infrastructure/comarques_repository_impl.dart';
import 'package:comarquescli/infrastructure/data_sources/comarques_api.dart';

/*

Tasca 1. Aplicació en consola per a la consulta d'informació de les comarques
         a una API REST.

Funcions principals:

* Per obtenir la llista de províncies, farem:

  dart run comarquescli provincies
  
* Per obtenir la llista de comarques d'una provincia, (p. ex. Castelló), farem:  

  dart run comarquescli comarques Castelló

* Per obtenir informació sobre una comarca (p.ex.  "La Ribera Baixa") farem:

  dart run comarquescli infocomarca La Ribera Baixa

 */

void main(List<String> arguments) {
  // Comprovació del nombre d'arguments
  if (arguments.isEmpty) {
    print("\x1B[31m Nombre d'arguments incorrectes\x1B[0m");
    exit(-1);
  }

  // Parsegem la llista d'arguments
  List<String> llistaArgs = List.from(arguments);
  String? ordre;
  String? args;

  // Separem l'ordre (provincies, comarques, infocomarca) de la llista d'arguments
  ordre = llistaArgs[0];
  llistaArgs.removeAt(0);
  args = llistaArgs.join(" ");

  // Inicialitzem l'API, proporcionant-li la URL base per fer les consules
  final api = ComarquesApi(
      "https://node-comarques-rest-server-production.up.railway.app/api/comarques");

  // Amb l'API instanciada, creem el repositori.
  // Açò es coneix com injecció de dependències: estem "injectant" el repositori
  // a l'aplicació.

  // Injecció de dependències (injectem el repositori a l'aplicació).
  // Amb això complim el principi SOLID d'inversió de dependències (D).

  final repository = ComarquesRepositoryImpl(api); // Injecció de dependències
  AppComarques myApp = AppComarques(repository: repository);

  // Comprovem l'ordre i els arguments

  switch (ordre) {
    case "provincies":
      myApp.mostraProvincies(); // Implementació amb Future
      // myApp.mostraProvinciesSync();    // Exemple d'implementació amb async/await
      break;

    case "comarques":
      if (arguments.length != 2) {
        print(
            "\x1B[31m Nombre d'arguments incorrectes. Cal especificat la província.\x1B[0m");
        exit(-1);
      }
      myApp.mostraComarques(args);
      break;

    case "infocomarca":
      if (arguments.length < 2) {
        print(
            "\x1B[31m Nombre d'arguments incorrectes. Cal especificat la Comarca.\x1B[0m");
        exit(-1);
      }
      myApp.mostraInfoComarca(args);
      break;
    default:
      print("\x1B[31mOrdre desconeguda\x1B[0m");
  }
}

class AppComarques {
  // Observeu que el repositori es defineix com la classe abstracta
  // ComarquesRepository, però s'inicialitza des del programa principal
  // com a ComarquesRepositoryImpl, que és una implementació d'aquesta.
  // Així podriem canviar la implementació del repositori per obtenir les
  // dades d'altra API o d'una base de dades, i no canviaria res
  // d'aquesta classe.

  ComarquesRepository repository;

  // Constructor
  AppComarques({required this.repository});

  //Anem amb els mètodes per obtenir províncies, comarques, etc.

  // Implementació de mostraProvincies fent ús del Future

  mostraProvincies() {
    // La llista de províncies vindrà en un Future
    Future<List<Provincia>> respostaFuture = repository.obtenirProvincies();

    // Preparem el callback
    respostaFuture.then((resposta) {
      if (resposta.isNotEmpty) {
        for (var provincia in resposta) {
          print(provincia.toString());
        }
      } else {
        print("\x1B[31mNo s'ha obtingut cap resposta\x1B[0m");
      }
    });
  }

  // Implementació de mostraProvincies amb async/await

  mostraProvinciesSync() async {
    // La llista de províncies s'obté directament
    List<Provincia> provincies = await repository.obtenirProvincies();

    if (provincies.isNotEmpty) {
      for (var provincia in provincies) {
        print(provincia.toString());
      }
    } else {
      print("\x1B[31mNo s'ha obtingut cap resposta\x1B[0m");
    }
  }

  mostraComarques(String provincia) {
    // TO-DO Hecho
    // Obtenir la llista de comarques simplificada i mostrar-la per pantalla
    Future<List<ComarcaSimple>> respostaFuture = repository.obtenirComarques(provincia);

    // Preparem el callback
    respostaFuture.then((resposta) {
      if (resposta.isNotEmpty) {
        for (var comarca in resposta) {
          print(comarca.toString());
        }
      } else {
        print("\x1B[31mNo s'ha obtingut cap resposta\x1B[0m");
      }
    });
  }

  mostraInfoComarca(String comarca) {
    // TO-DO Hecho
    // Obtenir la informació completa sobre la comarca indicada i mostrar-la
  
    Future<Comarca?> respostaFuture = repository.infoComarca(comarca);

    // Preparem el callback
    respostaFuture.then((resposta) {
      if (resposta != null) {
          print(resposta.toString());
      } else {
        print("\x1B[31mNo s'ha obtingut cap resposta\x1B[0m");
      }
    });
  }
}
