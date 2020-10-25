/*
 * Copyright (c) 2020 - William Todt
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';
import 'package:receipt_parser/converter/color_converter.dart';
import 'package:receipt_parser/database/receipt_database.dart';
import 'package:receipt_parser/date/date_manipulator.dart';
import 'package:receipt_parser/factory/categories_factory.dart';
import 'package:receipt_parser/factory/padding_factory.dart';
import 'package:receipt_parser/factory/text_form_history.dart';
import 'package:receipt_parser/generated/l10n.dart';
import 'package:receipt_parser/model/receipt_category.dart';
import 'package:receipt_parser/theme/theme_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'camera_picker.dart';

class ReceiptForm extends StatefulWidget {
  final ReceiptsCompanion receipt;
  final sharedPrefs;
  final bool sendImage;
  final DbBloc _bloc;

  ReceiptForm(this.receipt, this.sendImage, this.sharedPrefs, this._bloc);

  @override
  ReceiptInputController createState() {
    return ReceiptInputController(receipt, sendImage, this.sharedPrefs, _bloc);
  }
}

class ReceiptInputController extends State<ReceiptForm> {
  final _formKey = GlobalKey<FormState>();
  final _dropKey = GlobalKey<FormState>();
  final SharedPreferences sharedPrefs;
  final DbBloc _bloc;

  TextEditingController storeNameController;
  TextEditingController receiptTotalController;
  TextEditingController dateController;

  String shopName;
  String total;
  bool sendImage;
  String receiptCategory;

  DateTime receiptDate;
  ReceiptsCompanion parsedReceipt;
  ReceiptCategory selectedCategory;

  ReceiptInputController(
      this.parsedReceipt, this.sendImage, this.sharedPrefs, this._bloc);

  @override
  void initState() {
    String initialStoreName = "";
    String initialTotalName = "";
    String initialDateController = "";

    if (parsedReceipt != null) {
      initialStoreName = parsedReceipt.shop.value ?? '';
      initialTotalName = parsedReceipt.total.value ?? '';

      if (parsedReceipt.date.value != null)
        initialDateController =
            DateManipulator.humanDate(parsedReceipt.date.value);
    }

    storeNameController = TextEditingController(text: initialStoreName);
    receiptTotalController = TextEditingController(text: initialTotalName);
    dateController = TextEditingController(text: initialDateController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) => showUpdateSuccess());
    return BlocBuilder(
        cubit: _bloc,
        builder: (BuildContext context, state) {
      if (state is LoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ErrorState) {
        return Center(
          child: Text(S.of(context).receiptLoadFailed),
        );
      }
      if (state is LoadedState) {
        final receipt = state.receipt;
        return BlocProvider(
            create: (_) => _bloc,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(children: <Widget>[
                                      new Padding(
                                          padding:
                                          const EdgeInsets.only(top: 16.0, left: 8),
                                          child: new Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                S.of(context).addReceipt,
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w300),
                                              ))),
                                      PaddingFactory.create(new Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            icon: new Icon(Icons.camera_alt,
                                                size: 35, color: Colors.black),
                                            color: Colors.white,
                                            onPressed: () async {
                                              WidgetsFlutterBinding.ensureInitialized();

                                              final cameras = await availableCameras();
                                              final firstCamera = cameras.first;

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => TakePictureScreen(
                                                      sharedPrefs: sharedPrefs,
                                                      camera: firstCamera),
                                                ),
                                              );
                                            },
                                          )))
                                    ]),
                                    PaddingFactory.create(new Theme(
                                        data: AppTheme.lightTheme,
                                        child: TextFormFactory.storeName(
                                            storeNameController, context,receipt))),
                                    PaddingFactory.create(new Theme(
                                        data: AppTheme.lightTheme,
                                        child: TextFormFactory.total(
                                            receiptTotalController, context))),
                                    PaddingFactory.create(new Theme(
                                        data: AppTheme.lightTheme,
                                        child: TextFormField(
                                          style:
                                          TextStyle(color: HexColor.fromHex("#232F34")),
                                          keyboardType: TextInputType.number,
                                          decoration: new InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: HexColor.fromHex("#232F34")),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: HexColor.fromHex("#232F34")),
                                              ),
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: HexColor.fromHex("#232F34"))),
                                              hintText: S.of(context).receiptDateFormat,
                                              labelText: S.of(context).receiptDateLabelText,
                                              helperText:
                                              S.of(context).receiptDateHelperText,
                                              prefixIcon: IconButton(
                                                  icon: Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.purple,
                                                  ),
                                                  splashColor: Colors.black,
                                                  color: Colors.black,
                                                  onPressed: () async {
                                                    receiptDate = await showDatePicker(
                                                        builder: (BuildContext context,
                                                            Widget child) {
                                                          return Theme(
                                                            data:
                                                            ThemeData.light().copyWith(
                                                              primaryColor: Colors.black,
                                                              accentColor: Colors.black,
                                                              colorScheme:
                                                              ColorScheme.light(
                                                                  primary: const Color(
                                                                      0XFFF9AA33)),
                                                              buttonTheme: ButtonThemeData(
                                                                  textTheme: ButtonTextTheme
                                                                      .primary),
                                                            ),
                                                            child: child,
                                                          );
                                                        },
                                                        context: context,
                                                        initialDate: DateTime.now(),
                                                        firstDate: DateTime(2010),
                                                        lastDate: DateTime(2050));
                                                    dateController.text = DateFormat(
                                                        S.of(context).receiptDateFormat)
                                                        .format(receiptDate);
                                                  })),
                                          controller: dateController,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return S.of(context).receiptDateDialog;
                                            }
                                            RegExp totalRegex = new RegExp(
                                                "^(0?[1-9]|[12][0-9]|3[01])[.\\/ ]?(0?[1-9]|1[0-2])[./ ]?(?:19|20)[0-9]{2}\$",
                                                caseSensitive: false,
                                                multiLine: false);

                                            if (!totalRegex.hasMatch(value.trim())) {
                                              return S.of(context).receiptDateNotFormatted +
                                                  " " +
                                                  S.of(context).receiptDateFormat;
                                            }

                                            return null;
                                          },
                                        ))),
                                    PaddingFactory.create(Container(
                                        padding:
                                        const EdgeInsets.only(left: 8.0, right: 8.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(color: Colors.black)),
                                        child: Theme(
                                            data: AppTheme.lightTheme,
                                            child: DropdownButton<ReceiptCategory>(
                                                key: _dropKey,
                                                hint: Text(
                                                    S.of(context).receiptSelectCategory),
                                                value: selectedCategory,
                                                isExpanded: true,
                                                onChanged: (ReceiptCategory value) {
                                                  setState(() {
                                                    receiptCategory = value.name;
                                                    selectedCategory = value;
                                                  });
                                                },
                                                items: ReceiptCategoryFactory.get(context)
                                                    .map((ReceiptCategory user) {
                                                  return DropdownMenuItem<ReceiptCategory>(
                                                    value: user,
                                                    child: Row(
                                                      children: <Widget>[
                                                        user.icon,
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(user.name),
                                                      ],
                                                    ),
                                                  );
                                                }).toList())))),
                                    new Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: submitButton())),
                                  ],
                                ),
                              ))),
                    ],
                  ),
                ),
              ],
            ));
      }
      return Container(
          color: Colors.white,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: <BoxShadow>[
                BoxShadow(offset: Offset(0, 5), blurRadius: 10)
              ]));
    },
    );
  }

  FloatingActionButton submitButton() {
    return new FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate() &&
              receiptCategory != null &&
              receiptCategory.isNotEmpty) {
            try {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(S.of(context).addReceipt),
                backgroundColor: Colors.green,
              ));
              shopName = storeNameController.text;
              total = receiptTotalController.text;
            } catch (e) {
              reset();
              return;
            }
            _bloc.add(InsertEvent(
                receipt: ReceiptsCompanion(
                    date: Value(receiptDate),
                    total: Value(total),
                    category: Value(jsonEncode(selectedCategory)),
                    shop: Value(shopName))));
            _bloc.add(ReceiptAllFetch());
            reset();
          } else {
            if (receiptCategory.isEmpty) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(S.of(context).receiptSelectCategory),
                  backgroundColor: Colors.red));
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(S.of(context).invalidInput),
                  backgroundColor: Colors.red));
            }
          }
        },
        child: Icon(Icons.done_all));
  }

  void showUpdateSuccess() {
    if (sendImage) {
      if (parsedReceipt == null) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(S.of(context).uploadFailed),
            backgroundColor: Colors.red,
          ));
      } else {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(S.of(context).uploadSuccess),
            backgroundColor: Colors.green,
          ));
      }
    }
  }

  void reset() {
    receiptTotalController.clear();
    storeNameController.clear();
    dateController.clear();
  }

}
