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

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:receipt_manager/app/pages/history/history_presenter.dart';
import 'package:receipt_manager/domain/entities/category.dart';
import 'package:receipt_manager/domain/entities/receipt_adapter.dart';

// TODO: implement settings controller
class HistoryController extends Controller {
  final HistoryPresenter _historyPresenter;

  HistoryController()
      : _historyPresenter = HistoryPresenter(),
        super();

  String get getWeeklyOverview => "Weekly overview 19.00\$";

  get getReceipts {
    Price price = Price(19.00, "\$");
    ReceiptCategory category = ReceiptCategory("Test", null);
    ReceiptItem item = ReceiptItem("Item", price);
    List<ReceiptItem> items = [];
    items.add(item);

    List<Receipt> receipts = [];
    Receipt receipt =
        Receipt("TestStore", DateTime.now(), price, "tag", category, items);

    receipts.add(receipt);
    receipts.add(receipt);
    receipts.add(receipt);
    receipts.add(receipt);
    receipts.add(receipt);

    return receipts;
  }

  get deleteMethod => null;

  get editMethod => null;

  @override
  void initListeners() {
    // TODO: implement initListeners
  }

  void buttonPressed() {}

  @override
  void onResumed() => print('On resumed');

  @override
  void onReassembled() => print('View is about to be reassembled');

  @override
  void onDeactivated() => print('View is about to be deactivated');

  @override
  void onDisposed() {
    _historyPresenter.dispose();
    super.onDisposed();
  }
}
