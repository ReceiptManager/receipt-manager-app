import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

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
              child: new Theme(
                  data: new ThemeData(
                    primaryColor: Colors.white,
                    primaryColorDark: Colors.white,
                  ),
                  child: new TextField(
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
                      helperText: 'Submit the store name.',
                      labelText: 'Store name',
                      prefixIcon: const Icon(
                        Icons.storefront_outlined,
                        color: Colors.white,
                      ),
                      prefixText: ' ',
                    ),
                  ))),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Theme(
                data: new ThemeData(
                  primaryColor: Colors.white,
                  primaryColorDark: Colors.white,
                ),
                child: new TextField(
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
                    helperText: 'Submit the total.',
                    labelText: 'Total',
                    prefixIcon: const Icon(
                      Icons.attach_money,
                      color: Colors.white,
                    ),
                    prefixText: ' ',
                  ),
                )),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Theme(
                data: new ThemeData(
                  primaryColor: Colors.white,
                  primaryColorDark: Colors.white,
                ),
                child: new TextField(
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
                    helperText: 'Submit the receipt date.',
                    labelText: 'Date',
                    prefixIcon: const Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    prefixText: ' ',
                  ),
                )),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Theme(
                data: new ThemeData(
                  primaryColor: Colors.white,
                  primaryColorDark: Colors.white,
                ),
                child: new TextField(
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
                    helperText: 'Submit the receipt category.',
                    labelText: 'Category',
                    prefixIcon: const Icon(
                      Icons.category,
                      color: Colors.white,
                    ),
                    prefixText: ' ',
                  ),
                )),
          ),
          new Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.done_all),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueAccent))),
        ],
      ),
    );
  }
}
