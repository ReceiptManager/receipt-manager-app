/*
 *  Copyright (c) 2020 - William Todt
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:receipt_manager/factory/categories_factory.dart';
import 'package:receipt_manager/factory/padding_factory.dart';



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
    );
  }
}
