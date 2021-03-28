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
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:io';

import 'package:receipt_manager/ui/settings/settings_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The [NetworkClientHolder] is used to store and update submitted
/// arguments submitted by the user.
///
/// All arguments get previously stored in shared preferences.
/// The NetworkClientHolder first read the options and submit them
/// to the network client.
class NetworkClientHolder {
  /// The image file name
  File imageFile;

  /// Receipt server ip
  String ip;

  /// Receipt server api token
  String token;

  /// Show debug output in alert boxes
  bool sendDebugOutput;

  /// Grayscale image
  bool grayscale;

  /// Apply gaussian filter to image
  bool gaussian;

  /// Use legacy parser to extract text
  bool legacyParser;

  /// Rotate image by 90°
  bool rotate;

  /// Show receipt article list
  bool showItemList;

  /// send via https
  bool https;

  /// specify domain
  String domain;

  /// use reverse proxy
  bool reverseProxy;

  /// use reverse proxy
  bool submitTrainingData;

  /// company name
  String company;

  /// receipt date
  String date;

  /// receipt total
  String total;

  static final NetworkClientHolder _networkClientHolder =
      NetworkClientHolder._internal();

  NetworkClientHolder._internal();

  factory NetworkClientHolder() {
    return _networkClientHolder;
  }

  void readOptions(SharedPreferences sharedPrefs) {
    sendDebugOutput = sharedPrefs.get(SharedPreferenceKeyHolder.enableDebug);
    legacyParser = sharedPrefs.getBool(SharedPreferenceKeyHolder.legacyParser);
    grayscale = sharedPrefs.getBool(SharedPreferenceKeyHolder.grayscale);
    gaussian = sharedPrefs.getBool(SharedPreferenceKeyHolder.gaussianBlur);
    rotate = sharedPrefs.getBool(SharedPreferenceKeyHolder.rotate);
    submitTrainingData = sharedPrefs.getBool(SharedPreferenceKeyHolder.sendTrainingData);
    showItemList = sharedPrefs.getBool(SharedPreferenceKeyHolder.showItemList);
    https = sharedPrefs.getBool(SharedPreferenceKeyHolder.https);
    reverseProxy = sharedPrefs.getBool(SharedPreferenceKeyHolder.reverseProxy);
    domain =  sharedPrefs.get(SharedPreferenceKeyHolder.domain);
    ip =  sharedPrefs.get(SharedPreferenceKeyHolder.ip);
    token =  sharedPrefs.get(SharedPreferenceKeyHolder.apiToken);
  }
}
