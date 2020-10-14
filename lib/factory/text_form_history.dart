import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipt_parser/converter/color_converter.dart';
import 'package:receipt_parser/factory/button_factory.dart';

class TextFormFactory {
  static TextFormField date(TextEditingController dateController,
      DateTime receiptDate, BuildContext context) {
    return TextFormField(
      style: TextStyle(color: HexColor.fromHex("#232F34")),
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor.fromHex("#232F34")),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor.fromHex("#232F34")),
          ),
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: HexColor.fromHex("#232F34"))),
          hintText: 'dd.MM.YYYY',
          labelText: 'Receipt date',
          helperText: "Set the receipt date",
          prefixIcon: ButtonFactory.buildDateButton(
              receiptDate, dateController, context)),
      controller: dateController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some date';
        }
        RegExp totalRegex = new RegExp(
            "^(0?[1-9]|[12][0-9]|3[01])[.\\/ ]?(0?[1-9]|1[0-2])[./ ]?(?:19|20)[0-9]{2}\$",
            caseSensitive: false,
            multiLine: false);

        if (!totalRegex.hasMatch(value.trim())) {
          return "Date is not formatted (dd.MM.YYYY).";
        }

        return null;
      },
    );
  }

  static TextFormField total(TextEditingController receiptTotalController) {
    return TextFormField(
      style: TextStyle(color: HexColor.fromHex("#232F34")),
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor.fromHex("#232F34")),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor.fromHex("#232F34")),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: HexColor.fromHex("#232F34"))),
        hintText: 'Receipt total',
        labelText: 'Receipt total',
        helperText: "Set the receipt total",
        prefixIcon: const Icon(
          Icons.attach_money,
        ),
        prefixText: ' ',
      ),
      controller: receiptTotalController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some total.';
        }
        RegExp totalRegex = new RegExp("^(?=.*[1-9])[0-9]*[.]?[0-9]{2}\$",
            caseSensitive: false, multiLine: false);

        if (!totalRegex.hasMatch(value)) {
          return "Total is invalid.";
        }

        return null;
      },
    );
  }

  static TextFormField storeName(TextEditingController storeNameController) {
    return TextFormField(
      style: TextStyle(color: HexColor.fromHex("#232F34")),
      decoration: new InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor.fromHex("#232F34")),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor.fromHex("#232F34")),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: HexColor.fromHex("#232F34"))),
        hintText: 'Store name',
        labelText: 'Store name',
        helperText: "Set the store name",
        prefixIcon: const Icon(Icons.storefront_outlined),
        prefixText: ' ',
      ),
      controller: storeNameController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a store name.';
        }
        return null;
      },
    );
  }
}
