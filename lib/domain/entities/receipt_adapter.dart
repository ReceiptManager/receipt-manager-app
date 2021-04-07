import 'package:hive/hive.dart';
import 'package:receipt_manager/domain/entities/category.dart';

part 'receipt_adapter.g.dart';

@HiveType(typeId: 0)
class Receipt {
  @HiveField(0)
  final String storeName;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final double total;

  @HiveField(3)
  final String tag;

  @HiveField(4)
  final ReceiptCategory category;

  Receipt(this.storeName, this.date, this.total, this.tag, this.category);
}
