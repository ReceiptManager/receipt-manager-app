/*
 * Copyright (c) 2020 - William Todt
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:receipt_parser/database/receipt_database.dart';

class Repository {
  ReceiptDao _dao = ReceiptDao(AppDatabase());

  Future<List<Receipt>> getReceipts() => _dao.getReceipts();

  Stream<List<Receipt>> watchReceipts() => _dao.watchReceipts();

  Future insertReceipt(ReceiptsCompanion receipt) =>
      _dao.insertReceipt(receipt);

  Future updateReceipt(Receipt receipt) => _dao.updateReceipt(receipt);

  Future deleteReceipt(Receipt receipt) => _dao.deleteReceipt(receipt);

  Future deleteDatabase() => _dao.deleteDatabase();
}
