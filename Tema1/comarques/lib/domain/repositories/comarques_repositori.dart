import 'package:comarquescli/domain/entities/comarca.dart';
import 'package:comarquescli/domain/entities/comarca_simple.dart';
import 'package:comarquescli/domain/entities/provincia.dart';

// Classe de repositori: Aquesta és la part a la que l'aplicació accedeix
// per consultar les dades.

// Generalment, el repositori es divideix en dues parts:
//  * Una a la capa de domini (aquesta), que defineix una classe abstracta
//    que descriu el comportament (els mètodes), i
//  * Una altra a la capa d'infrastructura, que serà on fem la implementació
//    d'aqueseta classe, segons la representació que tinguen les dades.

abstract class ComarquesRepository {
  // Obté la llista de províncies
  Future<List<Provincia>> obtenirProvincies();

  // Obté una llista de Comarques (pertanyents a la província)
  Future<List<ComarcaSimple>> obtenirComarques(String provincia);

  // TO-DO Hecho
  // Declarar el mètode infoComarca
  Future<Comarca?> infoComarca(String comarca);
}
