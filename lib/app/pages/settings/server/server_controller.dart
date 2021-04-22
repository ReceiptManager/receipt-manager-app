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
import 'package:receipt_manager/app/constants.dart';
import 'package:receipt_manager/app/helper/notfifier.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';

import 'server_presenter.dart';

class ServerSettingsController extends Controller {
  final ServerSettingsPresenter _historyPresenter;
  final DataReceiptRepository repository;
  final Box<dynamic> settingsBox;
  final _formKey = GlobalKey<FormState>();

  final RegExp urlRegex = new RegExp(
      "^((?!-))(xn--)?[a-z0-9][a-z0-9-_]{0,61}[a-z0-9]{0,1}.(xn--)?([a-z0-9-]{1,61}|[a-z0-9-]{1,30}.[a-z]{2,})\$",
      caseSensitive: false,
      multiLine: false);

  final RegExp ipRegex = new RegExp(
      "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\$",
      caseSensitive: false,
      multiLine: false);

  ServerSettingsController(DataReceiptRepository repository)
      : _historyPresenter = ServerSettingsPresenter(repository),
        this.repository = repository,
        settingsBox = Hive.box('settings'),
        super();

  TextEditingController _serverSettingController = TextEditingController();

  TextEditingController get serverSettingController => _serverSettingController;

  get formKey => _formKey;

  @override
  void initListeners() {
    bool? reverseProxy = settingsBox.get(reverseProxyField);
    if (reverseProxy == null) return null;

    _serverSettingController.text =
        settingsBox.get(reverseProxy ? serverDomain : serverIP);
  }

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

  void submitServerController() {
    if (!_formKey.currentState!.validate()) {
      UserNotifier.fail("API token is invalid", getContext());
      refreshUI();
      return;
    }

    String serverAddress = serverSettingController.text.trim();
    print(serverAddress);

    if (ipRegex.hasMatch(serverAddress)) {
      settingsBox.put(serverDomain, serverAddress);
      settingsBox.put(reverseProxyField, false);
      print("Use domain");
    } else {
      settingsBox.put(serverIP, serverAddress);
      settingsBox.put(reverseProxyField, true);
      print("Use IP");
    }

    UserNotifier.success("Server IP is valid", getContext());
    refreshUI();
  }

  validateServerAddress(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Api token is empty";
    }

    if (!ipRegex.hasMatch(value) && !urlRegex.hasMatch(value))
      return "Api token is invalid";

    return null;
  }
}
