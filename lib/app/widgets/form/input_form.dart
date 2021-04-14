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
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:receipt_manager/app/pages/home/home_controller.dart';
import 'package:receipt_manager/app/widgets/padding/padding_widget.dart';
import 'package:receipt_manager/app/widgets/textfield/simple_textfield.dart';

class InputForm extends StatelessWidget {
  InputForm();

  Widget storeNameTextField(BuildContext context) =>
      ControlledWidgetBuilder<HomeController>(builder: (context, controller) {
        return PaddingWidget(
            widget: SimpleTextfieldWidget(
                controller: controller.storeNameController,
                hintText: "Store Name",
                labelText: "Store Name",
                helperText: "The receipt store name",
                validator: controller.validateStoreName,
                readOnly: false,
                icon: Icon(Icons.store_mall_directory_outlined)));
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
          icon: Icon(Icons.tag),
          readOnly: false,
        );
      }));

  Widget totalTextField(BuildContext context) =>
      PaddingWidget(widget: ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: SimpleTextfieldWidget(
              controller: controller.receiptTotalController,
              hintText: "Receipt Total",
              labelText: "Receipt Total",
              helperText: "The receipt total",
              icon: Icon(Icons.monetization_on_outlined),
              validator: controller.validateTotal,
              inputFormatters: [MoneyInputFormatter()],
              keyboardType: TextInputType.number,
              readOnly: false,
            )),
            PaddingWidget(
              widget: NeumorphicButton(
                onPressed: () => controller.currencyPicker(context),
                style: NeumorphicStyle(
                    color: Colors.grey[200],
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.stadium(),
                    border: NeumorphicBorder(width: 2, color: Colors.green)),
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      controller.currency?.code ?? "EUR",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            )
          ],
        );
      }));

  Widget dateTextField(BuildContext context) =>
      PaddingWidget(widget: ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
        return GestureDetector(
            onTap: () => controller.setDate,
            child: SimpleTextfieldWidget(
              controller: controller.receiptDateController,
              hintText: "Receipt Date",
              labelText: "Receipt Date",
              helperText: "The receipt date",
              onTap: () => controller.setDate(context),
              icon: Icon(Icons.date_range),
              validator: controller.validateDate,
              readOnly: true,
            ));
      }));

  Widget submitButton(BuildContext context) =>
      ControlledWidgetBuilder<HomeController>(builder: (context, controller) {
        return PaddingWidget(
            widget: Align(
          alignment: Alignment.centerLeft,
          child: NeumorphicButton(
              onPressed: () => controller.submit(),
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.stadium(),
              ),
              child: Text("Submit",
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ));
      });

  Widget categoryTextFormat(BuildContext context) =>
      PaddingWidget(widget: ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
        return SimpleTextfieldWidget(
          controller: controller.receiptCategoryController,
          hintText: "Receipt Category",
          labelText: "Receipt Category",
          helperText: "The receipt category",
          icon: Icon(Icons.category),
          validator: controller.validateCategory,
          readOnly: false,
        );
      }));

  spacer() => SizedBox(
        height: 20,
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ControlledWidgetBuilder<HomeController>(
            builder: (context, controller) => Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      storeNameTextField(context),
                      totalTextField(context),
                      dateTextField(context),
                      tagTextField(context),
                      categoryTextFormat(context),
                      submitButton(context),
                      spacer()
                    ],
                  ),
                )));
  }
}
