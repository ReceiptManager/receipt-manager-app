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
import 'package:hive/hive.dart';
import 'package:receipt_manager/app/helper/notfifier.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';

import '../../../constants.dart';
import 'api_token_presenter.dart';

class ApiTokenController extends Controller {
  final ApiTokenPresenter _historyPresenter;
  final _formKey = GlobalKey<FormState>();
  final settingsBox;

  DataReceiptRepository repository;

  ApiTokenController(DataReceiptRepository repository)
      : _historyPresenter = ApiTokenPresenter(repository),
        this.repository = repository,
        settingsBox = Hive.box('settings'),
        super();

  TextEditingController _apiTokenController = TextEditingController();

  TextEditingController get apiTokenController => _apiTokenController;

  get formKey => _formKey;

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

  void submitApiToken() {
    if (!_formKey.currentState!.validate()) {
      UserNotifier.fail("API token is invalid", getContext());
      refreshUI();
      return;
    }

    String _apiToken = apiTokenController.text.trim();

    settingsBox.put(apiTokenField, _apiToken);
    UserNotifier.success("API token is valid", getContext());
    refreshUI();
  }

  validateApiToken(value) {
    value = value.trim();

    if (value.isEmpty()) {
      return "Api token is invalid";
    }

    return null;
  }
}
