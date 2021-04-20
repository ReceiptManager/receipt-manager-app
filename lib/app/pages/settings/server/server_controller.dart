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
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';

import 'server_presenter.dart';

class ServerSettingsController extends Controller {
  final ServerSettingsPresenter _historyPresenter;

  DataReceiptRepository repository;

  ServerSettingsController(DataReceiptRepository repository)
      : _historyPresenter = ServerSettingsPresenter(repository),
        this.repository = repository,
        super();

  TextEditingController _serverSettingController = TextEditingController();
  TextEditingController get serverSettingController => _serverSettingController;

  @override
  void initListeners() {}

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
