// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Receipt extends DataClass implements Insertable<Receipt> {
  final int id;
  final int storeId;
  final DateTime date;
  final double total;
  final String currency;
  final int tagId;
  final int categoryId;
  Receipt(
      {required this.id,
      required this.storeId,
      required this.date,
      required this.total,
      required this.currency,
      required this.tagId,
      required this.categoryId});
  factory Receipt.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final doubleType = db.typeSystem.forDartType<double>();
    final stringType = db.typeSystem.forDartType<String>();
    return Receipt(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      storeId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}store_id'])!,
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      total:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}total'])!,
      currency: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}currency'])!,
      tagId: intType.mapFromDatabaseResponse(data['${effectivePrefix}tag_id'])!,
      categoryId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['store_id'] = Variable<int>(storeId);
    map['date'] = Variable<DateTime>(date);
    map['total'] = Variable<double>(total);
    map['currency'] = Variable<String>(currency);
    map['tag_id'] = Variable<int>(tagId);
    map['category_id'] = Variable<int>(categoryId);
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: Value(id),
      storeId: Value(storeId),
      date: Value(date),
      total: Value(total),
      currency: Value(currency),
      tagId: Value(tagId),
      categoryId: Value(categoryId),
    );
  }

  factory Receipt.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Receipt(
      id: serializer.fromJson<int>(json['id']),
      storeId: serializer.fromJson<int>(json['storeId']),
      date: serializer.fromJson<DateTime>(json['date']),
      total: serializer.fromJson<double>(json['total']),
      currency: serializer.fromJson<String>(json['currency']),
      tagId: serializer.fromJson<int>(json['tagId']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storeId': serializer.toJson<int>(storeId),
      'date': serializer.toJson<DateTime>(date),
      'total': serializer.toJson<double>(total),
      'currency': serializer.toJson<String>(currency),
      'tagId': serializer.toJson<int>(tagId),
      'categoryId': serializer.toJson<int>(categoryId),
    };
  }

  Receipt copyWith(
          {int? id,
          int? storeId,
          DateTime? date,
          double? total,
          String? currency,
          int? tagId,
          int? categoryId}) =>
      Receipt(
        id: id ?? this.id,
        storeId: storeId ?? this.storeId,
        date: date ?? this.date,
        total: total ?? this.total,
        currency: currency ?? this.currency,
        tagId: tagId ?? this.tagId,
        categoryId: categoryId ?? this.categoryId,
      );
  @override
  String toString() {
    return (StringBuffer('Receipt(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('date: $date, ')
          ..write('total: $total, ')
          ..write('currency: $currency, ')
          ..write('tagId: $tagId, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          storeId.hashCode,
          $mrjc(
              date.hashCode,
              $mrjc(
                  total.hashCode,
                  $mrjc(currency.hashCode,
                      $mrjc(tagId.hashCode, categoryId.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Receipt &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.date == this.date &&
          other.total == this.total &&
          other.currency == this.currency &&
          other.tagId == this.tagId &&
          other.categoryId == this.categoryId);
}

class ReceiptsCompanion extends UpdateCompanion<Receipt> {
  final Value<int> id;
  final Value<int> storeId;
  final Value<DateTime> date;
  final Value<double> total;
  final Value<String> currency;
  final Value<int> tagId;
  final Value<int> categoryId;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.date = const Value.absent(),
    this.total = const Value.absent(),
    this.currency = const Value.absent(),
    this.tagId = const Value.absent(),
    this.categoryId = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    this.id = const Value.absent(),
    required int storeId,
    required DateTime date,
    required double total,
    required String currency,
    required int tagId,
    required int categoryId,
  })   : storeId = Value(storeId),
        date = Value(date),
        total = Value(total),
        currency = Value(currency),
        tagId = Value(tagId),
        categoryId = Value(categoryId);
  static Insertable<Receipt> custom({
    Expression<int>? id,
    Expression<int>? storeId,
    Expression<DateTime>? date,
    Expression<double>? total,
    Expression<String>? currency,
    Expression<int>? tagId,
    Expression<int>? categoryId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (date != null) 'date': date,
      if (total != null) 'total': total,
      if (currency != null) 'currency': currency,
      if (tagId != null) 'tag_id': tagId,
      if (categoryId != null) 'category_id': categoryId,
    });
  }

  ReceiptsCompanion copyWith(
      {Value<int>? id,
      Value<int>? storeId,
      Value<DateTime>? date,
      Value<double>? total,
      Value<String>? currency,
      Value<int>? tagId,
      Value<int>? categoryId}) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      date: date ?? this.date,
      total: total ?? this.total,
      currency: currency ?? this.currency,
      tagId: tagId ?? this.tagId,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<int>(storeId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('date: $date, ')
          ..write('total: $total, ')
          ..write('currency: $currency, ')
          ..write('tagId: $tagId, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }
}

class $ReceiptsTable extends Receipts with TableInfo<$ReceiptsTable, Receipt> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ReceiptsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _storeIdMeta = const VerificationMeta('storeId');
  @override
  late final GeneratedIntColumn storeId = _constructStoreId();
  GeneratedIntColumn _constructStoreId() {
    return GeneratedIntColumn('store_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES stores(id)');
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedDateTimeColumn date = _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedRealColumn total = _constructTotal();
  GeneratedRealColumn _constructTotal() {
    return GeneratedRealColumn(
      'total',
      $tableName,
      false,
    );
  }

  final VerificationMeta _currencyMeta = const VerificationMeta('currency');
  @override
  late final GeneratedTextColumn currency = _constructCurrency();
  GeneratedTextColumn _constructCurrency() {
    return GeneratedTextColumn(
      'currency',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedIntColumn tagId = _constructTagId();
  GeneratedIntColumn _constructTagId() {
    return GeneratedIntColumn('tag_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES tags(id)');
  }

  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  @override
  late final GeneratedIntColumn categoryId = _constructCategoryId();
  GeneratedIntColumn _constructCategoryId() {
    return GeneratedIntColumn('category_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES rCategories(id)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, storeId, date, total, currency, tagId, categoryId];
  @override
  $ReceiptsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'receipts';
  @override
  final String actualTableName = 'receipts';
  @override
  VerificationContext validateIntegrity(Insertable<Receipt> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('store_id')) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta));
    } else if (isInserting) {
      context.missing(_storeIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Receipt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Receipt.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ReceiptsTable createAlias(String alias) {
    return $ReceiptsTable(_db, alias);
  }
}

class Store extends DataClass implements Insertable<Store> {
  final int id;
  final String storeName;
  Store({required this.id, required this.storeName});
  factory Store.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Store(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      storeName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}store_name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['store_name'] = Variable<String>(storeName);
    return map;
  }

  StoresCompanion toCompanion(bool nullToAbsent) {
    return StoresCompanion(
      id: Value(id),
      storeName: Value(storeName),
    );
  }

  factory Store.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Store(
      id: serializer.fromJson<int>(json['id']),
      storeName: serializer.fromJson<String>(json['storeName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storeName': serializer.toJson<String>(storeName),
    };
  }

  Store copyWith({int? id, String? storeName}) => Store(
        id: id ?? this.id,
        storeName: storeName ?? this.storeName,
      );
  @override
  String toString() {
    return (StringBuffer('Store(')
          ..write('id: $id, ')
          ..write('storeName: $storeName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, storeName.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Store &&
          other.id == this.id &&
          other.storeName == this.storeName);
}

class StoresCompanion extends UpdateCompanion<Store> {
  final Value<int> id;
  final Value<String> storeName;
  const StoresCompanion({
    this.id = const Value.absent(),
    this.storeName = const Value.absent(),
  });
  StoresCompanion.insert({
    this.id = const Value.absent(),
    required String storeName,
  }) : storeName = Value(storeName);
  static Insertable<Store> custom({
    Expression<int>? id,
    Expression<String>? storeName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeName != null) 'store_name': storeName,
    });
  }

  StoresCompanion copyWith({Value<int>? id, Value<String>? storeName}) {
    return StoresCompanion(
      id: id ?? this.id,
      storeName: storeName ?? this.storeName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storeName.present) {
      map['store_name'] = Variable<String>(storeName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoresCompanion(')
          ..write('id: $id, ')
          ..write('storeName: $storeName')
          ..write(')'))
        .toString();
  }
}

class $StoresTable extends Stores with TableInfo<$StoresTable, Store> {
  final GeneratedDatabase _db;
  final String? _alias;
  $StoresTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _storeNameMeta = const VerificationMeta('storeName');
  @override
  late final GeneratedTextColumn storeName = _constructStoreName();
  GeneratedTextColumn _constructStoreName() {
    return GeneratedTextColumn(
      'store_name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, storeName];
  @override
  $StoresTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'stores';
  @override
  final String actualTableName = 'stores';
  @override
  VerificationContext validateIntegrity(Insertable<Store> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('store_name')) {
      context.handle(_storeNameMeta,
          storeName.isAcceptableOrUnknown(data['store_name']!, _storeNameMeta));
    } else if (isInserting) {
      context.missing(_storeNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Store map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Store.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $StoresTable createAlias(String alias) {
    return $StoresTable(_db, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String tagName;
  Tag({required this.id, required this.tagName});
  factory Tag.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Tag(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      tagName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}tag_name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tag_name'] = Variable<String>(tagName);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      tagName: Value(tagName),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      tagName: serializer.fromJson<String>(json['tagName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tagName': serializer.toJson<String>(tagName),
    };
  }

  Tag copyWith({int? id, String? tagName}) => Tag(
        id: id ?? this.id,
        tagName: tagName ?? this.tagName,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('tagName: $tagName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, tagName.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Tag && other.id == this.id && other.tagName == this.tagName);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> tagName;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.tagName = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String tagName,
  }) : tagName = Value(tagName);
  static Insertable<Tag> custom({
    Expression<int>? id,
    Expression<String>? tagName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tagName != null) 'tag_name': tagName,
    });
  }

  TagsCompanion copyWith({Value<int>? id, Value<String>? tagName}) {
    return TagsCompanion(
      id: id ?? this.id,
      tagName: tagName ?? this.tagName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tagName.present) {
      map['tag_name'] = Variable<String>(tagName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('tagName: $tagName')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TagsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _tagNameMeta = const VerificationMeta('tagName');
  @override
  late final GeneratedTextColumn tagName = _constructTagName();
  GeneratedTextColumn _constructTagName() {
    return GeneratedTextColumn(
      'tag_name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, tagName];
  @override
  $TagsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tags';
  @override
  final String actualTableName = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tag_name')) {
      context.handle(_tagNameMeta,
          tagName.isAcceptableOrUnknown(data['tag_name']!, _tagNameMeta));
    } else if (isInserting) {
      context.missing(_tagNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tag.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(_db, alias);
  }
}

class RCategorie extends DataClass implements Insertable<RCategorie> {
  final int id;
  final String categoryName;
  RCategorie({required this.id, required this.categoryName});
  factory RCategorie.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return RCategorie(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      categoryName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_name'] = Variable<String>(categoryName);
    return map;
  }

  RCategoriesCompanion toCompanion(bool nullToAbsent) {
    return RCategoriesCompanion(
      id: Value(id),
      categoryName: Value(categoryName),
    );
  }

  factory RCategorie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return RCategorie(
      id: serializer.fromJson<int>(json['id']),
      categoryName: serializer.fromJson<String>(json['categoryName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryName': serializer.toJson<String>(categoryName),
    };
  }

  RCategorie copyWith({int? id, String? categoryName}) => RCategorie(
        id: id ?? this.id,
        categoryName: categoryName ?? this.categoryName,
      );
  @override
  String toString() {
    return (StringBuffer('RCategorie(')
          ..write('id: $id, ')
          ..write('categoryName: $categoryName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, categoryName.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is RCategorie &&
          other.id == this.id &&
          other.categoryName == this.categoryName);
}

class RCategoriesCompanion extends UpdateCompanion<RCategorie> {
  final Value<int> id;
  final Value<String> categoryName;
  const RCategoriesCompanion({
    this.id = const Value.absent(),
    this.categoryName = const Value.absent(),
  });
  RCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String categoryName,
  }) : categoryName = Value(categoryName);
  static Insertable<RCategorie> custom({
    Expression<int>? id,
    Expression<String>? categoryName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryName != null) 'category_name': categoryName,
    });
  }

  RCategoriesCompanion copyWith({Value<int>? id, Value<String>? categoryName}) {
    return RCategoriesCompanion(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('categoryName: $categoryName')
          ..write(')'))
        .toString();
  }
}

class $RCategoriesTable extends RCategories
    with TableInfo<$RCategoriesTable, RCategorie> {
  final GeneratedDatabase _db;
  final String? _alias;
  $RCategoriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _categoryNameMeta =
      const VerificationMeta('categoryName');
  @override
  late final GeneratedTextColumn categoryName = _constructCategoryName();
  GeneratedTextColumn _constructCategoryName() {
    return GeneratedTextColumn(
      'category_name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, categoryName];
  @override
  $RCategoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'r_categories';
  @override
  final String actualTableName = 'r_categories';
  @override
  VerificationContext validateIntegrity(Insertable<RCategorie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_name')) {
      context.handle(
          _categoryNameMeta,
          categoryName.isAcceptableOrUnknown(
              data['category_name']!, _categoryNameMeta));
    } else if (isInserting) {
      context.missing(_categoryNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RCategorie map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return RCategorie.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $RCategoriesTable createAlias(String alias) {
    return $RCategoriesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ReceiptsTable receipts = $ReceiptsTable(this);
  late final $StoresTable stores = $StoresTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $RCategoriesTable rCategories = $RCategoriesTable(this);
  late final ReceiptDao receiptDao = ReceiptDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [receipts, stores, tags, rCategories];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ReceiptDaoMixin on DatabaseAccessor<AppDatabase> {
  $ReceiptsTable get receipts => attachedDatabase.receipts;
  $StoresTable get stores => attachedDatabase.stores;
  $TagsTable get tags => attachedDatabase.tags;
  $RCategoriesTable get rCategories => attachedDatabase.rCategories;
}
