/*
 * Copyright (c) 2020 - 2021 : William Todt
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:receipt_manager/data/storage/receipt_database.dart';
import 'package:receipt_manager/domain/repository/abstract_receipt_repository.dart';

class ReceiptRepository extends AbstractReceiptRepository {
  List<Receipt> receipts;

  static final ReceiptRepository _instance = ReceiptRepository._internal();

  ReceiptRepository._internal();

  factory ReceiptRepository() => _instance;

  @override
  Future<Receipt> getReceipt(int id) {
    // TODO: implement getReceipt
    throw UnimplementedError();
  }

  @override
  Future<List<Receipt>> getReceipts() {
    // TODO: implement getReceipts
    throw UnimplementedError();
  }
}
