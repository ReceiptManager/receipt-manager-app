import 'package:flutter/material.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

class AutocompleteWidget extends StatelessWidget {
  final List<String> storeNameList;
  final TextEditingController controller;
  final String hintText;
  final String helperText;
  final String labelText;
  final Icon icon;

  AutocompleteWidget(
      {@required this.storeNameList,
      @required this.controller,
      @required this.hintText,
      @required this.helperText,
      @required this.labelText,
      @required this.icon});

  List<String> _buildAutoCompleteList(String search) {
    return storeNameList
        .where((_storeName) =>
            _storeName.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  _buildItemCompleteList(String string) {
    return storeNameList.singleWhere(
        (_storeName) => _storeName.toLowerCase() == string.toLowerCase(),
        orElse: () => null);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleAutocompleteFormField<String>(
      style: TextStyle(color: Colors.black),
      decoration: new InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[100]),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey[100])),
        hintText: this.hintText,
        labelText: this.labelText,
        helperText: this.helperText,
        prefixIcon: this.icon,
        prefixText: ' ',
      ),
      maxSuggestions: 5,
      itemBuilder: (context, _storeName) => Padding(
        padding: EdgeInsets.only(top: 16, left: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(_storeName, style: TextStyle(color: Colors.black, fontSize: 16)),
        ]),
      ),
      controller: controller,
      onSearch: (search) async => _buildAutoCompleteList(search),
      itemFromString: (string) => _buildItemCompleteList(string),
    );
  }
}
