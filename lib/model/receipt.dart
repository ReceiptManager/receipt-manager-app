import 'package:moor/moor.dart';

class Receipts extends Table {
  TextColumn get receiptTotal => text()();

  TextColumn get shopName => text()();

  TextColumn get category => text()();

  DateTimeColumn get receiptDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {receiptDate};
}
