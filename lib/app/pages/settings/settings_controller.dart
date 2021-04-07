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

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:receipt_manager/app/pages/settings/settings_presenter.dart';

// TODO: implement settings controller
class SettingsController extends Controller {
  final SettingsPresenter _settingsPresenter;

  String _currency;

  String get currency => _currency;

  bool _rotateImage;
  bool _gaussianBlur;
  bool _grayscaleImage;
  bool _neuronalNetworkParser;
  bool _https;
  bool _legacyParser;
  bool _trainingData;
  bool _debugOutput;
  bool _showAricles;
  bool _showOpenSourceLicences;

  SettingsController()
      : _settingsPresenter = SettingsPresenter(),
        super();

  get rotateImage => _rotateImage;

  get grayscaleImage => _grayscaleImage;

  get gaussianBlur => _gaussianBlur;

  get neuronalNetworkParser => _neuronalNetworkParser;

  get https => _https;

  get legacyParser => _legacyParser;

  get sendTrainingData => _trainingData;

  get debugOutput => _debugOutput;

  get showArticles => _showAricles;

  get showOpenSourceLicences => _showOpenSourceLicences;

  @override
  void initListeners() {
    // TODO: implement initListeners
  }

  @override
  void onResumed() => print('On resumed');

  @override
  void onReassembled() => print('View is about to be reassembled');

  @override
  void onDeactivated() => print('View is about to be deactivated');

  @override
  void onDisposed() {
    _settingsPresenter.dispose();
    super.onDisposed();
  }

  apiTokenButtonPress(BuildContext context) {
    throw UnimplementedError();
  }

  languageButtonPress(BuildContext context) {
    throw UnimplementedError();
  }

  detectReceiptServerButtonPress(BuildContext context) {
    throw UnimplementedError();
  }

  toggleRotateImage(bool value) {
    throw UnimplementedError();
  }

  toggleGrayscaleImage(bool value) {
    throw UnimplementedError();
  }

  toggleGaussianBlur(bool value) {
    throw UnimplementedError();
  }

  toggleNeuronalNetworkParser(bool value) {
    throw UnimplementedError();
  }

  serverButtonPress(BuildContext context) {
    throw UnimplementedError();
  }

  toggleLegacyParser(bool value) {
    throw UnimplementedError();
  }

  toggleTrainingData(bool value) {
    throw UnimplementedError();
  }

  toggleDebugOutput(bool val) {
    throw UnimplementedError();
  }

  toggleHttps(bool value) {
    throw UnimplementedError();
  }

  toggleShowArticles(bool value) {
    throw UnimplementedError();
  }

  toggleOpenSourceLicences(BuildContext context) {
    throw UnimplementedError();
  }
}
