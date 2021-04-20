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
import 'package:receipt_manager/app/pages/stats/stat_presenter.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';

// TODO: implement settings controller
class StatsController extends Controller {
  final StatsPresenter _statsPresenter;
  DataReceiptRepository repository;

  StatsController(DataReceiptRepository repository)
      : _statsPresenter = StatsPresenter(),
        this.repository = repository,
        super();

  @override
  void initListeners() {
    // TODO: implement initListeners
  }

  get receipts {
    var receipts = repository.getReceipts();
    return receipts;
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
    _statsPresenter.dispose();
    super.onDisposed();
  }
}
