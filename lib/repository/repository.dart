import 'package:receipt_parser/database/receipt_database.dart';

class Repository {
  ReceiptDao _dao = ReceiptDao(AppDatabase());

  Future<List<Receipt>> getReceipts() => _dao.getReceipts();

  Stream<List<Receipt>> watchReceipts() => _dao.watchReceipts();

  Future insertReceipt(ReceiptsCompanion receipt) =>
      _dao.insertReceipt(receipt);

  Future updateReceipt(Receipt receipt) => _dao.updateReceipt(receipt);

  Future deleteReceipt(Receipt receipt) => _dao.deleteReceipt(receipt);

  Future deleteDatabase() => _dao.deleteDatabase();
}
