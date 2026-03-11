// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $EntrantTable extends Entrant with TableInfo<$EntrantTable, EntrantData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntrantTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idInternMeta = const VerificationMeta(
    'idIntern',
  );
  @override
  late final GeneratedColumn<int> idIntern = GeneratedColumn<int>(
    'id_intern',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 5,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesMeta = const VerificationMeta(
    'calories',
  );
  @override
  late final GeneratedColumn<int> calories = GeneratedColumn<int>(
    'calories',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idIntern,
    id,
    name,
    description,
    price,
    calories,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entrant';
  @override
  VerificationContext validateIntegrity(
    Insertable<EntrantData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_intern')) {
      context.handle(
        _idInternMeta,
        idIntern.isAcceptableOrUnknown(data['id_intern']!, _idInternMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(
        _caloriesMeta,
        calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta),
      );
    } else if (isInserting) {
      context.missing(_caloriesMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idIntern};
  @override
  EntrantData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntrantData(
      idIntern: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_intern'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      calories: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EntrantTable createAlias(String alias) {
    return $EntrantTable(attachedDatabase, alias);
  }
}

class EntrantData extends DataClass implements Insertable<EntrantData> {
  final int idIntern;
  final String id;
  final String name;
  final String? description;
  final double price;
  final int calories;
  final DateTime createdAt;
  const EntrantData({
    required this.idIntern,
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.calories,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_intern'] = Variable<int>(idIntern);
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['price'] = Variable<double>(price);
    map['calories'] = Variable<int>(calories);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EntrantCompanion toCompanion(bool nullToAbsent) {
    return EntrantCompanion(
      idIntern: Value(idIntern),
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      price: Value(price),
      calories: Value(calories),
      createdAt: Value(createdAt),
    );
  }

  factory EntrantData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntrantData(
      idIntern: serializer.fromJson<int>(json['idIntern']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      price: serializer.fromJson<double>(json['price']),
      calories: serializer.fromJson<int>(json['calories']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idIntern': serializer.toJson<int>(idIntern),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'price': serializer.toJson<double>(price),
      'calories': serializer.toJson<int>(calories),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  EntrantData copyWith({
    int? idIntern,
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    double? price,
    int? calories,
    DateTime? createdAt,
  }) => EntrantData(
    idIntern: idIntern ?? this.idIntern,
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    price: price ?? this.price,
    calories: calories ?? this.calories,
    createdAt: createdAt ?? this.createdAt,
  );
  EntrantData copyWithCompanion(EntrantCompanion data) {
    return EntrantData(
      idIntern: data.idIntern.present ? data.idIntern.value : this.idIntern,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      price: data.price.present ? data.price.value : this.price,
      calories: data.calories.present ? data.calories.value : this.calories,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntrantData(')
          ..write('idIntern: $idIntern, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('calories: $calories, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(idIntern, id, name, description, price, calories, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntrantData &&
          other.idIntern == this.idIntern &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.price == this.price &&
          other.calories == this.calories &&
          other.createdAt == this.createdAt);
}

class EntrantCompanion extends UpdateCompanion<EntrantData> {
  final Value<int> idIntern;
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<double> price;
  final Value<int> calories;
  final Value<DateTime> createdAt;
  const EntrantCompanion({
    this.idIntern = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.price = const Value.absent(),
    this.calories = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  EntrantCompanion.insert({
    this.idIntern = const Value.absent(),
    required String id,
    required String name,
    this.description = const Value.absent(),
    required double price,
    required int calories,
    this.createdAt = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       price = Value(price),
       calories = Value(calories);
  static Insertable<EntrantData> custom({
    Expression<int>? idIntern,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? price,
    Expression<int>? calories,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (idIntern != null) 'id_intern': idIntern,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (calories != null) 'calories': calories,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  EntrantCompanion copyWith({
    Value<int>? idIntern,
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<double>? price,
    Value<int>? calories,
    Value<DateTime>? createdAt,
  }) {
    return EntrantCompanion(
      idIntern: idIntern ?? this.idIntern,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      calories: calories ?? this.calories,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idIntern.present) {
      map['id_intern'] = Variable<int>(idIntern.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (calories.present) {
      map['calories'] = Variable<int>(calories.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntrantCompanion(')
          ..write('idIntern: $idIntern, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('calories: $calories, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DietaTable extends Dieta with TableInfo<$DietaTable, DietaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DietaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dietes';
  @override
  VerificationContext validateIntegrity(
    Insertable<DietaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DietaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DietaData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $DietaTable createAlias(String alias) {
    return $DietaTable(attachedDatabase, alias);
  }
}

class DietaData extends DataClass implements Insertable<DietaData> {
  final int id;
  final String name;
  final String? description;
  const DietaData({required this.id, required this.name, this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  DietaCompanion toCompanion(bool nullToAbsent) {
    return DietaCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory DietaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DietaData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  DietaData copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
  }) => DietaData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
  );
  DietaData copyWithCompanion(DietaCompanion data) {
    return DietaData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DietaData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DietaData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description);
}

class DietaCompanion extends UpdateCompanion<DietaData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  const DietaCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  DietaCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
  }) : name = Value(name);
  static Insertable<DietaData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  DietaCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
  }) {
    return DietaCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DietaCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $EntrantDietaTable extends EntrantDieta
    with TableInfo<$EntrantDietaTable, EntrantDietaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntrantDietaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entrantIdMeta = const VerificationMeta(
    'entrantId',
  );
  @override
  late final GeneratedColumn<int> entrantId = GeneratedColumn<int>(
    'entrant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entrant (id_intern)',
    ),
  );
  static const VerificationMeta _dietaIdMeta = const VerificationMeta(
    'dietaId',
  );
  @override
  late final GeneratedColumn<int> dietaId = GeneratedColumn<int>(
    'dieta_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES dietes (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [entrantId, dietaId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entrant_dietes';
  @override
  VerificationContext validateIntegrity(
    Insertable<EntrantDietaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entrant_id')) {
      context.handle(
        _entrantIdMeta,
        entrantId.isAcceptableOrUnknown(data['entrant_id']!, _entrantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entrantIdMeta);
    }
    if (data.containsKey('dieta_id')) {
      context.handle(
        _dietaIdMeta,
        dietaId.isAcceptableOrUnknown(data['dieta_id']!, _dietaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_dietaIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entrantId, dietaId};
  @override
  EntrantDietaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntrantDietaData(
      entrantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entrant_id'],
      )!,
      dietaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dieta_id'],
      )!,
    );
  }

  @override
  $EntrantDietaTable createAlias(String alias) {
    return $EntrantDietaTable(attachedDatabase, alias);
  }
}

class EntrantDietaData extends DataClass
    implements Insertable<EntrantDietaData> {
  final int entrantId;
  final int dietaId;
  const EntrantDietaData({required this.entrantId, required this.dietaId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entrant_id'] = Variable<int>(entrantId);
    map['dieta_id'] = Variable<int>(dietaId);
    return map;
  }

  EntrantDietaCompanion toCompanion(bool nullToAbsent) {
    return EntrantDietaCompanion(
      entrantId: Value(entrantId),
      dietaId: Value(dietaId),
    );
  }

  factory EntrantDietaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntrantDietaData(
      entrantId: serializer.fromJson<int>(json['entrantId']),
      dietaId: serializer.fromJson<int>(json['dietaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entrantId': serializer.toJson<int>(entrantId),
      'dietaId': serializer.toJson<int>(dietaId),
    };
  }

  EntrantDietaData copyWith({int? entrantId, int? dietaId}) => EntrantDietaData(
    entrantId: entrantId ?? this.entrantId,
    dietaId: dietaId ?? this.dietaId,
  );
  EntrantDietaData copyWithCompanion(EntrantDietaCompanion data) {
    return EntrantDietaData(
      entrantId: data.entrantId.present ? data.entrantId.value : this.entrantId,
      dietaId: data.dietaId.present ? data.dietaId.value : this.dietaId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntrantDietaData(')
          ..write('entrantId: $entrantId, ')
          ..write('dietaId: $dietaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(entrantId, dietaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntrantDietaData &&
          other.entrantId == this.entrantId &&
          other.dietaId == this.dietaId);
}

class EntrantDietaCompanion extends UpdateCompanion<EntrantDietaData> {
  final Value<int> entrantId;
  final Value<int> dietaId;
  final Value<int> rowid;
  const EntrantDietaCompanion({
    this.entrantId = const Value.absent(),
    this.dietaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntrantDietaCompanion.insert({
    required int entrantId,
    required int dietaId,
    this.rowid = const Value.absent(),
  }) : entrantId = Value(entrantId),
       dietaId = Value(dietaId);
  static Insertable<EntrantDietaData> custom({
    Expression<int>? entrantId,
    Expression<int>? dietaId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entrantId != null) 'entrant_id': entrantId,
      if (dietaId != null) 'dieta_id': dietaId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntrantDietaCompanion copyWith({
    Value<int>? entrantId,
    Value<int>? dietaId,
    Value<int>? rowid,
  }) {
    return EntrantDietaCompanion(
      entrantId: entrantId ?? this.entrantId,
      dietaId: dietaId ?? this.dietaId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entrantId.present) {
      map['entrant_id'] = Variable<int>(entrantId.value);
    }
    if (dietaId.present) {
      map['dieta_id'] = Variable<int>(dietaId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntrantDietaCompanion(')
          ..write('entrantId: $entrantId, ')
          ..write('dietaId: $dietaId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $EntrantTable entrant = $EntrantTable(this);
  late final $DietaTable dieta = $DietaTable(this);
  late final $EntrantDietaTable entrantDieta = $EntrantDietaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    entrant,
    dieta,
    entrantDieta,
  ];
}

typedef $$EntrantTableCreateCompanionBuilder =
    EntrantCompanion Function({
      Value<int> idIntern,
      required String id,
      required String name,
      Value<String?> description,
      required double price,
      required int calories,
      Value<DateTime> createdAt,
    });
typedef $$EntrantTableUpdateCompanionBuilder =
    EntrantCompanion Function({
      Value<int> idIntern,
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<double> price,
      Value<int> calories,
      Value<DateTime> createdAt,
    });

final class $$EntrantTableReferences
    extends BaseReferences<_$AppDatabase, $EntrantTable, EntrantData> {
  $$EntrantTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EntrantDietaTable, List<EntrantDietaData>>
  _entrantDietaRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.entrantDieta,
    aliasName: $_aliasNameGenerator(
      db.entrant.idIntern,
      db.entrantDieta.entrantId,
    ),
  );

  $$EntrantDietaTableProcessedTableManager get entrantDietaRefs {
    final manager = $$EntrantDietaTableTableManager($_db, $_db.entrantDieta)
        .filter(
          (f) =>
              f.entrantId.idIntern.sqlEquals($_itemColumn<int>('id_intern')!),
        );

    final cache = $_typedResult.readTableOrNull(_entrantDietaRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EntrantTableFilterComposer
    extends Composer<_$AppDatabase, $EntrantTable> {
  $$EntrantTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idIntern => $composableBuilder(
    column: $table.idIntern,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> entrantDietaRefs(
    Expression<bool> Function($$EntrantDietaTableFilterComposer f) f,
  ) {
    final $$EntrantDietaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idIntern,
      referencedTable: $db.entrantDieta,
      getReferencedColumn: (t) => t.entrantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntrantDietaTableFilterComposer(
            $db: $db,
            $table: $db.entrantDieta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EntrantTableOrderingComposer
    extends Composer<_$AppDatabase, $EntrantTable> {
  $$EntrantTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idIntern => $composableBuilder(
    column: $table.idIntern,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EntrantTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntrantTable> {
  $$EntrantTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idIntern =>
      $composableBuilder(column: $table.idIntern, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<int> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> entrantDietaRefs<T extends Object>(
    Expression<T> Function($$EntrantDietaTableAnnotationComposer a) f,
  ) {
    final $$EntrantDietaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idIntern,
      referencedTable: $db.entrantDieta,
      getReferencedColumn: (t) => t.entrantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntrantDietaTableAnnotationComposer(
            $db: $db,
            $table: $db.entrantDieta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EntrantTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EntrantTable,
          EntrantData,
          $$EntrantTableFilterComposer,
          $$EntrantTableOrderingComposer,
          $$EntrantTableAnnotationComposer,
          $$EntrantTableCreateCompanionBuilder,
          $$EntrantTableUpdateCompanionBuilder,
          (EntrantData, $$EntrantTableReferences),
          EntrantData,
          PrefetchHooks Function({bool entrantDietaRefs})
        > {
  $$EntrantTableTableManager(_$AppDatabase db, $EntrantTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntrantTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntrantTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntrantTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idIntern = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<int> calories = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EntrantCompanion(
                idIntern: idIntern,
                id: id,
                name: name,
                description: description,
                price: price,
                calories: calories,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> idIntern = const Value.absent(),
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                required double price,
                required int calories,
                Value<DateTime> createdAt = const Value.absent(),
              }) => EntrantCompanion.insert(
                idIntern: idIntern,
                id: id,
                name: name,
                description: description,
                price: price,
                calories: calories,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EntrantTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entrantDietaRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (entrantDietaRefs) db.entrantDieta],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (entrantDietaRefs)
                    await $_getPrefetchedData<
                      EntrantData,
                      $EntrantTable,
                      EntrantDietaData
                    >(
                      currentTable: table,
                      referencedTable: $$EntrantTableReferences
                          ._entrantDietaRefsTable(db),
                      managerFromTypedResult: (p0) => $$EntrantTableReferences(
                        db,
                        table,
                        p0,
                      ).entrantDietaRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.entrantId == item.idIntern,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EntrantTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EntrantTable,
      EntrantData,
      $$EntrantTableFilterComposer,
      $$EntrantTableOrderingComposer,
      $$EntrantTableAnnotationComposer,
      $$EntrantTableCreateCompanionBuilder,
      $$EntrantTableUpdateCompanionBuilder,
      (EntrantData, $$EntrantTableReferences),
      EntrantData,
      PrefetchHooks Function({bool entrantDietaRefs})
    >;
typedef $$DietaTableCreateCompanionBuilder =
    DietaCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
    });
typedef $$DietaTableUpdateCompanionBuilder =
    DietaCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
    });

final class $$DietaTableReferences
    extends BaseReferences<_$AppDatabase, $DietaTable, DietaData> {
  $$DietaTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EntrantDietaTable, List<EntrantDietaData>>
  _entrantDietaRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.entrantDieta,
    aliasName: $_aliasNameGenerator(db.dieta.id, db.entrantDieta.dietaId),
  );

  $$EntrantDietaTableProcessedTableManager get entrantDietaRefs {
    final manager = $$EntrantDietaTableTableManager(
      $_db,
      $_db.entrantDieta,
    ).filter((f) => f.dietaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_entrantDietaRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DietaTableFilterComposer extends Composer<_$AppDatabase, $DietaTable> {
  $$DietaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> entrantDietaRefs(
    Expression<bool> Function($$EntrantDietaTableFilterComposer f) f,
  ) {
    final $$EntrantDietaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entrantDieta,
      getReferencedColumn: (t) => t.dietaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntrantDietaTableFilterComposer(
            $db: $db,
            $table: $db.entrantDieta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DietaTableOrderingComposer
    extends Composer<_$AppDatabase, $DietaTable> {
  $$DietaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DietaTableAnnotationComposer
    extends Composer<_$AppDatabase, $DietaTable> {
  $$DietaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> entrantDietaRefs<T extends Object>(
    Expression<T> Function($$EntrantDietaTableAnnotationComposer a) f,
  ) {
    final $$EntrantDietaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entrantDieta,
      getReferencedColumn: (t) => t.dietaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntrantDietaTableAnnotationComposer(
            $db: $db,
            $table: $db.entrantDieta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DietaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DietaTable,
          DietaData,
          $$DietaTableFilterComposer,
          $$DietaTableOrderingComposer,
          $$DietaTableAnnotationComposer,
          $$DietaTableCreateCompanionBuilder,
          $$DietaTableUpdateCompanionBuilder,
          (DietaData, $$DietaTableReferences),
          DietaData,
          PrefetchHooks Function({bool entrantDietaRefs})
        > {
  $$DietaTableTableManager(_$AppDatabase db, $DietaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DietaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DietaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DietaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
              }) =>
                  DietaCompanion(id: id, name: name, description: description),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
              }) => DietaCompanion.insert(
                id: id,
                name: name,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$DietaTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({entrantDietaRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (entrantDietaRefs) db.entrantDieta],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (entrantDietaRefs)
                    await $_getPrefetchedData<
                      DietaData,
                      $DietaTable,
                      EntrantDietaData
                    >(
                      currentTable: table,
                      referencedTable: $$DietaTableReferences
                          ._entrantDietaRefsTable(db),
                      managerFromTypedResult: (p0) => $$DietaTableReferences(
                        db,
                        table,
                        p0,
                      ).entrantDietaRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.dietaId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DietaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DietaTable,
      DietaData,
      $$DietaTableFilterComposer,
      $$DietaTableOrderingComposer,
      $$DietaTableAnnotationComposer,
      $$DietaTableCreateCompanionBuilder,
      $$DietaTableUpdateCompanionBuilder,
      (DietaData, $$DietaTableReferences),
      DietaData,
      PrefetchHooks Function({bool entrantDietaRefs})
    >;
typedef $$EntrantDietaTableCreateCompanionBuilder =
    EntrantDietaCompanion Function({
      required int entrantId,
      required int dietaId,
      Value<int> rowid,
    });
typedef $$EntrantDietaTableUpdateCompanionBuilder =
    EntrantDietaCompanion Function({
      Value<int> entrantId,
      Value<int> dietaId,
      Value<int> rowid,
    });

final class $$EntrantDietaTableReferences
    extends
        BaseReferences<_$AppDatabase, $EntrantDietaTable, EntrantDietaData> {
  $$EntrantDietaTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EntrantTable _entrantIdTable(_$AppDatabase db) =>
      db.entrant.createAlias(
        $_aliasNameGenerator(db.entrantDieta.entrantId, db.entrant.idIntern),
      );

  $$EntrantTableProcessedTableManager get entrantId {
    final $_column = $_itemColumn<int>('entrant_id')!;

    final manager = $$EntrantTableTableManager(
      $_db,
      $_db.entrant,
    ).filter((f) => f.idIntern.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entrantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DietaTable _dietaIdTable(_$AppDatabase db) => db.dieta.createAlias(
    $_aliasNameGenerator(db.entrantDieta.dietaId, db.dieta.id),
  );

  $$DietaTableProcessedTableManager get dietaId {
    final $_column = $_itemColumn<int>('dieta_id')!;

    final manager = $$DietaTableTableManager(
      $_db,
      $_db.dieta,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dietaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EntrantDietaTableFilterComposer
    extends Composer<_$AppDatabase, $EntrantDietaTable> {
  $$EntrantDietaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$EntrantTableFilterComposer get entrantId {
    final $$EntrantTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entrantId,
      referencedTable: $db.entrant,
      getReferencedColumn: (t) => t.idIntern,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntrantTableFilterComposer(
            $db: $db,
            $table: $db.entrant,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DietaTableFilterComposer get dietaId {
    final $$DietaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dietaId,
      referencedTable: $db.dieta,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DietaTableFilterComposer(
            $db: $db,
            $table: $db.dieta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntrantDietaTableOrderingComposer
    extends Composer<_$AppDatabase, $EntrantDietaTable> {
  $$EntrantDietaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$EntrantTableOrderingComposer get entrantId {
    final $$EntrantTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entrantId,
      referencedTable: $db.entrant,
      getReferencedColumn: (t) => t.idIntern,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntrantTableOrderingComposer(
            $db: $db,
            $table: $db.entrant,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DietaTableOrderingComposer get dietaId {
    final $$DietaTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dietaId,
      referencedTable: $db.dieta,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DietaTableOrderingComposer(
            $db: $db,
            $table: $db.dieta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntrantDietaTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntrantDietaTable> {
  $$EntrantDietaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$EntrantTableAnnotationComposer get entrantId {
    final $$EntrantTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entrantId,
      referencedTable: $db.entrant,
      getReferencedColumn: (t) => t.idIntern,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntrantTableAnnotationComposer(
            $db: $db,
            $table: $db.entrant,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DietaTableAnnotationComposer get dietaId {
    final $$DietaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dietaId,
      referencedTable: $db.dieta,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DietaTableAnnotationComposer(
            $db: $db,
            $table: $db.dieta,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntrantDietaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EntrantDietaTable,
          EntrantDietaData,
          $$EntrantDietaTableFilterComposer,
          $$EntrantDietaTableOrderingComposer,
          $$EntrantDietaTableAnnotationComposer,
          $$EntrantDietaTableCreateCompanionBuilder,
          $$EntrantDietaTableUpdateCompanionBuilder,
          (EntrantDietaData, $$EntrantDietaTableReferences),
          EntrantDietaData,
          PrefetchHooks Function({bool entrantId, bool dietaId})
        > {
  $$EntrantDietaTableTableManager(_$AppDatabase db, $EntrantDietaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntrantDietaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntrantDietaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntrantDietaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> entrantId = const Value.absent(),
                Value<int> dietaId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntrantDietaCompanion(
                entrantId: entrantId,
                dietaId: dietaId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int entrantId,
                required int dietaId,
                Value<int> rowid = const Value.absent(),
              }) => EntrantDietaCompanion.insert(
                entrantId: entrantId,
                dietaId: dietaId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EntrantDietaTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entrantId = false, dietaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (entrantId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.entrantId,
                                referencedTable: $$EntrantDietaTableReferences
                                    ._entrantIdTable(db),
                                referencedColumn: $$EntrantDietaTableReferences
                                    ._entrantIdTable(db)
                                    .idIntern,
                              )
                              as T;
                    }
                    if (dietaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.dietaId,
                                referencedTable: $$EntrantDietaTableReferences
                                    ._dietaIdTable(db),
                                referencedColumn: $$EntrantDietaTableReferences
                                    ._dietaIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EntrantDietaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EntrantDietaTable,
      EntrantDietaData,
      $$EntrantDietaTableFilterComposer,
      $$EntrantDietaTableOrderingComposer,
      $$EntrantDietaTableAnnotationComposer,
      $$EntrantDietaTableCreateCompanionBuilder,
      $$EntrantDietaTableUpdateCompanionBuilder,
      (EntrantDietaData, $$EntrantDietaTableReferences),
      EntrantDietaData,
      PrefetchHooks Function({bool entrantId, bool dietaId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EntrantTableTableManager get entrant =>
      $$EntrantTableTableManager(_db, _db.entrant);
  $$DietaTableTableManager get dieta =>
      $$DietaTableTableManager(_db, _db.dieta);
  $$EntrantDietaTableTableManager get entrantDieta =>
      $$EntrantDietaTableTableManager(_db, _db.entrantDieta);
}
