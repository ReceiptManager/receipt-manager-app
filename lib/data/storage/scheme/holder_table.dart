import 'package:receipt_manager/data/storage/receipt_database.dart';

class ReceiptHolder {
  final Receipt receipt;
  final Store store;

  ReceiptHolder({required this.receipt, required this.store});
}
