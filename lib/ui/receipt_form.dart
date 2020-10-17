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

  TextEditingController storeNameController;
  TextEditingController receiptTotalController;
  TextEditingController dateController;

  String shopName;
  String total;
  String receiptCategory;
  DateTime receiptDate;
  ReceiptsCompanion parsedReceipt;
  bool sendImage;

  ReceiptCategory selectedCategory;
  List<ReceiptCategory> categories = ReceiptCategoryFactory.get();

  ReceiptInputController(
      this.parsedReceipt, this.sendImage, this.sharedPrefs, this._bloc);

  final DbBloc _bloc;

  @override
  void initState() {
    String initialStoreName = "";
    String initialTotalName = "";
    String initialDateController = "";
    if (parsedReceipt != null) {
      initialStoreName = parsedReceipt.shop.value ?? '';
      initialTotalName = parsedReceipt.total.value ?? '';
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
                          color: Colors.white,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Stack(children: <Widget>[
                                  new Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, left: 8),
                                      child: new Align(
                                          alignment: Alignment.bottomLeft,
                                          child: new GestureDetector(
                                              onTap: () {
                                                print("Insert debug entry");
                                                _bloc.add(InsertEvent(
                                                    receipt: ReceiptsCompanion(
                                                        date: Value(
                                                            DateTime.now()),
                                                        total: Value("99.99"),
                                                        category:
                                                            Value("Grocery"),
                                                        shop: Value(
                                                            "Insert EVENT"))));
                                                _bloc.add(ReceiptAllFetch());
                                              },
                                              child: const Text(
                                                "Add new Receipt",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.w300),
                                              )))),
                                  PaddingFactory.create(new Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: new Icon(Icons.camera_alt,
                                            size: 35, color: Colors.black),
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
                                              builder: (context) =>
                                                  TakePictureScreen(
                                                      sharedPrefs: sharedPrefs,
                                                      camera: firstCamera),
                                            ),
                                          );
                                        },
                                      )))
                                ]),
                                PaddingFactory.create(new Theme(
                                    data: ThemeManager.getTheme(),
                                    child: TextFormFactory.storeName(
                                        storeNameController))),
                                PaddingFactory.create(new Theme(
                                    data: ThemeManager.getTheme(),
                                    child: TextFormFactory.total(
                                        receiptTotalController))),
                                PaddingFactory.create(new Theme(
                                    data: ThemeManager.getTheme(),
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
                                          hintText: 'dd.MM.YYYY',
                                          labelText: 'Receipt date',
                                          helperText: "Set the receipt date",
                                          prefixIcon: IconButton(
                                              icon: Icon(
                                                Icons.calendar_today,
                                                color: Colors.purple,
                                              ),
                                              splashColor:
                                              ThemeManager.getYellow(),
                                              color: Colors.black,
                                              onPressed: () async {
                                                receiptDate =
                                                await showDatePicker(
                                                    builder: (BuildContext
                                                    context,
                                                        Widget child) {
                                                      return Theme(
                                                        data: ThemeData
                                                            .light()
                                                            .copyWith(
                                                          primaryColor:
                                                          ThemeManager
                                                              .getYellow(),
                                                          accentColor:
                                                          ThemeManager
                                                              .getYellow(),
                                                          colorScheme:
                                                          ColorScheme.light(
                                                              primary:
                                                              const Color(
                                                                  0XFFF9AA33)),
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
                                                    initialDate:
                                                    DateTime.now(),
                                                    firstDate:
                                                    DateTime(2010),
                                                    lastDate:
                                                    DateTime(2050));
                                                dateController.text =
                                                    DateFormat("dd.MM.yyyy")
                                                        .format(receiptDate);
                                              })),
                                      controller: dateController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some date';
                                        }
                                        RegExp totalRegex = new RegExp(
                                            "^(0?[1-9]|[12][0-9]|3[01])[.\\/ ]?(0?[1-9]|1[0-2])[./ ]?(?:19|20)[0-9]{2}\$",
                                            caseSensitive: false,
                                            multiLine: false);

                                        if (!totalRegex
                                            .hasMatch(value.trim())) {
                                          return "Date is not formatted (dd.MM.YYYY).";
                                        }

                                        return null;
                                      },
                                    ))),
                                PaddingFactory.create(Container(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border:
                                        Border.all(color: Colors.black)),
                                    child: DropdownButton<ReceiptCategory>(
                                        key: _dropKey,
                                        dropdownColor: Colors.white,
                                        style: TextStyle(color: Colors.black),
                                        hint: Text("Select receipt category"),
                                        value: selectedCategory,
                                        isExpanded: true,
                                        onChanged: (ReceiptCategory value) {
                                          setState(() {
                                            receiptCategory = value.name;
                                            selectedCategory = value;
                                          });
                                        },
                                        items: categories
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
                                                      color: Colors.black87),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList()))),
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

  FloatingActionButton submitButton() {
    return new FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate() &&
              receiptCategory != null &&
              receiptCategory.isNotEmpty) {
            try {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Insert new receipt'),
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
                    category: Value(receiptCategory),
                    shop: Value(shopName))));
            _bloc.add(ReceiptAllFetch());
            reset();
          } else {
            if (receiptCategory.isEmpty) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Please select a category.'),
                  backgroundColor: Colors.red));
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Input appears invalid.'),
                  backgroundColor: Colors.red));
            }
          }
        },
        child: Icon(Icons.done_all),
        backgroundColor: HexColor.fromHex("#232F34"),
        foregroundColor: HexColor.fromHex("#F9AA33"));
  }

  void showUpdateSuccess() {
    if (sendImage) {
      if (parsedReceipt == null) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text("Failed to upload image."),
            backgroundColor: Colors.red,
          ));
      } else {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text("Image successfully uploaded."),
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
