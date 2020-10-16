import 'package:moor/moor.dart';

class Receipts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get total => text()();

  TextColumn get shop => text()();

  TextColumn get category => text()();

  DateTimeColumn get date => dateTime()();
}
