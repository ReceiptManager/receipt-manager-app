import 'package:moor_flutter/moor_flutter.dart';

class Tags extends Table {
  TextColumn get tagName => text()();

  @override
  Set<Column> get primaryKey => {tagName};
}
