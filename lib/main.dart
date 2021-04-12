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

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:receipt_manager/app/pages/navigator.dart';
import 'package:receipt_manager/domain/entities/receipt_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterCleanArchitecture.debugModeOn();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ReceiptAdapter());

  var settingsBox = await Hive.openBox('settings');
  var receiptsBox = await Hive.openBox('receipts');

  return runZonedGuarded(() async {
    runApp(ReceiptManagerApp());
  }, (error, stack) {
    print(stack);
    print(error);

    receiptsBox.close();
    settingsBox.close();
  });
}

class ReceiptManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box("settings").listenable(),
      builder: (context, box, widget) {
        return NeumorphicApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: NeumorphicThemeData(
                defaultTextColor: Color(0xFF303E57),
                accentColor: Colors.redAccent,
                variantColor: Colors.redAccent,
                baseColor: Color(0xFFF8F9FC),
                depth: 10,
                lightSource: LightSource.topRight),
            home: NavigatorPage());
      },
    );
  }
}
