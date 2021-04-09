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
import 'package:receipt_manager/app/widgets/banner_widget.dart';
import 'package:receipt_manager/app/widgets/floating_button.dart';
import 'package:receipt_manager/app/widgets/padding_widget.dart';
import 'package:receipt_manager/app/widgets/simple_textfield.dart';
import 'package:receipt_manager/data/repository/app_repository.dart';

class HomePage extends View {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ViewState<HomePage, HomeController> {
  _HomePageState() : super(HomeController(AppRepository()));

  Widget storeNameTextField(BuildContext context) =>
      ControlledWidgetBuilder<HomeController>(builder: (context, controller) {
        return SimpleTextfieldWidget(
            controller: controller.storeNameController,
            hintText: "Store Name",
            labelText: "Store Name",
            helperText: "The receipt store name",
            validator: controller.validateStoreName,
            icon: Icon(Icons.store_mall_directory_outlined));
      });

  Widget tagTextField(BuildContext context) =>
      PaddingWidget(widget: ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
        return SimpleTextfieldWidget(
            controller: controller.receiptTagController,
            hintText: "Receipt Tag",
            labelText: "Receipt Tag",
            helperText: "The receipt tag",
            validator: (value) => null,
            icon: Icon(Icons.tag));
      }));

  Widget totalTextField(BuildContext context) =>
      PaddingWidget(widget: ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
        return SimpleTextfieldWidget(
          controller: controller.receiptTotalController,
          hintText: "Receipt Total",
          labelText: "Receipt Total",
          helperText: "The receipt total",
          icon: IconButton(
              icon: Icon(Icons.monetization_on_outlined),
              onPressed: () => controller.currencyPicker(context)),
          validator: controller.validateTotal,
        );
      }));

  Widget dateTextField(BuildContext context) =>
      PaddingWidget(widget: ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
        return SimpleTextfieldWidget(
          controller: controller.receiptDateController,
          hintText: "Receipt Date",
          labelText: "Receipt Date",
          helperText: "The receipt date",
          icon: Icon(Icons.date_range),
          validator: controller.validateDate,
        );
      }));

  Widget banner() => BannerWidget(
        text: "Add Receipt",
      );

  Widget submitButton(BuildContext context) =>
      ControlledWidgetBuilder<HomeController>(builder: (context, controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: new Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingButton(
                        text: "Submit",
                        controller: controller,
                      ))),
            )
          ],
        );
      });

  @override
  Widget get view => Scaffold(
      key: globalKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: ControlledWidgetBuilder<HomeController>(
              builder: (context, controller) => Form(
                    key: controller.formKey,
                    child: Column(
                      children: <Widget>[
                        banner(),
                        storeNameTextField(context),
                        totalTextField(context),
                        dateTextField(context),
                        tagTextField(context),
                        submitButton(context)
                      ],
                    ),
                  ))));
}
