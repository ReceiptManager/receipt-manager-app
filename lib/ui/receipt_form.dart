

// ignore: must_be_immutable
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';
import 'package:receipt_parser/converter/color_converter.dart';
import 'package:receipt_parser/database//receipt_database.dart';
import 'package:receipt_parser/date/date_manipulator.dart';
import 'package:receipt_parser/factory/categories_factory.dart';
import 'package:receipt_parser/factory/padding_factory.dart';
import 'package:receipt_parser/factory/text_form_history.dart';
import 'package:receipt_parser/model/receipt_category.dart';
import 'package:receipt_parser/theme/theme_manager.dart';

import '../main.dart';
import 'camera_picker.dart';

class ReceiptForm extends StatefulWidget {
  Receipt receipt;
  bool sendImage;

  ReceiptForm(this.receipt, this.sendImage);

  @override
  ReceiptInputController createState() {
    return ReceiptInputController(receipt, sendImage);
  }
}

class ReceiptInputController extends State<ReceiptForm> {
  final _formKey = GlobalKey<FormState>();
  final _dropKey = GlobalKey<FormState>();

  TextEditingController storeNameController;
  TextEditingController receiptTotalController;
  TextEditingController dateController;

  String shopName;
  String total;
  String receiptCategory;
  DateTime receiptDate;
  Receipt parsedReceipt;
  bool sendImage;

  ReceiptCategory selectedCategory;
  List<ReceiptCategory> categories = ReceiptCategoryFactory.get();

  ReceiptInputController(this.parsedReceipt, this.sendImage);

  @override
  void initState() {
    String initialStoreName = "";
    String initialTotalName = "";
    String initialDateController = "";
    if (parsedReceipt != null) {
      initialStoreName = parsedReceipt.shopName ?? '';
      initialTotalName = parsedReceipt.receiptTotal ?? '';
      initialDateController =
          DateManipulator.humanDate(parsedReceipt.receiptDate);
    }

    storeNameController = TextEditingController(text: initialStoreName);
    receiptTotalController = TextEditingController(text: initialTotalName);
    dateController = TextEditingController(text: initialDateController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showUpdateSuccess());
    return getMenu();
  }

  CustomScrollView getMenu() {
    return CustomScrollView(
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
                                  padding:
                                      const EdgeInsets.only(top: 16.0, left: 8),
                                  child: new Align(
                                      alignment: Alignment.bottomLeft,
                                      child: const Text(
                                        "Add new Receipt",
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
                                child: TextFormFactory.date(
                                    dateController, receiptDate, context))),
                            PaddingFactory.create(Container(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black)),
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
                                    items:
                                        categories.map((ReceiptCategory user) {
                                      return DropdownMenuItem<ReceiptCategory>(
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
    );
  }

  FloatingActionButton submitButton() {
    return new FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate() &&
              receiptCategory != null &&
              receiptCategory.isNotEmpty) {
            try {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Insert new receipt'),backgroundColor: Colors.green,));
              shopName = storeNameController.text;
              total = receiptTotalController.text;
            } catch (e) {
              reset();
              return;
            }

            // ignore: close_sinks
            final _bloc = BlocProvider.of<DbBloc>(context);
            _bloc.add(InsertEvent(receipt: Receipt(receiptTotal: total, category: receiptCategory, shopName: shopName)));
            _bloc.add(ReceiptAllFetch());
            _bloc.close();
            reset();

          } else {
            if (receiptCategory.isEmpty) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Please select a category.'),
                  backgroundColor: Colors.red));
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Input appears invaid.'),
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
