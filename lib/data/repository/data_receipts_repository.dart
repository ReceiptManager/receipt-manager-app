import 'package:receipt_manager/data/storage/receipt_database.dart';
import 'package:receipt_manager/data/storage/scheme/holder_table.dart';
import 'package:receipt_manager/domain/repository/abstract_repository.dart';

class DataReceiptRepository extends ReceiptRepository {
  static final DataReceiptRepository _instance =
      DataReceiptRepository._internal();

  DataReceiptRepository._internal();

  factory DataReceiptRepository() => _instance;

  ReceiptDao _dao = ReceiptDao(AppDatabase());

  Stream<List<Receipt>> watchReceipts() => _dao.watchReceipts();

  Future insertReceipt(ReceiptsCompanion receipt) =>
      _dao.insertReceipt(receipt);

  Future updateReceipt(Receipt receipt) => _dao.updateReceipt(receipt);

  Future deleteReceipt(Receipt receipt) => _dao.deleteReceipt(receipt);

  Future deleteDatabase() => _dao.deleteDatabase();

  @override
  Stream<List<ReceiptHolder>> getReceipts() => _dao.getReceipts();
}
