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
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'home_controller.dart';

class HomePage extends View {
  @override
  // Dependencies can be injected here
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends ViewState<HomePage, HomeController> {
  HomeState() : super(HomeController());

  @override
  Widget get view => MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          key: globalKey,
          body: Column(
            children: <Widget>[
              Center(
                // show the number of times the button has been clicked
                child: ControlledWidgetBuilder<HomeController>(
                    builder: (context, controller) {
                  return Container();
                }),
              ),
              ControlledWidgetBuilder<HomeController>(
                  builder: (context, controller) {
                return Container();
              }),
            ],
          ),
        ),
      );
}
