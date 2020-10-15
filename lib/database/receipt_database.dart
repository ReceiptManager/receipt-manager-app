import 'package:moor_flutter/moor_flutter.dart';
import 'package:receipt_parser/model/receipt.dart';

part 'receipt_database.g.dart';

@UseMoor(tables: [Receipts], daos: [ReceiptDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sql", logStatements: true));

  int get schemaVersion => 1;
}

@UseDao(tables: [Receipts])
class ReceiptDao extends DatabaseAccessor<AppDatabase> with _$ReceiptDaoMixin {
  final AppDatabase db;

  ReceiptDao(this.db) : super(db);

  Future<List<Receipt>> getReceipts() {
    return (select(receipts)
      ..orderBy(([
            (t) =>
            OrderingTerm(
                expression: t.receiptDate, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.shopName),
      ])))
        .get();
  }

  Stream<List<Receipt>> watchReceipts() => select(receipts).watch();

  int max;

  Future insertReceipt(Receipt receipt) {
    if (receipt.id == max) {
      max = max + 1;
    }

    into(receipts).insert(receipt.copyWith(id: max));
  }

  Future updateReceipt(Receipt receipt) => update(receipts).replace(receipt);

  Future deleteReceipt(Receipt receipt) => delete(receipts).delete(receipt);


  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
        onCreate: (Migrator m) {
          return m.createAll();
        },
        beforeOpen: (details) async {
          List<Receipt> r = await (select(receipts)
            ..orderBy([
                  (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)
            ])).get();
          max = 0;
          if (r != null && r.isNotEmpty) {
            max = r.first.id;
          }
        }
    );
  }
}
