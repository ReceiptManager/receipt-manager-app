import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get shopName => text()();

  TextColumn get total => text()();

  TextColumn get category => text()();

  DateTimeColumn get date => dateTime()();
}

@UseMoor(tables: [Orders])
class AppDatabase {}
