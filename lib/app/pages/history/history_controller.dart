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
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:receipt_manager/app/pages/history/history_presenter.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';
import 'package:receipt_manager/data/storage/scheme/holder_table.dart';

class HistoryController extends Controller {
  final HistoryPresenter _historyPresenter;

  DataReceiptRepository repository;

  HistoryController(DataReceiptRepository repository)
      : _historyPresenter = HistoryPresenter(repository),
        this.repository = repository,
        super();

  Stream<List<ReceiptHolder>> getReceipts() {
    return repository.getReceipts();
  }

  void deleteMethod(ReceiptHolder receipt) async {
    await repository.deleteReceipt(receipt);
  }

  void editMethod(ReceiptHolder receipt, BuildContext context) async {}

  Future<Image?> imageExists(String path) async {
    try {
      final bundle = DefaultAssetBundle.of(getContext());
      await bundle.load(path);
    } catch (e) {
      return null;
    }

    return Image.asset(
      path,
      fit: BoxFit.fill,
    );
  }

  Future<Image?> getAssetImage(String storeName, String categoryName) async {
    String storeNamePath =
        "assets/" + storeName.split(" ")[0].trim().toLowerCase();

    List<String> extensions = [".png", ".jpeg", ".jpg"];
    for (var ext in extensions) {
      final String path = storeNamePath + ext;
      Image? image = await imageExists(path);
      if (image != null) return image;
    }

    return await imageExists("assets/fallback.png");
  }

  @override
  void initListeners() {}

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
