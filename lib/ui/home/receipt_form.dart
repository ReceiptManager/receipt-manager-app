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
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:receipt_manager/db/bloc/moor/bloc.dart';
import 'package:receipt_manager/db/receipt_database.dart';
import 'package:receipt_manager/factory/banner_factory.dart';
import 'package:receipt_manager/factory/categories_factory.dart';
import 'package:receipt_manager/factory/padding_factory.dart';
import 'package:receipt_manager/factory/text_form_history.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/db/model/receipt_category.dart';
import 'package:receipt_manager/network/network_client.dart';
import 'package:receipt_manager/network/network_client_holder.dart';
import 'package:receipt_manager/ui/camera/edge_detector.dart';
import 'package:receipt_manager/ui/settings/settings_widget.dart';
import 'package:receipt_manager/ui/theme/color/color.dart';
import 'package:receipt_manager/ui/theme/theme_manager.dart';
import 'package:receipt_manager/ui/camera/camera_picker.dart';
import 'package:receipt_manager/util/date_manipulator.dart';
import 'package:receipt_manager/util/dimensions.dart';
import 'package:receipt_manager/util/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final _editFormKey = GlobalKey<FormState>();

  final SharedPreferences _sharedPrefs;
  final DbBloc _bloc;

  TextEditingController _storeNameController;
  TextEditingController _itemNameController;
  TextEditingController _itemTotalController;
  TextEditingController _receiptTotalController;
  TextEditingController _receiptTagController;
  TextEditingController _dateController;
  TextEditingController _controller;

  String _shopName;
  String _total;
  String _tag;
  bool _sendImage;
  String _receiptCategory;

  DateTime _receiptDate;
  ReceiptsCompanion _parsedReceipt;
  ReceiptCategory _selectedCategory;
  List<dynamic> _itemList;

  bool _outcome;
  bool _showAlert;

  NetworkClient _client;

  ReceiptInputController(
      this._parsedReceipt, this._sendImage, this._sharedPrefs, this._bloc);

  @override
  void initState() {
    String initialStoreName = "";
    String initialTotalName = "";
    String initialDateName = "";
    String initialTagName = "";

    _outcome = true;
    _showAlert = false;

    if (ReceiptCompanionValidator.valid(_parsedReceipt)) {
      initialStoreName = _parsedReceipt.shop.value ?? '';
      initialTotalName = _parsedReceipt.total.value ?? '';
      initialTagName = _parsedReceipt.tag.value ?? '';

      _itemList = jsonDecode(_parsedReceipt.items.value);
      _showAlert = true;
    }

    _storeNameController = TextEditingController(text: initialStoreName);
    _receiptTotalController = TextEditingController(text: initialTotalName);
    _dateController = TextEditingController(text: initialDateName);
    _receiptTagController = TextEditingController(text: initialTagName);

    _controller = TextEditingController();
    _itemNameController = TextEditingController();

    _client = NetworkClient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

    setState(() {
      if (_parsedReceipt != null && _parsedReceipt.date.value != null)
        _dateController.text =
            DateManipulator.humanDate(context, _parsedReceipt.date.value);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => showUpdateSuccess());
    bool edgeDetection =
        this._sharedPrefs.getBool(SharedPreferenceKeyHolder.detectEdges);
    return BlocBuilder(
      key: key,
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
          final receipt = state.receipts;
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
                                BannerFactory.get(
                                    BANNER_MODES.ADD_RECEIPT, context),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: DimensionsCalculator
                                            .getBannerHeight(context),
                                        right: 16),
                                    child: Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          icon: new Icon(Icons.camera_alt,
                                              size: 40, color: Colors.black),
                                          color: Colors.white,
                                          onPressed: () async {
                                            WidgetsFlutterBinding
                                                .ensureInitialized();

                                            final cameras =
                                                await availableCameras();
                                            final firstCamera = cameras.first;

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Theme(
                                                      data: AppTheme.lightTheme,
                                                      child: edgeDetection
                                                          ? EdgeDetector()
                                                          : TakePictureScreen(
                                                              camera:
                                                                  firstCamera,
                                                              key: _formKey,
                                                              sharedPrefs: this
                                                                  ._sharedPrefs)),
                                                ));
                                          },
                                        ))),
                              ]),
                              PaddingFactory.create(TextFormFactory.storeName(
                                  _storeNameController, context, receipt)),
                              PaddingFactory.create(TextFormFactory.total(
                                  _receiptTotalController, context)),
                              PaddingFactory.create(TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: new InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[100]),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.grey[100])),
                                    hintText: S.of(context).receiptDateFormat,
                                    // labelText:
                                    //   S.of(context).receiptDateLabelText,
                                    helperText:
                                        S.of(context).receiptDateHelperText,
                                    prefixIcon: IconButton(
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: Colors.red[500],
                                        ),
                                        splashColor: Colors.black,
                                        color: Colors.black,
                                        onPressed: () async {
                                          _receiptDate = await showDatePicker(
                                              builder: (BuildContext context,
                                                  Widget child) {
                                                return Theme(
                                                  data: ThemeData.light()
                                                      .copyWith(
                                                    primaryColor: Colors.black,
                                                    accentColor: Colors.black,
                                                    colorScheme:
                                                        ColorScheme.light(
                                                            primary:
                                                                (Colors.red)),
                                                    buttonTheme:
                                                        ButtonThemeData(
                                                            textTheme:
                                                                ButtonTextTheme
                                                                    .primary),
                                                  ),
                                                  child: child,
                                                );
                                              },
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2010),
                                              lastDate: DateTime(2050));

                                          if (_receiptDate == null)
                                            _dateController.text = "";
                                          else
                                            _dateController.text = DateFormat(S
                                                    .of(context)
                                                    .receiptDateFormat)
                                                .format(_receiptDate);
                                        })),
                                controller: _dateController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return S.of(context).receiptDateDialog;
                                  }

                                  try {
                                    var format = DateFormat(
                                        S.of(context).receiptDateFormat);
                                    _receiptDate = format.parse(value);

                                    if (_receiptDate.year < 100) {
                                      _receiptDate = null;
                                      return S
                                          .of(context)
                                          .receiptDateNotFormatted +
                                          " " +
                                          S.of(context).receiptDateFormat;
                                    }
                                    return null;
                                  } catch (_) {
                                   log(_.toString());
                                   _receiptDate = null;
                                   return S
                                       .of(context)
                                       .receiptDateNotFormatted +
                                       " " +
                                       S.of(context).receiptDateFormat;}
                                },
                              )),
                              PaddingFactory.create(TextFormFactory.tag(
                                  _receiptTagController, context)),
                              PaddingFactory.create(Container(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: DropdownButtonFormField<
                                          ReceiptCategory>(
                                      key: _dropKey,
                                      decoration: const InputDecoration(
                                        border: const OutlineInputBorder(),
                                      ),
                                      hint: Text(
                                          S.of(context).receiptSelectCategory),
                                      value: _selectedCategory,
                                      isExpanded: true,
                                      onChanged: (ReceiptCategory value) {
                                        setState(() {
                                          _receiptCategory = value.name;
                                          _selectedCategory = value;
                                        });
                                      },
                                      dropdownColor: Colors.grey[100],
                                      items: ReceiptCategoryFactory.get(context)
                                          .map((ReceiptCategory user) {
                                        return DropdownMenuItem<
                                            ReceiptCategory>(
                                          value: user,
                                          child: Row(
                                            children: <Widget>[
                                              user.icon,
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                user.name,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList()))),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                //Center Row contents vertically,
                                children: [
                                  Center(
                                    child: new Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: submitButton())),
                                  )
                                ],
                              ),
                              getItems(),
                              getItemListButton()
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

  _showDialog({controller, List<dynamic> item}) async {
    this._itemNameController.text = item[0];
    this._itemTotalController.text = item[1];

    await showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          titleTextStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 22),
          backgroundColor: Colors.white,
          title: Text(S.of(context).updateReceipt),
          content: Container(
            height: 200,
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
                                      child: TextFormFactory.itemName(
                                          _itemNameController, context))),
                                  PaddingFactory.create(new Theme(
                                      data: AppTheme.lightTheme,
                                      child: TextFormFactory.itemTotal(
                                          _itemTotalController, context))),
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
                String itemName;
                String itemTotal;
                try {
                  itemName = _itemNameController.text;
                  itemName.split(" ").join("");
                  itemTotal = _itemTotalController.text;
                  itemTotal.split(" ").join("");

                  setState(() {
                    item[0] = itemName;
                    item[1] = itemTotal;
                  });
                } catch (e) {
                  _receiptTotalController.clear();
                  _storeNameController.clear();
                  _dateController.clear();
                  Navigator.pop(context);
                  return;
                }
                _controller.clear();
                _itemNameController.clear();
                _itemTotalController.clear();

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _item(List<dynamic> item) {
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
                _itemList.remove(item);
              });
            },
          ),
          IconSlideAction(
            caption: S.of(context).editReceipt,
            icon: Icons.update,
            color: LightColor.black,
            onTap: () {
              _showDialog(controller: _controller, item: item);
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
                      // contentPadding:
                      //   EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      trailing: Text(
                        item[1] + S.of(context).currency,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      leading: Text(item[0]))),
              clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
            )));
  }

  Widget getItems() {
    if (_itemList == null || _itemList.length == 0) {
      return Container();
    }
    return Column(children: [
      PaddingFactory.create(Align(
        alignment: Alignment.bottomLeft,
        child: Text(S.of(context).products,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w300)),
      )),
      Container(
          color: Colors.white,
          height: (50 * _itemList.length).toDouble(),
          child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _itemList.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final receipt = _itemList[index];
                return _item(receipt);
              })),
    ]);
  }

  ButtonTheme submitButton() {
    return new ButtonTheme(
        minWidth: 150.0,
        height: 50.0,
        child: RaisedButton(
            color: Colors.black,
            shape: StadiumBorder(),
            onPressed: () {
              if (_formKey.currentState.validate() &&
                  _receiptCategory != null &&
                  _selectedCategory != null) {
                try {
                  if (_showAlert)
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(S.of(context).addedReceipt),
                      backgroundColor: Colors.green,
                    ));

                  _showAlert = false;
                  _shopName = _storeNameController.text;
                  _total = _receiptTotalController.text;
                  _tag = _receiptTagController.text;
                } catch (e) {
                  reset();
                  return;
                }

                // trim negligent whitespaces
                _shopName = _shopName.trim();
                _shopName.split(" ").join("");
                _total = _outcome == false ? "-" + _total : _total;
                _total.split(" ").join("");
                _tag = _tag?.trim();

                String jsonItemList =
                    _itemList == null ? null : jsonEncode(_itemList);

                _bloc.add(InsertEvent(
                    receipt: ReceiptsCompanion(
                        date: Value(_receiptDate),
                        total: Value(_total),
                        category: Value(jsonEncode(_selectedCategory)),
                        items: Value(jsonItemList),
                        shop: Value(_shopName),
                        tag: Value(_tag))));
                _bloc.add(ReceiptAllFetch());

                NetworkClientHolder holder = NetworkClientHolder();
                holder.readOptions(_sharedPrefs);

                holder.company = _shopName;
                holder.date = _receiptDate.toIso8601String();
                holder.total = _total.replaceAll("-", "");

                bool _submitTrainingData =
                    _sharedPrefs.getBool("sendTrainingData");
                if (_submitTrainingData != null &&
                    _submitTrainingData == true &&
                    _sendImage) {
                  _client.sendTrainingData(holder, context);
                }

                reset();
              } else {
                if (_receiptCategory == null || _receiptCategory.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(S.of(context).receiptSelectCategory),
                      backgroundColor: Colors.red));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(S.of(context).invalidInput),
                      backgroundColor: Colors.red));
                }
              }
            },
            child: Text(
              S.of(context).confirm,
              style: TextStyle(color: Colors.white),
            )));
  }

  void showUpdateSuccess() {
    if (!_showAlert) return;

    if (_sendImage) {
      if (!ReceiptCompanionValidator.valid(_parsedReceipt)) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(S.of(context).uploadFailed),
            backgroundColor: Colors.red,
          ));
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(S.of(context).uploadSuccess),
            backgroundColor: Colors.green,
          ));
      }

      _showAlert = false;
    }
  }

  void reset() {
    _receiptTotalController.clear();
    _storeNameController.clear();
    _dateController.clear();
    _receiptTagController.clear();
    _receiptDate = null;
  }

  Widget getItemListButton() {
    if (_itemList == null || _itemList.length == 0) return Container();

    return PaddingFactory.create(Align(
        alignment: Alignment.topRight,
        child: RaisedButton(
          onPressed: () {
            log("Add itemlist");
            setState(() {
              List<dynamic> item = ["Receipt item", "0.00"];
              this._itemList.add(item);
            });
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.black)),
          child: Column(children: [Icon(Icons.add, color: Colors.white)]),
          color: Colors.black,
          textColor: Colors.black,
          elevation: 5,
        )));
  }
}
