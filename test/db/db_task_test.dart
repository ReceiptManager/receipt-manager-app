/*
 *  Copyright (c) 2020 - William Todt
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:receipt_manager/database/receipt_database.dart';

void main() {
  AppDatabase database;
  ReceiptsCompanion companion;

  setUp(() {
    database = AppDatabase();
    companion = ReceiptsCompanion(
        id: Value(1),
        shop: Value("Rewe Supermarkt"),
        date: Value(DateTime.now()),
        category: Value("Grocery"),
        total: Value("23.00"));

    WidgetsFlutterBinding.ensureInitialized();
  });

  test('Test insert database', () async {
    await database.receiptDao.insertReceipt(companion);
    await database.receiptDao
        .getReceipts()
        .then((value) => expect(1, value.first.id));
  });
}
