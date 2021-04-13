import 'package:moor_flutter/moor_flutter.dart';

class Categories extends Table {
  TextColumn get categoryName => text()();

  @override
  Set<Column> get primaryKey => {categoryName};
}
