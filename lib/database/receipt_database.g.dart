// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Receipt extends DataClass implements Insertable<Receipt> {
  final int id;
  final String receiptTotal;
  final String shopName;
  final String category;
  final DateTime receiptDate;

  Receipt(
      {@required this.id,
      @required this.receiptTotal,
      @required this.shopName,
      @required this.category,
      this.receiptDate});

  factory Receipt.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Receipt(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      receiptTotal: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}receipt_total']),
      shopName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}shop_name']),
      category: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      receiptDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}receipt_date']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || receiptTotal != null) {
      map['receipt_total'] = Variable<String>(receiptTotal);
    }
    if (!nullToAbsent || shopName != null) {
      map['shop_name'] = Variable<String>(shopName);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || receiptDate != null) {
      map['receipt_date'] = Variable<DateTime>(receiptDate);
    }
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      receiptTotal: receiptTotal == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptTotal),
      shopName: shopName == null && nullToAbsent
          ? const Value.absent()
          : Value(shopName),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      receiptDate: receiptDate == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptDate),
    );
  }

  factory Receipt.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Receipt(
      id: serializer.fromJson<int>(json['id']),
      receiptTotal: serializer.fromJson<String>(json['receiptTotal']),
      shopName: serializer.fromJson<String>(json['shopName']),
      category: serializer.fromJson<String>(json['category']),
      receiptDate: serializer.fromJson<DateTime>(json['receiptDate']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'receiptTotal': serializer.toJson<String>(receiptTotal),
      'shopName': serializer.toJson<String>(shopName),
      'category': serializer.toJson<String>(category),
      'receiptDate': serializer.toJson<DateTime>(receiptDate),
    };
  }

  Receipt copyWith({int id,
    String receiptTotal,
    String shopName,
    String category,
    DateTime receiptDate}) =>
      Receipt(
        id: id ?? this.id,
        receiptTotal: receiptTotal ?? this.receiptTotal,
        shopName: shopName ?? this.shopName,
        category: category ?? this.category,
        receiptDate: receiptDate ?? this.receiptDate,
      );

  @override
  String toString() {
    return (StringBuffer('Receipt(')
      ..write('id: $id, ')..write(
          'receiptTotal: $receiptTotal, ')..write('shopName: $shopName, ')..write(
          'category: $category, ')..write('receiptDate: $receiptDate')..write(
          ')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(
          id.hashCode,
          $mrjc(
              receiptTotal.hashCode,
              $mrjc(shopName.hashCode,
                  $mrjc(category.hashCode, receiptDate.hashCode)))));

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
          (other is Receipt &&
              other.id == this.id &&
              other.receiptTotal == this.receiptTotal &&
              other.shopName == this.shopName &&
              other.category == this.category &&
              other.receiptDate == this.receiptDate);
}

class ReceiptsCompanion extends UpdateCompanion<Receipt> {
  final Value<int> id;
  final Value<String> receiptTotal;
  final Value<String> shopName;
  final Value<String> category;
  final Value<DateTime> receiptDate;

  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.receiptTotal = const Value.absent(),
    this.shopName = const Value.absent(),
    this.category = const Value.absent(),
    this.receiptDate = const Value.absent(),
  });

  ReceiptsCompanion.insert({
    this.id = const Value.absent(),
    @required String receiptTotal,
    @required String shopName,
    @required String category,
    this.receiptDate = const Value.absent(),
  })  : receiptTotal = Value(receiptTotal),
        shopName = Value(shopName),
        category = Value(category);

  static Insertable<Receipt> custom({
    Expression<int> id,
    Expression<String> receiptTotal,
    Expression<String> shopName,
    Expression<String> category,
    Expression<DateTime> receiptDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (receiptTotal != null) 'receipt_total': receiptTotal,
      if (shopName != null) 'shop_name': shopName,
      if (category != null) 'category': category,
      if (receiptDate != null) 'receipt_date': receiptDate,
    });
  }

  ReceiptsCompanion copyWith({Value<int> id,
    Value<String> receiptTotal,
    Value<String> shopName,
    Value<String> category,
    Value<DateTime> receiptDate}) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      receiptTotal: receiptTotal ?? this.receiptTotal,
      shopName: shopName ?? this.shopName,
      category: category ?? this.category,
      receiptDate: receiptDate ?? this.receiptDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (receiptTotal.present) {
      map['receipt_total'] = Variable<String>(receiptTotal.value);
    }
    if (shopName.present) {
      map['shop_name'] = Variable<String>(shopName.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (receiptDate.present) {
      map['receipt_date'] = Variable<DateTime>(receiptDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsCompanion(')
      ..write('id: $id, ')..write(
          'receiptTotal: $receiptTotal, ')..write('shopName: $shopName, ')..write('category: $category, ')..write('receiptDate: $receiptDate')..write(')'))
        .toString();
  }
}

class $ReceiptsTable extends Receipts with TableInfo<$ReceiptsTable, Receipt> {
  final GeneratedDatabase _db;
  final String _alias;

  $ReceiptsTable(this._db, [this._alias]);

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;

  @override
  GeneratedIntColumn get id => _id ??= _constructId();

  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _receiptTotalMeta =
  const VerificationMeta('receiptTotal');
  GeneratedTextColumn _receiptTotal;

  @override
  GeneratedTextColumn get receiptTotal =>
      _receiptTotal ??= _constructReceiptTotal();

  GeneratedTextColumn _constructReceiptTotal() {
    return GeneratedTextColumn(
      'receipt_total',
      $tableName,
      false,
    );
  }

  final VerificationMeta _shopNameMeta = const VerificationMeta('shopName');
  GeneratedTextColumn _shopName;

  @override
  GeneratedTextColumn get shopName => _shopName ??= _constructShopName();

  GeneratedTextColumn _constructShopName() {
    return GeneratedTextColumn(
      'shop_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  GeneratedTextColumn _category;

  @override
  GeneratedTextColumn get category => _category ??= _constructCategory();

  GeneratedTextColumn _constructCategory() {
    return GeneratedTextColumn(
      'category',
      $tableName,
      false,
    );
  }

  final VerificationMeta _receiptDateMeta =
      const VerificationMeta('receiptDate');
  GeneratedDateTimeColumn _receiptDate;

  @override
  GeneratedDateTimeColumn get receiptDate =>
      _receiptDate ??= _constructReceiptDate();

  GeneratedDateTimeColumn _constructReceiptDate() {
    return GeneratedDateTimeColumn(
      'receipt_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, receiptTotal, shopName, category, receiptDate];

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
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('receipt_total')) {
      context.handle(
          _receiptTotalMeta,
          receiptTotal.isAcceptableOrUnknown(
              data['receipt_total'], _receiptTotalMeta));
    } else if (isInserting) {
      context.missing(_receiptTotalMeta);
    }
    if (data.containsKey('shop_name')) {
      context.handle(_shopNameMeta,
          shopName.isAcceptableOrUnknown(data['shop_name'], _shopNameMeta));
    } else if (isInserting) {
      context.missing(_shopNameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category'], _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('receipt_date')) {
      context.handle(
          _receiptDateMeta,
          receiptDate.isAcceptableOrUnknown(
              data['receipt_date'], _receiptDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  Receipt map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Receipt.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ReceiptsTable createAlias(String alias) {
    return $ReceiptsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ReceiptsTable _receipts;

  $ReceiptsTable get receipts => _receipts ??= $ReceiptsTable(this);
  ReceiptDao _receiptDao;

  ReceiptDao get receiptDao => _receiptDao ??= ReceiptDao(this as AppDatabase);

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [receipts];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ReceiptDaoMixin on DatabaseAccessor<AppDatabase> {
  $ReceiptsTable get receipts => attachedDatabase.receipts;
}
