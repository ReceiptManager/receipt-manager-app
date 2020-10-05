// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
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

  factory Receipt.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Receipt(
      id: serializer.fromJson<int>(json['id']),
      receiptTotal: serializer.fromJson<String>(json['receiptTotal']),
      shopName: serializer.fromJson<String>(json['shopName']),
      category: serializer.fromJson<String>(json['category']),
      receiptDate: serializer.fromJson<DateTime>(json['receiptDate']),
    );
  }

  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'receiptTotal': serializer.toJson<String>(receiptTotal),
      'shopName': serializer.toJson<String>(shopName),
      'category': serializer.toJson<String>(category),
      'receiptDate': serializer.toJson<DateTime>(receiptDate),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Receipt>>(bool nullToAbsent) {
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
    ) as T;
  }

  Receipt copyWith(
          {int id,
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
          ..write('id: $id, ')
          ..write('receiptTotal: $receiptTotal, ')
          ..write('shopName: $shopName, ')
          ..write('category: $category, ')
          ..write('receiptDate: $receiptDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          receiptTotal.hashCode,
          $mrjc(shopName.hashCode,
              $mrjc(category.hashCode, receiptDate.hashCode)))));

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Receipt &&
          other.id == id &&
          other.receiptTotal == receiptTotal &&
          other.shopName == shopName &&
          other.category == category &&
          other.receiptDate == receiptDate);
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
  ReceiptsCompanion copyWith(
      {Value<int> id,
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
  VerificationContext validateIntegrity(ReceiptsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.receiptTotal.present) {
      context.handle(
          _receiptTotalMeta,
          receiptTotal.isAcceptableValue(
              d.receiptTotal.value, _receiptTotalMeta));
    } else if (receiptTotal.isRequired && isInserting) {
      context.missing(_receiptTotalMeta);
    }
    if (d.shopName.present) {
      context.handle(_shopNameMeta,
          shopName.isAcceptableValue(d.shopName.value, _shopNameMeta));
    } else if (shopName.isRequired && isInserting) {
      context.missing(_shopNameMeta);
    }
    if (d.category.present) {
      context.handle(_categoryMeta,
          category.isAcceptableValue(d.category.value, _categoryMeta));
    } else if (category.isRequired && isInserting) {
      context.missing(_categoryMeta);
    }
    if (d.receiptDate.present) {
      context.handle(_receiptDateMeta,
          receiptDate.isAcceptableValue(d.receiptDate.value, _receiptDateMeta));
    } else if (receiptDate.isRequired && isInserting) {
      context.missing(_receiptDateMeta);
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
  Map<String, Variable> entityToSql(ReceiptsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.receiptTotal.present) {
      map['receipt_total'] = Variable<String, StringType>(d.receiptTotal.value);
    }
    if (d.shopName.present) {
      map['shop_name'] = Variable<String, StringType>(d.shopName.value);
    }
    if (d.category.present) {
      map['category'] = Variable<String, StringType>(d.category.value);
    }
    if (d.receiptDate.present) {
      map['receipt_date'] =
          Variable<DateTime, DateTimeType>(d.receiptDate.value);
    }
    return map;
  }

  @override
  $ReceiptsTable createAlias(String alias) {
    return $ReceiptsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(const SqlTypeSystem.withDefaults(), e);
  $ReceiptsTable _receipts;
  $ReceiptsTable get receipts => _receipts ??= $ReceiptsTable(this);
  ReceiptDao _receiptDao;

  ReceiptDao get receiptDao => _receiptDao ??= ReceiptDao(this as AppDatabase);

  @override
  List<TableInfo> get allTables => [receipts];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ReceiptDaoMixin on DatabaseAccessor<AppDatabase> {
  $ReceiptsTable get receipts => db.receipts;
}
