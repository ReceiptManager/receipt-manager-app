/*
 * Copyright (c) 2020 - 2021 : William Todt
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Receipt extends DataClass implements Insertable<Receipt> {
  final int id;
  final double total;
  final String storeName;
  final DateTime date;
  Receipt(
      {required this.id,
      required this.total,
      required this.storeName,
      required this.date});
  factory Receipt.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Receipt(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      total:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}total'])!,
      storeName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}store_name'])!,
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total'] = Variable<double>(total);
    map['store_name'] = Variable<String>(storeName);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: Value(id),
      total: Value(total),
      storeName: Value(storeName),
      date: Value(date),
    );
  }

  factory Receipt.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Receipt(
      id: serializer.fromJson<int>(json['id']),
      total: serializer.fromJson<double>(json['total']),
      storeName: serializer.fromJson<String>(json['storeName']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'total': serializer.toJson<double>(total),
      'storeName': serializer.toJson<String>(storeName),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Receipt copyWith(
          {int? id, double? total, String? storeName, DateTime? date}) =>
      Receipt(
        id: id ?? this.id,
        total: total ?? this.total,
        storeName: storeName ?? this.storeName,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Receipt(')
          ..write('id: $id, ')
          ..write('total: $total, ')
          ..write('storeName: $storeName, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(total.hashCode, $mrjc(storeName.hashCode, date.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Receipt &&
          other.id == this.id &&
          other.total == this.total &&
          other.storeName == this.storeName &&
          other.date == this.date);
}

class ReceiptsCompanion extends UpdateCompanion<Receipt> {
  final Value<int> id;
  final Value<double> total;
  final Value<String> storeName;
  final Value<DateTime> date;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.total = const Value.absent(),
    this.storeName = const Value.absent(),
    this.date = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    this.id = const Value.absent(),
    required double total,
    required String storeName,
    required DateTime date,
  })   : total = Value(total),
        storeName = Value(storeName),
        date = Value(date);
  static Insertable<Receipt> custom({
    Expression<int>? id,
    Expression<double>? total,
    Expression<String>? storeName,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (total != null) 'total': total,
      if (storeName != null) 'store_name': storeName,
      if (date != null) 'date': date,
    });
  }

  ReceiptsCompanion copyWith(
      {Value<int>? id,
      Value<double>? total,
      Value<String>? storeName,
      Value<DateTime>? date}) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      total: total ?? this.total,
      storeName: storeName ?? this.storeName,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (storeName.present) {
      map['store_name'] = Variable<String>(storeName.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('total: $total, ')
          ..write('storeName: $storeName, ')
          ..write('date: $date')
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

  final VerificationMeta _storeNameMeta = const VerificationMeta('storeName');
  @override
  late final GeneratedTextColumn storeName = _constructStoreName();
  GeneratedTextColumn _constructStoreName() {
    return GeneratedTextColumn('store_name', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES stores(storeName)');
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

  @override
  List<GeneratedColumn> get $columns => [id, total, storeName, date];
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
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('store_name')) {
      context.handle(_storeNameMeta,
          storeName.isAcceptableOrUnknown(data['store_name']!, _storeNameMeta));
    } else if (isInserting) {
      context.missing(_storeNameMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ReceiptsTable receipts = $ReceiptsTable(this);
  late final $StoresTable stores = $StoresTable(this);
  late final ReceiptDao receiptDao = ReceiptDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [receipts, stores];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ReceiptDaoMixin on DatabaseAccessor<AppDatabase> {
  $ReceiptsTable get receipts => attachedDatabase.receipts;
  $StoresTable get stores => attachedDatabase.stores;
}
