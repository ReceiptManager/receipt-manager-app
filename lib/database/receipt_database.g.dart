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
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Receipt extends DataClass implements Insertable<Receipt> {
  final int id;
  final String total;
  final String shop;
  final String category;
  final String items;
  final DateTime date;
  Receipt(
      {@required this.id,
      @required this.total,
      @required this.shop,
      @required this.category,
      this.items,
      @required this.date});
  factory Receipt.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Receipt(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      total:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}total']),
      shop: stringType.mapFromDatabaseResponse(data['${effectivePrefix}shop']),
      category: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
      items:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}items']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || total != null) {
      map['total'] = Variable<String>(total);
    }
    if (!nullToAbsent || shop != null) {
      map['shop'] = Variable<String>(shop);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || items != null) {
      map['items'] = Variable<String>(items);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      total:
          total == null && nullToAbsent ? const Value.absent() : Value(total),
      shop: shop == null && nullToAbsent ? const Value.absent() : Value(shop),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      items:
          items == null && nullToAbsent ? const Value.absent() : Value(items),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory Receipt.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Receipt(
      id: serializer.fromJson<int>(json['id']),
      total: serializer.fromJson<String>(json['total']),
      shop: serializer.fromJson<String>(json['shop']),
      category: serializer.fromJson<String>(json['category']),
      items: serializer.fromJson<String>(json['items']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'total': serializer.toJson<String>(total),
      'shop': serializer.toJson<String>(shop),
      'category': serializer.toJson<String>(category),
      'items': serializer.toJson<String>(items),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Receipt copyWith(
          {int id,
          String total,
          String shop,
          String category,
          String items,
          DateTime date}) =>
      Receipt(
        id: id ?? this.id,
        total: total ?? this.total,
        shop: shop ?? this.shop,
        category: category ?? this.category,
        items: items ?? this.items,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Receipt(')
          ..write('id: $id, ')
          ..write('total: $total, ')
          ..write('shop: $shop, ')
          ..write('category: $category, ')
          ..write('items: $items, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          total.hashCode,
          $mrjc(
              shop.hashCode,
              $mrjc(
                  category.hashCode, $mrjc(items.hashCode, date.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Receipt &&
          other.id == this.id &&
          other.total == this.total &&
          other.shop == this.shop &&
          other.category == this.category &&
          other.items == this.items &&
          other.date == this.date);
}

class ReceiptsCompanion extends UpdateCompanion<Receipt> {
  final Value<int> id;
  final Value<String> total;
  final Value<String> shop;
  final Value<String> category;
  final Value<String> items;
  final Value<DateTime> date;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.total = const Value.absent(),
    this.shop = const Value.absent(),
    this.category = const Value.absent(),
    this.items = const Value.absent(),
    this.date = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    this.id = const Value.absent(),
    @required String total,
    @required String shop,
    @required String category,
    this.items = const Value.absent(),
    @required DateTime date,
  })  : total = Value(total),
        shop = Value(shop),
        category = Value(category),
        date = Value(date);
  static Insertable<Receipt> custom({
    Expression<int> id,
    Expression<String> total,
    Expression<String> shop,
    Expression<String> category,
    Expression<String> items,
    Expression<DateTime> date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (total != null) 'total': total,
      if (shop != null) 'shop': shop,
      if (category != null) 'category': category,
      if (items != null) 'items': items,
      if (date != null) 'date': date,
    });
  }

  ReceiptsCompanion copyWith(
      {Value<int> id,
      Value<String> total,
      Value<String> shop,
      Value<String> category,
      Value<String> items,
      Value<DateTime> date}) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      total: total ?? this.total,
      shop: shop ?? this.shop,
      category: category ?? this.category,
      items: items ?? this.items,
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
      map['total'] = Variable<String>(total.value);
    }
    if (shop.present) {
      map['shop'] = Variable<String>(shop.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (items.present) {
      map['items'] = Variable<String>(items.value);
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
          ..write('shop: $shop, ')
          ..write('category: $category, ')
          ..write('items: $items, ')
          ..write('date: $date')
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

  final VerificationMeta _totalMeta = const VerificationMeta('total');
  GeneratedTextColumn _total;
  @override
  GeneratedTextColumn get total => _total ??= _constructTotal();
  GeneratedTextColumn _constructTotal() {
    return GeneratedTextColumn(
      'total',
      $tableName,
      false,
    );
  }

  final VerificationMeta _shopMeta = const VerificationMeta('shop');
  GeneratedTextColumn _shop;
  @override
  GeneratedTextColumn get shop => _shop ??= _constructShop();
  GeneratedTextColumn _constructShop() {
    return GeneratedTextColumn(
      'shop',
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

  final VerificationMeta _itemsMeta = const VerificationMeta('items');
  GeneratedTextColumn _items;
  @override
  GeneratedTextColumn get items => _items ??= _constructItems();
  GeneratedTextColumn _constructItems() {
    return GeneratedTextColumn(
      'items',
      $tableName,
      true,
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

  @override
  List<GeneratedColumn> get $columns =>
      [id, total, shop, category, items, date];
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
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total'], _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('shop')) {
      context.handle(
          _shopMeta, shop.isAcceptableOrUnknown(data['shop'], _shopMeta));
    } else if (isInserting) {
      context.missing(_shopMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category'], _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('items')) {
      context.handle(
          _itemsMeta, items.isAcceptableOrUnknown(data['items'], _itemsMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
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
