import 'package:hive/hive.dart';
import 'package:receipt_manager/domain/entities/receipt_adapter.dart';
import 'package:receipt_manager/domain/repository/abstract_repository.dart';

class DataReceiptRepository extends ReceiptRepository {
  var receiptBox;
  List<Receipt> receipts = [];

  static final DataReceiptRepository _instance =
      DataReceiptRepository._internal();
  DataReceiptRepository._internal() {
    receipts = <Receipt>[];
    receiptBox = Hive.box('receipts');
  }

  factory DataReceiptRepository() => _instance;

  @override
  Future<List<Receipt>> getReceipts() async {
    return receiptBox.get();
  }
}
