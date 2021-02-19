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
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:random_color/random_color.dart';
import 'package:receipt_manager/api/expenses_api.dart';
import 'package:receipt_manager/bloc/moor/bloc.dart';
import 'package:receipt_manager/database/receipt_database.dart';
import 'package:receipt_manager/factory/banner_factory.dart';
import 'package:receipt_manager/factory/categories_factory.dart';
import 'package:receipt_manager/factory/logo_factory.dart';
import 'package:receipt_manager/factory/padding_factory.dart';
import 'package:receipt_manager/factory/text_form_history.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/memento/receipt_memento.dart';
import 'package:receipt_manager/model/receipt_category.dart';
import 'package:receipt_manager/theme/color/color.dart';
import 'package:receipt_manager/theme/theme_manager.dart';
import 'package:receipt_manager/util/date_manipulator.dart';

class HistoryWidget extends StatefulWidget {
  final DbBloc _bloc;

  HistoryWidget(this._bloc);

  @override
  State<StatefulWidget> createState() => HistoryWidgetState(_bloc);
}

class HistoryWidgetState extends State<HistoryWidget> {
  ReceiptMemento momentum = ReceiptMemento();
  final emptyImagePath = "assets/not_empty";
  final _editFormKey = GlobalKey<FormState>();
  final DbBloc _bloc;
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
          momentum.store(state.receipt);

          if (this.momentum.receipts == null ||
              this.momentum.receipts.length == 0)
            return new Column(
              children: [
                BannerFactory.get(S.of(context).overviewExpenses, context),
                Container(
                    color: Colors.white,
                    child: PaddingFactory.create(Column(
                      children: [
                        PaddingFactory.create(
                          SvgPicture.asset(
                            this.emptyImagePath,
                            height: 250,
                          ),
                        ),
                        PaddingFactory.create(Text(
                          S.of(context).noReceipts,
                          style:
                              TextStyle(fontSize: 16, color: LightColor.grey),
                        ))
                      ],
                    )))
              ],
            );

          ExpensesApi api = ExpensesApi();
          api.init();

          return Column(
            children: <Widget>[
              BannerFactory.get(S.of(context).overviewExpenses, context),
              Container(
                color: Colors.white,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: PaddingFactory.create(Text(
                      S.of(context).overview +
                          ": " +
                          api.format(api.weeklyTotal, 2) +
                          S.of(context).currency,
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 20,
                          color: Colors.black),
                    ))),
              ),
              FilterChipScreen(),
              Expanded(
                  child: Container(
                      color: Colors.white,
                      child: AnimationLimiter(
                          child: ListView.builder(
                              padding: const EdgeInsets.all(8.0),
                              itemCount: this.momentum.receipts.length,
                              itemBuilder: (_, index) {
                                final receipt = this.momentum.receipts[index];

                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: _buildListItems(receipt),
                                    ),
                                  ),
                                );
                              }))))
            ],
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
            color: LightColor.black,
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
                        receipt.total + S.of(context).currency,
                        style: TextStyle(
                            color: receipt.total[0] == "-"
                                ? Colors.redAccent
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Text(
                              ReceiptCategory.fromJson(
                                          jsonDecode(receipt.category))
                                      .name +
                                  ", " +
                                  DateFormat(S.of(context).receiptDateFormat)
                                      .format(receipt.date),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12))
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
      color: Colors.white,
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
    this.receiptTotal = receipt.total.replaceAll(" ", "");
    this.currentReceiptDate = DateManipulator.humanDate(context, receipt.date);
    this.category = receipt.category;
    this.currentReceipt = receipt;

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
                                          storeNameController,
                                          context,
                                          this.momentum.receipts))),
                                  PaddingFactory.create(new Theme(
                                      data: AppTheme.lightTheme,
                                      child: TextFormFactory.total(
                                          receiptTotalController, context))),
                                  PaddingFactory.create(new Theme(
                                      data: AppTheme.lightTheme,
                                      child: TextFormField(
                                        style: TextStyle(color: Colors.black),
                                        keyboardType: TextInputType.number,
                                        decoration: new InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[100]),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.grey[100])),
                                            hintText:
                                                S.of(context).receiptDateFormat,
                                            //  labelText: S
                                            //      .of(context)
                                            //  .receiptDateLabelText,
                                            helperText: S
                                                .of(context)
                                                .receiptDateHelperText,
                                            prefixIcon: IconButton(
                                                icon: Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.grey,
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
                if (currentReceiptDate != null) {
                  try {
                    storeName = storeNameController.text;
                    storeName.split(" ").join("");
                    receiptTotal = receiptTotalController.text;
                    receiptTotal.split(" ").join("");
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

class FilterChipScreen extends StatefulWidget {
  @override
  _FilterChipScreenState createState() => _FilterChipScreenState();

  FilterChipScreen();
}

class _FilterChipScreenState extends State<FilterChipScreen> {
  var data = ReceiptCategoryFactory.categories;
  var selected = [];
  List<ReceiptCategory> filterCategories = [];
  ReceiptMemento momentum = ReceiptMemento();

  RandomColor _rand = RandomColor();

  _FilterChipScreenState();

  @override
  Widget build(BuildContext context) {
    filterCategories = [];
    var selected = [];
    return Container(
      height: 65,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) =>
              PaddingFactory.create(
                FilterChip(
                  label: Text(data[index].name),
                  onSelected: (bool value) {
                    if (!value) {
                      selected.remove(index);
                      removeFilter(index);
                    } else {
                      selected.add(index);
                      addFilter(index);
                    }
                    filter();
                  },
                  selected: selected.contains(index),
                  selectedColor: Colors.red,
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  backgroundColor: _rand.randomColor(),
                ),
              )),
    );
  }

  void addFilter(int index) {
    filterCategories.add(data[index]);
  }

  void removeFilter(int index) {
    if (filterCategories != null && filterCategories.length > index) {
      filterCategories.remove(data[index]);
    }
  }

  void filter() {
    List<Receipt> filteredReceipts = [];
    for (Receipt r in momentum.finalReceipts) {
      for (ReceiptCategory category in filterCategories) {
        Map<String, dynamic> json = jsonDecode(r.category);

        if (json['name'] == category.name) filteredReceipts.add(r);
      }
    }

    setState(() {
      //momentum.receipts = filteredReceipts;
    });
  }
}
