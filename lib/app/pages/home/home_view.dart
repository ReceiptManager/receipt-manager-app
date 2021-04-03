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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:receipt_manager/app/pages/home/home_controller.dart';
import 'package:receipt_manager/app/widgets/autocomplete_textfield.dart';
import 'package:receipt_manager/app/widgets/banner_widget.dart';
import 'package:receipt_manager/app/widgets/simple_textfield.dart';

class HomePage extends View {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends ViewState<HomePage, HomeController> {
  HomeState() : super(HomeController());

  Widget textFieldPadding(Widget widget) =>
      Padding(padding: EdgeInsets.all(8.0), child: widget);

  Widget storeNameTextField(BuildContext context) =>
      textFieldPadding(ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
        return AutocompleteWidget(
            storeNameList: [],
            controller: null,
            hintText: "HintText",
            labelText: "StoreName",
            helperText: "HelperText",
            icon: Icon(Icons.store_mall_directory_outlined));
      }));

  Widget tagTextField(BuildContext context) =>
      textFieldPadding(ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
        return AutocompleteWidget(
            storeNameList: ["Test"],
            controller: null,
            hintText: "HintText",
            labelText: "Tag",
            helperText: "HelperText",
            icon: Icon(Icons.tag));
      }));

  Widget totalTextField(BuildContext context) =>
      textFieldPadding(ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
        return SimpleTextfieldWidget(
          controller: null,
          hintText: "HintText",
          labelText: "Tag",
          helperText: "HelperText",
          icon: Icon(Icons.monetization_on_outlined),
          validator: null,
        );
      }));

  Widget dateTextField(BuildContext context) =>
      textFieldPadding(ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
        return SimpleTextfieldWidget(
          controller: null,
          hintText: "HintText",
          labelText: "Date",
          helperText: "HelperText",
          icon: Icon(Icons.date_range),
          validator: null,
        );
      }));

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: Column(
          children: <Widget>[
            Center(
              child: ControlledWidgetBuilder<HomeController>(
                  builder: (context, controller) {
                return BannerWidget(
                  text: "Add receipts",
                );
              }),
            ),
            storeNameTextField(context),
            totalTextField(context),
            dateTextField(context),
            tagTextField(context)
          ],
        ),
      );
}
