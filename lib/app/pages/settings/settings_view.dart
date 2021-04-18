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
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:receipt_manager/app/pages/settings/settings_controller.dart';
import 'package:receipt_manager/app/widgets/padding/padding_widget.dart';
import 'package:receipt_manager/data/storage/receipt_database.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends View {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends ViewState<SettingsPage, SettingsController> {
  _SettingsState() : super(SettingsController());

  @override
  Widget get view => Material(
      color: Colors.white,
      child: ControlledWidgetBuilder<SettingsController>(
          builder: (context, controller) => Scaffold(
              backgroundColor: Colors.white,
              appBar: NeumorphicAppBar(title: Text("Settings")),
              key: globalKey,
              body: PaddingWidget(
                  widget: SettingsList(
                backgroundColor: Colors.white,
                shrinkWrap: true,
                sections: [
                  SettingsSection(
                    title: "Language Settings",
                    tiles: [
                      SettingsTile(
                          title: "Languages",
                          subtitle: "English",
                          leading: Icon(Icons.language),
                          onPressed: (context) =>
                              controller.languageButtonPress(context)),
                      SettingsTile(
                          title: "API token",
                          leading: Icon(Icons.vpn_key),
                          onPressed: controller.apiTokenButtonPress),
                    ],
                  ),
                  SettingsSection(title: "Network settings", tiles: [
                    SettingsTile(
                        title: "Detect receipt parser",
                        leading: Icon(Icons.adb),
                        onPressed: (context) =>
                            controller.detectReceiptServerButtonPress(context)),
                    SettingsTile(
                        title: "Server settings",
                        leading: Icon(Icons.wifi),
                        onPressed: (context) =>
                            controller.serverButtonPress(context)),
                    SettingsTile.switchTile(
                        title: "HTTPS",
                        leading: Icon(Icons.lock),
                        switchValue: controller.https,
                        onToggle: (bool value) => controller.toggleHttps(value))
                  ]),
                  SettingsSection(
                    title: "Camera settings",
                    tiles: [
                      SettingsTile.switchTile(
                          title: "Rotate Image",
                          leading: Icon(Icons.rotate_right_sharp),
                          switchValue: controller.rotateImage,
                          onToggle: (bool value) =>
                              controller.toggleRotateImage(value)),
                      SettingsTile.switchTile(
                          title: "Grayscale Image",
                          leading: Icon(Icons.wb_incandescent_outlined),
                          switchValue: controller.grayscaleImage,
                          onToggle: (bool value) =>
                              controller.toggleGrayscaleImage(value)),
                      SettingsTile.switchTile(
                          title: "Gaussian Blur",
                          leading: Icon(Icons.blur_on_outlined),
                          switchValue: controller.gaussianBlur,
                          onToggle: (bool value) =>
                              controller.toggleGaussianBlur(value))
                    ],
                  ),
                  SettingsSection(
                    title: "Developer settings",
                    tiles: [
                      SettingsTile.switchTile(
                          title: "Enable Debug Output",
                          leading: Icon(Icons.bug_report),
                          switchValue: controller.debugOutput,
                          onToggle: (bool value) =>
                              controller.toggleDebugOutput(value)),
                      SettingsTile.switchTile(
                          title: "Show Articles",
                          leading: Icon(Icons.category),
                          switchValue: controller.showArticles,
                          onToggle: (bool value) =>
                              controller.toggleShowArticles(value)),
                      SettingsTile(
                          title: "Database utils",
                          leading: Icon(Icons.developer_board),
                          onPressed: (context) {
                            final db = AppDatabase();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MoorDbViewer(db)));
                          })
                    ],
                  ),
                ],
              )))));
}
