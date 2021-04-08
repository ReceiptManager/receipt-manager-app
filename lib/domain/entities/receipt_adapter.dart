import 'package:hive/hive.dart';
import 'package:receipt_manager/domain/entities/category.dart';

part 'receipt_adapter.g.dart';

@HiveType(typeId: 0)
class Receipt {
  @HiveField(0)
  final Store store;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final Price total;

  @HiveField(3)
  final String tag;

  @HiveField(4)
  final ReceiptCategory category;

  @HiveField(5)
  final List<ReceiptItem> items;

  Receipt(
      this.store, this.date, this.total, this.tag, this.category, this.items);
}

class ReceiptItem {
  final String itemName;

  final Price price;

  ReceiptItem(this.itemName, this.price);
}

class Store {
  final String storeName;

  Store(this.storeName);
}

class Price {
  final double total;

  final String currency;

  Price(this.total, this.currency);
}
