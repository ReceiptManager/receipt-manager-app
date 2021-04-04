// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Receipt extends DataClass implements Insertable<Receipt> {
  final int id;
  final int storeName;
  final double total;
  final int currency;
  final DateTime date;
  final int tag;
  final int items;
  Receipt(
      {@required this.id,
      @required this.storeName,
      @required this.total,
      @required this.currency,
      @required this.date,
      this.tag,
      this.items});
  factory Receipt.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Receipt(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      storeName:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}store_name']),
      total:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}total']),
      currency:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}currency']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      tag: intType.mapFromDatabaseResponse(data['${effectivePrefix}tag']),
      items: intType.mapFromDatabaseResponse(data['${effectivePrefix}items']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || storeName != null) {
      map['store_name'] = Variable<int>(storeName);
    }
    if (!nullToAbsent || total != null) {
      map['total'] = Variable<double>(total);
    }
    if (!nullToAbsent || currency != null) {
      map['currency'] = Variable<int>(currency);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || tag != null) {
      map['tag'] = Variable<int>(tag);
    }
    if (!nullToAbsent || items != null) {
      map['items'] = Variable<int>(items);
    }
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      storeName: storeName == null && nullToAbsent
          ? const Value.absent()
          : Value(storeName),
      total:
          total == null && nullToAbsent ? const Value.absent() : Value(total),
      currency: currency == null && nullToAbsent
          ? const Value.absent()
          : Value(currency),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
      items:
          items == null && nullToAbsent ? const Value.absent() : Value(items),
    );
  }

  factory Receipt.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Receipt(
      id: serializer.fromJson<int>(json['id']),
      storeName: serializer.fromJson<int>(json['storeName']),
      total: serializer.fromJson<double>(json['total']),
      currency: serializer.fromJson<int>(json['currency']),
      date: serializer.fromJson<DateTime>(json['date']),
      tag: serializer.fromJson<int>(json['tag']),
      items: serializer.fromJson<int>(json['items']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storeName': serializer.toJson<int>(storeName),
      'total': serializer.toJson<double>(total),
      'currency': serializer.toJson<int>(currency),
      'date': serializer.toJson<DateTime>(date),
      'tag': serializer.toJson<int>(tag),
      'items': serializer.toJson<int>(items),
    };
  }

  Receipt copyWith(
          {int id,
          int storeName,
          double total,
          int currency,
          DateTime date,
          int tag,
          int items}) =>
      Receipt(
        id: id ?? this.id,
        storeName: storeName ?? this.storeName,
        total: total ?? this.total,
        currency: currency ?? this.currency,
        date: date ?? this.date,
        tag: tag ?? this.tag,
        items: items ?? this.items,
      );
  @override
  String toString() {
    return (StringBuffer('Receipt(')
          ..write('id: $id, ')
          ..write('storeName: $storeName, ')
          ..write('total: $total, ')
          ..write('currency: $currency, ')
          ..write('date: $date, ')
          ..write('tag: $tag, ')
          ..write('items: $items')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          storeName.hashCode,
          $mrjc(
              total.hashCode,
              $mrjc(
                  currency.hashCode,
                  $mrjc(
                      date.hashCode, $mrjc(tag.hashCode, items.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Receipt &&
          other.id == this.id &&
          other.storeName == this.storeName &&
          other.total == this.total &&
          other.currency == this.currency &&
          other.date == this.date &&
          other.tag == this.tag &&
          other.items == this.items);
}

class ReceiptsCompanion extends UpdateCompanion<Receipt> {
  final Value<int> id;
  final Value<int> storeName;
  final Value<double> total;
  final Value<int> currency;
  final Value<DateTime> date;
  final Value<int> tag;
  final Value<int> items;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.storeName = const Value.absent(),
    this.total = const Value.absent(),
    this.currency = const Value.absent(),
    this.date = const Value.absent(),
    this.tag = const Value.absent(),
    this.items = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    this.id = const Value.absent(),
    @required int storeName,
    @required double total,
    @required int currency,
    @required DateTime date,
    this.tag = const Value.absent(),
    this.items = const Value.absent(),
  })  : storeName = Value(storeName),
        total = Value(total),
        currency = Value(currency),
        date = Value(date);
  static Insertable<Receipt> custom({
    Expression<int> id,
    Expression<int> storeName,
    Expression<double> total,
    Expression<int> currency,
    Expression<DateTime> date,
    Expression<int> tag,
    Expression<int> items,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeName != null) 'store_name': storeName,
      if (total != null) 'total': total,
      if (currency != null) 'currency': currency,
      if (date != null) 'date': date,
      if (tag != null) 'tag': tag,
      if (items != null) 'items': items,
    });
  }

  ReceiptsCompanion copyWith(
      {Value<int> id,
      Value<int> storeName,
      Value<double> total,
      Value<int> currency,
      Value<DateTime> date,
      Value<int> tag,
      Value<int> items}) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      storeName: storeName ?? this.storeName,
      total: total ?? this.total,
      currency: currency ?? this.currency,
      date: date ?? this.date,
      tag: tag ?? this.tag,
      items: items ?? this.items,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storeName.present) {
      map['store_name'] = Variable<int>(storeName.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (currency.present) {
      map['currency'] = Variable<int>(currency.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (tag.present) {
      map['tag'] = Variable<int>(tag.value);
    }
    if (items.present) {
      map['items'] = Variable<int>(items.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('storeName: $storeName, ')
          ..write('total: $total, ')
          ..write('currency: $currency, ')
          ..write('date: $date, ')
          ..write('tag: $tag, ')
          ..write('items: $items')
          ..write(')'))
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

  final VerificationMeta _storeNameMeta = const VerificationMeta('storeName');
  GeneratedIntColumn _storeName;
  @override
  GeneratedIntColumn get storeName => _storeName ??= _constructStoreName();
  GeneratedIntColumn _constructStoreName() {
    return GeneratedIntColumn(
      'store_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _totalMeta = const VerificationMeta('total');
  GeneratedRealColumn _total;
  @override
  GeneratedRealColumn get total => _total ??= _constructTotal();
  GeneratedRealColumn _constructTotal() {
    return GeneratedRealColumn(
      'total',
      $tableName,
      false,
    );
  }

  final VerificationMeta _currencyMeta = const VerificationMeta('currency');
  GeneratedIntColumn _currency;
  @override
  GeneratedIntColumn get currency => _currency ??= _constructCurrency();
  GeneratedIntColumn _constructCurrency() {
    return GeneratedIntColumn(
      'currency',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tagMeta = const VerificationMeta('tag');
  GeneratedIntColumn _tag;
  @override
  GeneratedIntColumn get tag => _tag ??= _constructTag();
  GeneratedIntColumn _constructTag() {
    return GeneratedIntColumn(
      'tag',
      $tableName,
      true,
    );
  }

  final VerificationMeta _itemsMeta = const VerificationMeta('items');
  GeneratedIntColumn _items;
  @override
  GeneratedIntColumn get items => _items ??= _constructItems();
  GeneratedIntColumn _constructItems() {
    return GeneratedIntColumn(
      'items',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, storeName, total, currency, date, tag, items];
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
    if (data.containsKey('store_name')) {
      context.handle(_storeNameMeta,
          storeName.isAcceptableOrUnknown(data['store_name'], _storeNameMeta));
    } else if (isInserting) {
      context.missing(_storeNameMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total'], _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency'], _currencyMeta));
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag'], _tagMeta));
    }
    if (data.containsKey('items')) {
      context.handle(
          _itemsMeta, items.isAcceptableOrUnknown(data['items'], _itemsMeta));
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
