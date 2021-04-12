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
import 'package:receipt_manager/app/pages/home/home_controller.dart';
import 'package:receipt_manager/app/widgets/form/input_form.dart';
import 'package:receipt_manager/data/repository/app_repository.dart';

class HomePage extends View {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ViewState<HomePage, HomeController> {
  _HomePageState() : super(HomeController(AppRepository()));

  @override
  Widget get view => Material(
      child: Scaffold(
          key: globalKey,
          backgroundColor: Color(0xFFEFEFF4),
          appBar: NeumorphicAppBar(
            title: Text("Add receipt"),
            actions: <Widget>[
              Center(
                child: NeumorphicButton(
                  style: NeumorphicStyle(
                    color: Color(0xFFEFEFF4),
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.camera_alt_outlined,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: InputForm()));
}
