// Classe de repositori: Aquesta és la part a la que l'aplicació accedeix
// per consultar les dades.

// Generalment, el repositori es divideix en dues parts:
//  * Una a la capa de domini (aquesta), que defineix una classe abstracta
//    que descriu el comportament (els mètodes), i
//  * Una altra a la capa d'infrastructura, que serà on fem la implementació
//    d'aqueseta classe, segons la representació que tinguen les dades.

import 'dart:async';

import 'package:healthys_app/domain/entities/beguda.dart';
import 'package:healthys_app/domain/entities/entrant.dart';
import 'package:healthys_app/domain/entities/principal.dart';

abstract class CartaRepository {
  // Obté una llista d'entrants (bé directament o en un Future)
  Future<List<Entrant>> getEntrants(); // Proporcionem tipus per filtrar

  Future<List<Principal>> getPrincipals();

  Future<List<Beguda>> getBegudes();
}
