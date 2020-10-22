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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';
import 'package:receipt_parser/converter/color_converter.dart';
import 'package:receipt_parser/database/receipt_database.dart';
import 'package:receipt_parser/date/date_manipulator.dart';
import 'package:receipt_parser/factory/logo_factory.dart';
import 'package:receipt_parser/factory/padding_factory.dart';
import 'package:receipt_parser/factory/text_form_history.dart';
import 'package:receipt_parser/generated/l10n.dart';
import 'package:receipt_parser/model/receipt_category.dart';
import 'package:receipt_parser/theme/color/color.dart';
import 'package:receipt_parser/theme/theme_manager.dart';

class HistoryWidget extends StatefulWidget {
  final DbBloc _bloc;

  HistoryWidget(this._bloc);

  @override
  State<StatefulWidget> createState() => HistoryWidgetState(_bloc);
}

class HistoryWidgetState extends State<HistoryWidget> {
  final _editFormKey = GlobalKey<FormState>();
  final DbBloc _bloc;
  List<Receipt> receipts;
  DateTime receiptDate;

  TextEditingController storeNameController;
  TextEditingController receiptTotalController;
  TextEditingController dateController;
  TextEditingController _controller = TextEditingController();

  HistoryWidgetState(this._bloc);

  @override
  void initState() {
    storeNameController = TextEditingController();
    receiptTotalController = TextEditingController();
    dateController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          return Column(
            children: <Widget>[Expanded(child: _buildList(receipt))],
          );
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

  _buildList(r) {
    return new Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: r.length,
            itemBuilder: (_, index) {
              final receipt = r[index];
              return _buildListItems(receipt);
            }));
  }

  Widget _buildListItems(Receipt receipt) {
    LogoFactory _factory = LogoFactory(receipt, context);
    String path = _factory.buildPath().toString();

    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        closeOnScroll: true,
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: S.of(context).deleteReceipt,
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              _bloc.add(DeleteEvent(receipt: receipt));
              _bloc.add(ReceiptAllFetch());
            },
          ),
          IconSlideAction(
            caption: S.of(context).editReceipt,
            icon: Icons.update,
            color: LightColor.brighter,
            onTap: () {
              _showDialog(controller: _controller, receipt: receipt);
            },
          ),
        ],
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ClipPath(
              child: Container(
                  color: Colors.white,
                  child: ListTile(
                      leading: Container(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset(
                              path,
                              fit: BoxFit.fill,
                            ),
                          )),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      trailing: Text(
                        "-" + receipt.total + S.of(context).currency,
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w300,
                            fontSize: 20),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Text(
                              ReceiptCategory.fromJson(jsonDecode(receipt.category)).name +
                                  ", " +
                                  DateManipulator.humanDate(receipt.date),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16))
                        ],
                      ),
                      title: Text(
                        receipt.shop,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ))),
              clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
            )));
  }

  Container createEditMenu({hint, icon, controller}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          suffixIcon: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: IconButton(
                icon: Icon(icon),
                onPressed: () async {
                  receiptDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2050),
                  );
                }),
          ),
        ),
      ),
    );
  }

  String storeName;
  String receiptTotal;
  String currentReceiptDate;
  String category;
  Receipt currentReceipt;

  _showDialog({controller, Receipt receipt}) async {
    this.storeName = receipt.shop;
    this.receiptTotal = receipt.total;
    this.currentReceiptDate = DateManipulator.humanDate(receipt.date);
    String c = ReceiptCategory.fromJson(jsonDecode(receipt.category)).name;
    this.category = c;
    this.currentReceipt = receipt;
    // this.currentReceipt = receipt;

    this.storeNameController.text = storeName;
    this.receiptTotalController.text = receiptTotal;
    this.dateController.text = currentReceiptDate;

    await showDialog<String>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          titleTextStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 22),
          backgroundColor: Colors.white,
          title: Text(S.of(context).updateReceipt),
          content: Container(
            height: 300,
            width: 250,
            color: Colors.white,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                    hasScrollBody: false,
                    child: Form(
                        key: _editFormKey,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: PaddingFactory.create(Column(
                                children: <Widget>[
                                  PaddingFactory.create(new Theme(
                                      data: AppTheme.lightTheme,
                                      child: TextFormFactory.storeName(
                                          storeNameController, context))),
                                  PaddingFactory.create(new Theme(
                                      data: AppTheme.lightTheme,
                                      child: TextFormFactory.total(
                                          receiptTotalController, context))),
                                  PaddingFactory.create(new Theme(
                                      data: AppTheme.lightTheme,
                                      child: TextFormField(
                                        style: TextStyle(
                                            color: HexColor.fromHex("#232F34")),
                                        keyboardType: TextInputType.number,
                                        decoration: new InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: HexColor.fromHex(
                                                      "#232F34")),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: HexColor.fromHex(
                                                      "#232F34")),
                                            ),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: HexColor.fromHex(
                                                        "#232F34"))),
                                            hintText:
                                                S.of(context).receiptDateFormat,
                                            labelText: S
                                                .of(context)
                                                .receiptDateLabelText,
                                            helperText: S
                                                .of(context)
                                                .receiptDateHelperText,
                                            prefixIcon: IconButton(
                                                icon: Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.purple,
                                                ),
                                                splashColor: Colors.black,
                                                color: Colors.black,
                                                onPressed: () async {
                                                  this.receiptDate =
                                                      await showDatePicker(
                                                          builder: (BuildContext
                                                                  context,
                                                              Widget child) {
                                                            return Theme(
                                                              data: ThemeData
                                                                      .light()
                                                                  .copyWith(
                                                                primaryColor:
                                                                    Colors
                                                                        .black,
                                                                accentColor:
                                                                    Colors
                                                                        .black,
                                                                colorScheme:
                                                                    ColorScheme.light(
                                                                        primary:
                                                                            const Color(0XFFF9AA33)),
                                                                buttonTheme: ButtonThemeData(
                                                                    textTheme:
                                                                        ButtonTextTheme
                                                                            .primary),
                                                              ),
                                                              child: child,
                                                            );
                                                          },
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2010),
                                                          lastDate:
                                                              DateTime(2050));
                                                  dateController
                                                      .text = DateFormat(S
                                                          .of(context)
                                                          .receiptDateFormat)
                                                      .format(receiptDate);
                                                })),
                                        controller: dateController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return S
                                                .of(context)
                                                .receiptDateDialog;
                                          }
                                          RegExp totalRegex = new RegExp(
                                              "^(0?[1-9]|[12][0-9]|3[01])[.\\/ ]?(0?[1-9]|1[0-2])[./ ]?(?:19|20)[0-9]{2}\$",
                                              caseSensitive: false,
                                              multiLine: false);

                                          if (!totalRegex
                                              .hasMatch(value.trim())) {
                                            return S
                                                    .of(context)
                                                    .receiptDateNotFormatted +
                                                " " +
                                                S.of(context).receiptDateFormat;
                                          }

                                          return null;
                                        },
                                      )))
                                ],
                              )),
                            )
                          ],
                        )))
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                S.of(context).cancel,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                S.of(context).update,
              ),
              onPressed: () {
                if (_editFormKey.currentState.validate() &&
                    currentReceiptDate != null) {
                  try {
                    storeName = storeNameController.text;
                    receiptTotal = receiptTotalController.text;
                  } catch (e) {
                    receiptTotalController.clear();
                    storeNameController.clear();
                    dateController.clear();
                    Navigator.pop(context);
                    return;
                  }

                  _bloc.add(UpdateEvent(
                      receipt: currentReceipt.copyWith(
                          category: this.category,
                          shop: this.storeName,
                          total: this.receiptTotal,
                          date: this.receiptDate)));

                  _bloc.add(ReceiptAllFetch());

                  Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(S.of(context).updateReceiptSuccessful),
                      backgroundColor: Colors.green,
                    ));

                  _controller.clear();
                  dateController.clear();
                  receiptTotalController.clear();
                } else {
                  Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(S.of(context).failedUpdateReceipt),
                      backgroundColor: Colors.red,
                    ));
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
