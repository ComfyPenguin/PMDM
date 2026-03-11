import 'package:drift/drift.dart' show Value;
import 'package:healthys_drift_example/data/database/app_database.dart';
import 'package:healthys_drift_example/domain/entities/entrant_entity.dart';

class EntrantMapper {
  // De Drift (fila BD) a Entitat de domini
  // Els camps que NO es guarden a la BD: els deixem a null o a default del domini.
  // Després els agafarem de l'API!
  static EntrantEntity toDomain(EntrantData row) {
    return EntrantEntity(
      id: row.id,
      name: row.name,
      description: row.description ?? '',
      price: row.price,
      calories: row.calories,

      // Propietats que no es guarden a la BD
      tipus: null,
      allergens: const [],
      dietType: null, // Això es guarda a la taula de dietes que no utilitzem
      additionalInfo: null,
      img: null,
    );
  }

  // Domini a Companion, per INSERTs
  // createdAt té valor default a la BD, així que el deixem absent.
  static EntrantCompanion toInsertCompanion(EntrantEntity e) {
    return EntrantCompanion.insert(
      id: e.id,
      name: e.name,
      description: e.description.isEmpty
          ? const Value.absent()
          : Value(e.description),
      price: e.price,
      calories: e.calories,
    );
  }

  // Domini a Companion, per fer UPDATEs parcials
  // No toquem camps que no estan a la BD (tipus, allergens, etc.)
  // De moment, això no ho utilitzem perquè no fem actualitzacions
  static EntrantCompanion toUpdateCompanion(EntrantEntity e) {
    return EntrantCompanion(
      name: Value(e.name),
      description: Value(e.description),
      price: Value(e.price),
      calories: Value(e.calories),
    );
  }
}
