import 'package:moor_flutter/moor_flutter.dart';

class Stores extends Table {
  IntColumn get id => integer().autoIncrement()();

  @DataClassName("storeName")
  TextColumn get storeName => text()();
}
