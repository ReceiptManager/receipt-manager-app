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

import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:hive/hive.dart';
import 'package:receipt_manager/app/constants.dart';
import 'package:receipt_manager/app/helper/notfifier.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';
import 'package:receipt_manager/data/storage/scheme/insert_holder_table.dart';

import 'upload.dart';

class UploadController extends Controller {
  final UploadPresenter _historyPresenter;
  final Box<dynamic> settingsBox;

  bool _rotateImage = false;
  bool _https = true;
  bool _gaussianBlur = false;
  bool _grayscaleImage = true;
  bool? _reverseProxy;
  String? _address;
  String? _token;

  DataReceiptRepository repository;

  UploadController(DataReceiptRepository repository)
      : _historyPresenter = UploadPresenter(repository),
        this.repository = repository,
        settingsBox = Hive.box('settings'),
        super();

  @override
  void initListeners() {
    _rotateImage = settingsBox.get(verticalImage, defaultValue: false);
    _https = settingsBox.get(enableHttps, defaultValue: true);
    _gaussianBlur = settingsBox.get(enableGaussianBlur, defaultValue: false);
    _grayscaleImage = settingsBox.get(enableGrayscale, defaultValue: true);
    _reverseProxy = settingsBox.get(reverseProxyField);
    _token = settingsBox.get(apiTokenField);
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

  Future<InsertReceiptHolder?> send(File image) async {
    try {
      await FlutterUploader().enqueue(
        MultipartFormDataUpload(
          url:
              "${_https ? "https" : "http"}://${_reverseProxy! ? "www." : ""}$_address${_reverseProxy! ? "" : ":8721"}/api/upload?access_token=$_token&grayscale_image=$_grayscaleImage&gaussian_blur=$_gaussianBlur&rotate=$_rotateImage",
          files: [FileItem(path: image.path, field: "file")],
          method: UploadMethod.POST,
        ),
      );
    } catch (e) {
      UserNotifier.fail("Failed to upload receipt", getContext());
    }

    FlutterUploader().progress.listen((progress) async {
      var notification = await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 1,
              channelKey: 'receipt_manager_channel',
              title: "Upload receipt",
              notificationLayout: NotificationLayout.ProgressBar,
              progress: progress.progress,
              locked: true));

      if (progress.progress == 100) {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                channelKey: 'receipt_manager_channel',
                id: 1,
                locked: false,
                color: Colors.red,
                title: "Kassenbeleg wurde erfolgreich hochgeladen"));
      }
    });
  }

  bool validArguments() {
    if (_reverseProxy == null) return false;
    if (_token == null) return false;

    _address = settingsBox.get(_reverseProxy! ? serverDomain : serverIP);
    if (_address == null) return false;

    return true;
  }

  void sendReceipt(File image) async {
    await FlutterUploader().cancelAll();
    await FlutterUploader().clearUploads();
    if (!validArguments()) return;
    await send(image);
    Navigator.pop(getContext());
  }
}
