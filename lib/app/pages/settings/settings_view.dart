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
import 'package:receipt_manager/app/pages/settings/settings_controller.dart';

class SettingsPage extends View {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends ViewState<SettingsPage, SettingsController> {
  _SettingsState() : super(SettingsController());

  /*
   ControlledWidgetBuilder<SettingsController>(
          builder: (context, controller) => SettingsList(
                key: globalKey,
                shrinkWrap: true,
                backgroundColor: Colors.white,
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
                          title: "Rotate image",
                          leading: Icon(Icons.rotate_right_sharp),
                          switchValue: controller.rotateImage,
                          onToggle: (bool value) =>
                              controller.toggleRotateImage(value)),
                      SettingsTile.switchTile(
                          title: "Grayscale image",
                          leading: Icon(Icons.wb_incandescent_outlined),
                          switchValue: controller.grayscaleImage,
                          onToggle: (bool value) =>
                              controller.toggleGrayscaleImage(value)),
                      SettingsTile.switchTile(
                          title: "Gaussian Blur",
                          leading: Icon(Icons.blur_on_outlined),
                          switchValue: controller.gaussianBlur,
                          onToggle: (bool value) =>
                              controller.toggleGaussianBlur(value)),
                      SettingsTile.switchTile(
                          title: "Neuronal network parser",
                          leading: Icon(Icons.camera_enhance_outlined),
                          switchValue: controller.neuronalNetworkParser,
                          onToggle: (bool value) =>
                              controller.toggleNeuronalNetworkParser(value)),
                      SettingsTile.switchTile(
                          title: "Fuzzy parser",
                          leading: Icon(Icons.camera_enhance_rounded),
                          switchValue: controller.legacyParser,
                          onToggle: (bool value) =>
                              controller.toggleLegacyParser(value)),
                      SettingsTile.switchTile(
                          title: "Send training data",
                          leading: Icon(Icons.model_training),
                          switchValue: controller.sendTrainingData,
                          onToggle: (bool value) =>
                              controller.toggleTrainingData(value))
                    ],
                  ),
                  SettingsSection(
                    title: "Developer settings",
                    tiles: [
                      SettingsTile.switchTile(
                          title: "Enable debug output",
                          leading: Icon(Icons.bug_report),
                          switchValue: controller.debugOutput,
                          onToggle: (bool value) =>
                              controller.toggleDebugOutput(value)),
                      SettingsTile.switchTile(
                          title: "Show articles",
                          leading: Icon(Icons.category),
                          switchValue: controller.showArticles,
                          onToggle: (bool value) =>
                              controller.toggleShowArticles(value)),
                    ],
                  ),
                  SettingsSection(
                    title: "Open-Source Licenses",
                    tiles: [
                      SettingsTile(
                          title: "Show Open-Source Licenses",
                          leading: Icon(Icons.wysiwyg),
                          onPressed:
                              controller.toggleOpenSourceLicences(context)),
                    ],
                  )
                ],
              )));
   */
  @override
  Widget get view => Scaffold(
      key: globalKey,
      body: ControlledWidgetBuilder<SettingsController>(
          builder: (context, controller) => Container()));
}
