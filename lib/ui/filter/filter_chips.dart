import 'package:flutter/material.dart';
import 'package:receipt_manager/factory/categories_factory.dart';
import 'package:receipt_manager/factory/padding_factory.dart';
import 'package:random_color/random_color.dart';



class FilterChipScreen extends StatefulWidget {
  @override
  _FilterChipScreenState createState() => _FilterChipScreenState();
}

class _FilterChipScreenState extends State<FilterChipScreen> {
  var data = ReceiptCategoryFactory.categories;
  var selected = [];

  RandomColor _rand = RandomColor();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) =>
                PaddingFactory.create(
                  FilterChip(
                    label: Text(data[index].name),
                    onSelected: (bool value) {
                      if (selected.contains(index)) {
                        selected.remove(index);
                      } else {
                        selected.add(index);
                      }
                      setState(() {});
                    },
                    selected: selected.contains(index),
                    selectedColor: Colors.red,
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    backgroundColor: _rand.randomColor(colorHue: ColorHue.blue),
                  ),
                )),
      ),
    );
  }
}
