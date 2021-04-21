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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:receipt_manager/app/pages/settings/server/server_controller.dart';
import 'package:receipt_manager/app/widgets/padding/padding_widget.dart';
import 'package:receipt_manager/app/widgets/textfield/simple_textfield.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';

class ServerSettingsPage extends View {
  @override
  State<StatefulWidget> createState() => ServerSettingsState();
}

class ServerSettingsState
    extends ViewState<ServerSettingsPage, ServerSettingsController> {
  ServerSettingsState()
      : super(ServerSettingsController(DataReceiptRepository()));

  Widget apiTextField(ServerSettingsController controller) => PaddingWidget(
          widget: SimpleTextfieldWidget(
        controller: controller.serverSettingController,
        hintText: "Server Address",
        labelText: "Server Address",
        helperText: "The Server Address",
        validator: (value) => controller.validateServerAddress(value),
        icon: Icon(Icons.wifi),
        readOnly: false,
      ));

  Widget submitButton(ServerSettingsController controller) => PaddingWidget(
          widget: Align(
        alignment: Alignment.centerRight,
        child: NeumorphicButton(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.stadium(),
            ),
            onPressed: controller.submitServerController,
            child:
                Text("Submit", style: TextStyle(fontWeight: FontWeight.bold))),
      ));

  @override
  Widget get view => Scaffold(
      key: globalKey,
      backgroundColor: Colors.white,
      appBar: NeumorphicAppBar(title: Text("Server Settings")),
      body: ControlledWidgetBuilder<ServerSettingsController>(
          builder: (context, controller) {
        return Form(
            key: controller.formKey,child:Column(
            children: [apiTextField(controller), submitButton(controller)]));
      }));
}
