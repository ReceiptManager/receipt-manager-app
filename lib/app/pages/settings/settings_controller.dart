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
import 'package:hive/hive.dart';
import 'package:receipt_manager/app/constants.dart';
import 'package:receipt_manager/app/pages/settings/api_token/api_token_view.dart';
import 'package:receipt_manager/app/pages/settings/server/server_view.dart';
import 'package:receipt_manager/app/pages/settings/settings_presenter.dart';

class SettingsController extends Controller {
  final SettingsPresenter _settingsPresenter;

  bool _rotateImage = false;
  bool _gaussianBlur = false;
  bool _grayscaleImage = false;
  bool _neuronalNetworkParser = false;
  bool _https = false;
  bool _legacyParser = false;
  bool _trainingData = false;
  bool _debugOutput = false;
  bool _showArticles = false;
  bool _lightTheme = false;

  var settingsBox;

  SettingsController()
      : _settingsPresenter = SettingsPresenter(),
        settingsBox = Hive.box('settings'),
        super();

  get rotateImage => _rotateImage;

  get grayscaleImage => _grayscaleImage;

  get gaussianBlur => _gaussianBlur;

  get neuronalNetworkParser => _neuronalNetworkParser;

  get https => _https;

  get legacyParser => _legacyParser;

  get sendTrainingData => _trainingData;

  get debugOutput => _debugOutput;

  get showArticles => _showArticles;

  get lightTheme => _lightTheme;

  @override
  void initListeners() {
    readValues();
  }

  readValues() {
    _rotateImage = settingsBox.get(verticalImage, defaultValue: false);
    _debugOutput = settingsBox.get(enableDebugOutput, defaultValue: false);
    _https = settingsBox.get(enableHttps, defaultValue: true);
    _gaussianBlur = settingsBox.get(enableGaussianBlur, defaultValue: false);
    _grayscaleImage = settingsBox.get(enableGrayscale, defaultValue: true);
    _legacyParser = settingsBox.get(enableGrayscale, defaultValue: true);
    _neuronalNetworkParser =
        settingsBox.get(useNeuronalNetworkParser, defaultValue: true);
    _showArticles = settingsBox.get(enableShowArticles, defaultValue: true);
    _lightTheme = settingsBox.get(enableLightTheme, defaultValue: true);
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
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => ApiTokenPage()));
  }

  languageButtonPress(BuildContext context) {
    throw UnimplementedError();
  }

  toggleRotateImage(bool value) {
    settingsBox.put(verticalImage, value);
    _rotateImage = value;
    refreshUI();
  }

  toggleGrayscaleImage(bool value) {
    if (_gaussianBlur && value == false) {
      settingsBox.put(enableGaussianBlur, false);
      _gaussianBlur = false;
    }

    settingsBox.put(enableGrayscale, value);
    _grayscaleImage = value;
    refreshUI();
  }

  toggleGaussianBlur(bool value) {
    if (!_grayscaleImage) {
      settingsBox.put(enableGrayscale, true);
      _grayscaleImage = true;
    }

    settingsBox.put(enableGaussianBlur, value);
    _gaussianBlur = value;
    refreshUI();
  }

  toggleNeuronalNetworkParser(bool value) {
    settingsBox.put(useNeuronalNetworkParser, value);
    _neuronalNetworkParser = value;
    refreshUI();
  }

  serverButtonPress(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ServerSettingsPage()));
  }

  toggleLegacyParser(bool value) {
    settingsBox.put(useLegacyParser, value);
    _legacyParser = value;
    refreshUI();
  }

  toggleTrainingData(bool value) {
    settingsBox.put(enableTrainingData, value);
    _trainingData = value;
    refreshUI();
  }

  toggleDebugOutput(bool value) {
    settingsBox.put(enableDebugOutput, value);
    _debugOutput = value;
    refreshUI();
  }

  toggleHttps(bool value) {
    settingsBox.put(enableHttps, value);
    _https = value;
    refreshUI();
  }

  toggleShowArticles(bool value) {
    settingsBox.put(enableShowArticles, value);
    _showArticles = value;
    refreshUI();
  }

  toggleLightTheme(bool value) {
    settingsBox.put(enableLightTheme, value);
    _lightTheme = value;
  }
}
