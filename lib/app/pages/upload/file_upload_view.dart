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

import 'dart:core';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:receipt_manager/app/pages/upload/upload_controller.dart';
import 'package:receipt_manager/app/widgets/padding/padding_widget.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';

// ignore: must_be_immutable
class FileUploadPage extends View {
  PlatformFile file;

  FileUploadPage(this.file);

  @override
  State<StatefulWidget> createState() => FileUploadState(this.file);
}

class FileUploadState extends ViewState<FileUploadPage, UploadController> {
  PlatformFile file;

  FileUploadState(this.file) : super(UploadController(DataReceiptRepository()));

  Widget submitButton(UploadController controller) => PaddingWidget(
          widget: Align(
        alignment: Alignment.bottomRight,
        child: NeumorphicButton(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.stadium(),
            ),
            child:
                Text("Upload", style: TextStyle(fontWeight: FontWeight.bold))),
      ));

  @override
  Widget get view => Scaffold(
      key: globalKey,
      backgroundColor: Colors.white,
      appBar: NeumorphicAppBar(title: Text("Show Image")),
      body: ControlledWidgetBuilder<UploadController>(
          builder: (context, controller) {
        return Column(children: [submitButton(controller)]);
      }));
}
