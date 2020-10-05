import 'package:moor/moor.dart';

class Receipts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get receiptTotal => text()();

  TextColumn get shopName => text()();

  TextColumn get category => text()();

  DateTimeColumn get receiptDate => dateTime().nullable()();
}
