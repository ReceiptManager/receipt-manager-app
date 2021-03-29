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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:random_color/random_color.dart';
import 'package:receipt_manager/api/expenses_api.dart';
import 'package:receipt_manager/db/bloc/moor/bloc.dart';
import 'package:receipt_manager/db/receipt_database.dart';
import 'package:receipt_manager/factory/banner_factory.dart';
import 'package:receipt_manager/factory/categories_factory.dart';
import 'package:receipt_manager/factory/logo_factory.dart';
import 'package:receipt_manager/factory/padding_factory.dart';
import 'package:receipt_manager/factory/text_form_history.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/db/memento/receipt_memento.dart';
import 'package:receipt_manager/db/model/receipt_category.dart';
import 'package:receipt_manager/ui/theme/color/color.dart';
import 'package:receipt_manager/ui/theme/theme_manager.dart';
import 'package:receipt_manager/util/date_manipulator.dart';

class HistoryWidget extends StatefulWidget {
  final DbBloc _bloc;

  HistoryWidget(this._bloc);

  @override
  State<StatefulWidget> createState() => HistoryWidgetState(_bloc);
}

class HistoryWidgetState extends State<HistoryWidget> {
  ReceiptMemento momentum = ReceiptMemento();
  List<Receipt> receipts = [];

  final emptyImagePath = "assets/not_empty";
  final _editFormKey = GlobalKey<FormState>();
  final DbBloc _bloc;
  DateTime receiptDate;

  TextEditingController _storeNameController;
  TextEditingController _receiptTotalController;
  TextEditingController _dateController;
  TextEditingController _controller = TextEditingController();

  HistoryWidgetState(this._bloc);

  FilterChipScreen screen;
  bool init = false;

  ExpensesApi api = ExpensesApi();

  @override
  void initState() {
    super.initState();

    _storeNameController = TextEditingController();
    _receiptTotalController = TextEditingController();
    _dateController = TextEditingController();
    init = false;
  }

  void callback(List<Receipt> receipts) {
    setState(() {
      this.receipts = receipts;
      this.momentum.receipts = receipts;
      api.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!init) screen = FilterChipScreen(callback);

    return BlocBuilder(
      bloc: _bloc,
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
          if (!init) {
            this.momentum.store(state.receipt);
            this.receipts = state.receipt;
            init = true;
            api.init();
          }

          if ((this.receipts == null || this.receipts.length == 0) &&
              this.momentum.finalReceipts.length == 0)
            return new Column(
              children: [
                BannerFactory.get(BANNER_MODES.OVERVIEW_EXPENSES, context),
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

          return Column(
            children: <Widget>[
              BannerFactory.get(BANNER_MODES.OVERVIEW_EXPENSES, context),
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
              screen,
              Expanded(
                child: Container(
                    color: Colors.white,
                    child: AnimationLimiter(
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8.0),
                            itemCount: this.receipts.length,
                            itemBuilder: (_, index) {
                              var receipt = this.receipts[index];

                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                      child: _buildListItems(receipt)),
                                ),
                              );
                            }))),
              ),
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
              setState(() {
                receipts.remove(receipt);
                momentum.delete(receipt);
              });
              _bloc.add(DeleteEvent(receipt: receipt));
              // _bloc.add(ReceiptAllFetch());
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
              borderRadius: BorderRadius.circular(8.0),
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
                                      .format(receipt.date) +
                                  (receipt.tag.isEmpty
                                      ? ''
                                      : ', ' + receipt.tag.toString()),
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

  String _storeName;
  String _receiptTotal;
  String _currentReceiptDate;
  String category;
  Receipt currentReceipt;

  _showDialog({controller, Receipt receipt}) async {
    this._storeName = receipt.shop;
    this._receiptTotal = receipt.total.replaceAll(" ", "");
    this._currentReceiptDate = DateManipulator.humanDate(context, receipt.date);
    this.category = receipt.category;
    this.currentReceipt = receipt;

    this._storeNameController.text = _storeName;
    this._receiptTotalController.text = _receiptTotal;
    this._dateController.text = _currentReceiptDate;

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
                                          _storeNameController,
                                          context,
                                          this.momentum.receipts))),
                                  PaddingFactory.create(new Theme(
                                      data: AppTheme.lightTheme,
                                      child: TextFormFactory.total(
                                          _receiptTotalController, context))),
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

                                                  if (receiptDate != null)
                                                    _dateController
                                                        .text = DateFormat(S
                                                            .of(context)
                                                            .receiptDateFormat)
                                                        .format(receiptDate);
                                                })),
                                        controller: _dateController,
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
            TextButton(
              child: Text(
                S.of(context).cancel,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                S.of(context).update,
              ),
              onPressed: () {
                if (_currentReceiptDate != null) {
                  try {
                    _storeName = _storeNameController.text;
                    _storeName.split(" ").join("");
                    _receiptTotal = _receiptTotalController.text;
                    _receiptTotal.split(" ").join("");
                  } catch (e) {
                    _receiptTotalController.clear();
                    _storeNameController.clear();
                    _dateController.clear();
                    Navigator.pop(context);
                    return;
                  }

                  Receipt refreshedReceipt = currentReceipt.copyWith(
                      category: this.category,
                      shop: this._storeName,
                      total: this._receiptTotal,
                      date: this.receiptDate);

                  setState(() {
                    receipts[receipts.indexWhere(
                            (element) => element.id == receipt.id)] =
                        refreshedReceipt;
                    momentum.update(refreshedReceipt);
                  });

                  _bloc.add(UpdateEvent(receipt: refreshedReceipt));

                  //_bloc.add(ReceiptAllFetch());

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(S.of(context).updateReceiptSuccessful),
                      backgroundColor: Colors.green,
                    ));

                  _controller.clear();
                  _dateController.clear();
                  _receiptTotalController.clear();
                } else {
                  ScaffoldMessenger.of(context)
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
  final Function callback;

  @override
  _FilterChipScreenState createState() => _FilterChipScreenState(callback);

  FilterChipScreen(this.callback);
}

class _FilterChipScreenState extends State<FilterChipScreen> {
  Function callback;

  var data = ReceiptCategoryFactory.categories;

  List<ReceiptCategory> filterCategories = [];
  List<Color> colors;
  var selected = [];

  ReceiptMemento momentum = ReceiptMemento();

  RandomColor _rand = RandomColor();

  _FilterChipScreenState(this.callback);

  @override
  void initState() {
    super.initState();

    colors = [];
    for (int i = 0; i < data.length; i++) {
      colors.add(_rand.randomColor());
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    setState(() {
                      if (!value) {
                        selected.remove(index);
                        removeFilter(index);
                      } else {
                        selected.add(index);
                        addFilter(index);
                      }
                      filter();
                    });
                  },
                  selected: selected.contains(index),
                  selectedColor: colors[index],
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  backgroundColor: colors[index],
                ),
              )),
    );
  }

  void addFilter(int index) {
    if (!filterCategories.contains(data[index]))
      filterCategories.add(data[index]);
  }

  void removeFilter(int index) {
    if (filterCategories != null) {
      filterCategories.remove(data[index]);
    }
  }

  void filter() {
    List<Receipt> filteredReceipts = [];
    if (filterCategories.length == 0) {
      setState(() {
        callback(momentum.finalReceipts);
      });

      return;
    }

    for (Receipt r in momentum.finalReceipts) {
      for (ReceiptCategory category in filterCategories) {
        Map<String, dynamic> json = jsonDecode(r.category);
        if (json['name'] == category.name) filteredReceipts.add(r);
      }
    }
    callback(filteredReceipts);
  }
}
