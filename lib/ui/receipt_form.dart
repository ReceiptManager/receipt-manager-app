import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';
import 'package:receipt_parser/bloc/moor/db_bloc.dart';
import 'package:receipt_parser/db/receipt_database.dart';
import 'package:receipt_parser/model/receipt_category.dart';

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

  // Main field controller handle every input in the form
  TextEditingController storeNameController;
  TextEditingController receiptTotalController;
  TextEditingController dateController;
  TextEditingController categoryController;

  // field variables
  String storeName;
  double total;
  DateTime receiptDate;
  ReceiptCategory receiptCategory;

  @override
  void initState() {
    storeNameController = TextEditingController();
    receiptTotalController = TextEditingController();
    dateController = TextEditingController();
    categoryController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Theme(data: getTheme(), child: storeNameTextfield())),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Theme(data: getTheme(), child: totalTextfield()),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Theme(data: getTheme(), child: dateTextfield()),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Theme(data: getTheme(), child: categoryTextfield()),
          ),
          new Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: const EdgeInsets.all(16.0), child: submitButton())),
        ],
      ),
    );
  }

  FloatingActionButton submitButton() {
    return new FloatingActionButton(
        onPressed: () {
          // TODO: fill required fields
          setState(() {
            if (storeNameController.text.isEmpty ||
                receiptTotalController.text.isEmpty ||
                categoryController.text.isEmpty ||
                dateController.text.isEmpty) {
              // input is clearly invalid returning
              // TODO: check input with regex
              return;
            }

            try {
              storeName = storeNameController.text;
              total = 1;
              receiptDate = DateTime.now();
            } catch (e) {
              print("Error at: " + context.toString());
              print(e.toString());
              reset();
              //return;
            }

            final _bloc = BlocProvider.of<DbBloc>(context);
            final Receipt receipt = new Receipt(
                shopName: storeName,
                receiptTotal: "233.00" as String,
                category: "d",
                receiptDate: receiptDate,
                id: 0);

            _bloc.dispatch(InsertEvent(receipt: receipt));
            _bloc.dispatch(ReceiptAllFetch());
            print("Inserted receipt successfull");
            print(receipt.toString());

            // reset controller
            reset();
          });
        },
        child: Icon(Icons.done_all),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueAccent);
  }

  IconButton _buildDateButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.calendar_today,
        color: Colors.white,
      ),
      onPressed: () async {
        receiptDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2010),
          lastDate: DateTime(2050),
        );

        setState(() {
          dateController.text = DateFormat("dd.MM.yyyy").format(receiptDate);
        });
      },
    );
  }

  TextField storeNameTextfield() {
    return new TextField(
      controller: storeNameController,
      style: TextStyle(color: Colors.white),
      decoration: new InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.white)),
        hintText: 'Store name',
        labelText: 'Store name',
        prefixIcon: const Icon(
          Icons.storefront_outlined,
          color: Colors.white,
        ),
        prefixText: ' ',
      ),
    );
  }

  TextField totalTextfield() {
    return new TextField(
      controller: receiptTotalController,
      style: TextStyle(color: Colors.white),
      decoration: new InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.white)),
        hintText: 'Total',
        labelText: 'Total',
        prefixIcon: const Icon(
          Icons.attach_money,
          color: Colors.white,
        ),
        prefixText: ' ',
      ),
    );
  }

  TextField categoryTextfield() {
    return new TextField(
      controller: categoryController,
      style: TextStyle(color: Colors.white),
      decoration: new InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.white)),
        hintText: 'Category',
        labelText: 'Category',
        prefixIcon: const Icon(
          Icons.category,
          color: Colors.white,
        ),
        prefixText: ' ',
      ),
    );
  }

  TextField dateTextfield() {
    return new TextField(
      controller: dateController,
      style: TextStyle(color: Colors.white),
      decoration: new InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.white)),
          hintText: 'Date',
          labelText: 'Date',
          prefixIcon: _buildDateButton(context),
          prefix: new Text(' ')),
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
    categoryController.clear();
    dateController.clear();
  }
}
