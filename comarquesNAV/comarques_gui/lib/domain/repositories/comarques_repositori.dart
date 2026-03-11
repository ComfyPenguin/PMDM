import 'package:comarques_gui/domain/entities/comarca.dart';
import 'package:comarques_gui/domain/entities/comarca_simple.dart';
import 'package:comarques_gui/domain/entities/provincia.dart';

// Classe de repositori: Aquesta és la part a la que l'aplicació accedeix
// per consultar les dades.

// Generalment, el repositori es divideix en dues parts:
//  * Una a la capa de domini (aquesta), que defineix una classe abstracta
//    que descriu el comportament (els mètodes), i
//  * Una altra a la capa d'infrastructura, que serà on fem la implementació
//    d'aqueseta classe, segons la representació que tinguen les dades.

abstract class ComarquesRepository {
  // Obté una llista de Comarques (pertanyents a la província)
  Future<List<ComarcaSimple>> getComarques(String provincia);

  // Obté informació sobre una comarca concreta
  Future<Comarca?> infoComarca(String comarca);

  // Obté la llista de províncies
  Future<List<Provincia>> obtenirProvincies();
}
