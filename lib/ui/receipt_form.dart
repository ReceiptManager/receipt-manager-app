import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';
import 'package:receipt_parser/bloc/moor/db_bloc.dart';
import 'package:receipt_parser/db/receipt_database.dart';
import 'package:receipt_parser/model/receipt_category.dart';

import '../main.dart';
import 'camera_picker.dart';

class EmptyReceiptForm extends StatefulWidget {
  @override
  ReceiptInputController createState() {
    return ReceiptInputController();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ReceiptInputController extends State<EmptyReceiptForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final _dropKey = GlobalKey<FormState>();

  // Main field controller handle every input in the form
  TextEditingController storeNameController;
  TextEditingController receiptTotalController;
  TextEditingController dateController;
  TextEditingController categoryController;

  // field variables
  String storeName;
  String total;
  String receiptCategory;
  DateTime receiptDate;

  ReceiptCategory selectedCategory;
  List<ReceiptCategory> categories = <ReceiptCategory>[
    const ReceiptCategory(
        'Grocery', Icon(Icons.shopping_bag_outlined, color: Colors.white)),
    const ReceiptCategory('Education', Icon(Icons.school, color: Colors.white)),
    const ReceiptCategory(
        'Books', Icon(Icons.book_rounded, color: Colors.white)),
    const ReceiptCategory(
        'Sport', Icon(Icons.mobile_screen_share, color: Colors.white)),
  ];

  @override
  void initState() {
    storeNameController = TextEditingController();
    receiptTotalController = TextEditingController();
    dateController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
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
                      color: Colors.blueAccent,
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
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  )),
                              new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: new Icon(Icons.camera_alt,
                                            size: 35),
                                        color: Colors.white,
                                        onPressed: () async {
                                          WidgetsFlutterBinding
                                              .ensureInitialized();

                                          // Obtain a list of the available cameras on the device.
                                          final cameras =
                                              await availableCameras();

                                          // Get a specific camera from the list of available cameras.
                                          final firstCamera = cameras.first;

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TakePictureScreen(
                                                      sharedPrefs: sharedPrefs,
                                                      // Pass the appropriate camera to the TakePictureScreen widget.
                                                      camera: firstCamera),
                                            ),
                                          );
                                        },
                                      )))
                            ]),
                            new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Theme(
                                    data: getTheme(),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: new InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.white)),
                                        hintText: 'Store name',
                                        labelText: 'Store name',
                                        helperText: "Set the store name",
                                        prefixIcon: const Icon(
                                          Icons.storefront_outlined,
                                          color: Colors.white,
                                        ),
                                        prefixText: ' ',
                                      ),
                                      controller: storeNameController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter a store name.';
                                        }
                                        return null;
                                      },
                                    ))),
                            new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Theme(
                                    data: getTheme(),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.number,
                                      decoration: new InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.white)),
                                        hintText: 'Receipt total',
                                        labelText: 'Receipt total',
                                        helperText: "Set the receipt total",
                                        prefixIcon: const Icon(
                                          Icons.attach_money,
                                          color: Colors.white,
                                        ),
                                        prefixText: ' ',
                                      ),
                                      controller: receiptTotalController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some total.';
                                        }
                                        RegExp totalRegex = new RegExp(
                                            "^(?=.*[1-9])[0-9]*[.]?[0-9]{2}\$",
                                            caseSensitive: false,
                                            multiLine: false);

                                        if (!totalRegex.hasMatch(value)) {
                                          return "Total is invalid.";
                                        }

                                        return null;
                                      },
                                    ))),
                            new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Theme(
                                    data: getTheme(),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.number,
                                      decoration: new InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.white)),
                                          hintText: 'Receipt date',
                                          labelText: 'Receipt date',
                                          helperText: "Set the receipt date",
                                          prefixIcon:
                                              _buildDateButton(context)),
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
                            new Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: DropdownButton<ReceiptCategory>(
                                        key: _dropKey,
                                        dropdownColor: Colors.blueAccent,
                                        style: TextStyle(color: Colors.grey),
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
                  .showSnackBar(SnackBar(content: Text('Insert new receipt')));
              storeName = storeNameController.text;
              total = receiptTotalController.text;
            } catch (e) {
              reset();
              return;
            }

            final _bloc = BlocProvider.of<DbBloc>(context);
            final Receipt receipt = new Receipt(
                shopName: storeName,
                receiptTotal: total,
                category: receiptCategory,
                receiptDate: receiptDate);

            _bloc.dispatch(InsertEvent(receipt: receipt));
            _bloc.dispatch(ReceiptAllFetch());

            reset();
          } else {
            if (receiptCategory.isEmpty) {
              Scaffold.of(context)
                  .showSnackBar(
                  SnackBar(content: Text('Please select a category.'),
                      backgroundColor: Colors.red));
            } else {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Input appears invaid.'),
                  backgroundColor: Colors.red));
            }
          }
        },
        child: Icon(Icons.done_all),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueAccent);
  }

  IconButton _buildDateButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.calendar_today,
        color: Colors.purple,
      ),
      onPressed: () async {
        receiptDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime(2050));
        setState(() {
          dateController.text = DateFormat("dd.MM.yyyy").format(receiptDate);
        });
      },
    );
  }

  ThemeData getTheme() {
    return new ThemeData(
      primaryColor: Colors.white,
      primaryColorDark: Colors.white,
    );
  }

  void reset() {
    receiptTotalController.clear();
    storeNameController.clear();
    dateController.clear();
  }
}
