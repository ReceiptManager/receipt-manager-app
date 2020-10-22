/*
 * Copyright (c) 2020 - William Todt
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';
import 'package:receipt_parser/bloc/moor/db_bloc.dart';
import 'package:receipt_parser/database/receipt_database.dart';
import 'package:receipt_parser/factory/categories_factory.dart';
import 'package:receipt_parser/model/receipt_category.dart';

class DeveloperSettings extends StatefulWidget {
  final DbBloc _bloc;

  const DeveloperSettings(this._bloc);

  @override
  _DeveloperSettingsState createState() => _DeveloperSettingsState(_bloc);
}

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(4, 1),
];

class _DeveloperOperationTile extends StatelessWidget {
  const _DeveloperOperationTile(
      this.backgroundColor, this.iconData, this._function);

  final Color backgroundColor;
  final IconData iconData;
  final Function _function;

  @override
  Widget build(BuildContext context) {
    return new Card(
        color: backgroundColor,
        child: new InkWell(
            onTap: () {
              _function(context);
            },
            child: Center(
                child: new Icon(
              iconData,
              color: Colors.white,
              size: 50,
            ))));
  }
}

DbBloc bloc;

class _DeveloperSettingsState extends State<DeveloperSettings> {
  final DbBloc _bloc;

  _DeveloperSettingsState(this._bloc);

  @override
  void initState() {
    bloc = _bloc;
    super.initState();
  }

  List<Widget> _tiles = const <Widget>[
    const _DeveloperOperationTile(Colors.green, Icons.add, add),
    const _DeveloperOperationTile(Colors.red, Icons.delete, nuke),
    /*
      const _DeveloperOperationTile(
          Color.fromARGB(255, 35, 47, 62), Icons.panorama_wide_angle, todo),
      const _DeveloperOperationTile(
          Color.fromARGB(255, 35, 47, 62), Icons.map, todo),
      const _DeveloperOperationTile(
          Color.fromARGB(255, 35, 47, 62), Icons.send, todo),
      const _DeveloperOperationTile(
          Color.fromARGB(255, 35, 47, 62), Icons.airline_seat_flat, todo),
      const _DeveloperOperationTile(
          Color.fromARGB(255, 35, 47, 62), Icons.bluetooth, todo),
      const _DeveloperOperationTile(
          Color.fromARGB(255, 35, 47, 62), Icons.battery_alert, todo),
      const _DeveloperOperationTile(
          Color.fromARGB(255, 35, 47, 62), Icons.desktop_windows, todo),
      const _DeveloperOperationTile(
          Color.fromARGB(255, 35, 47, 62), Icons.radio, todo),

       */
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Developer settings')),
        body: BlocProvider(
          create: (_) => _bloc,
          child: Container(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: new StaggeredGridView.count(
                        crossAxisCount: 4,
                        staggeredTiles: _staggeredTiles,
                        children: _tiles,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        padding: const EdgeInsets.all(4.0),
                      )))),
        ));
  }
}

add(BuildContext context) {
  ReceiptCategory _category =  ReceiptCategoryFactory.categories.first;

  bloc.add(InsertEvent(
      receipt: ReceiptsCompanion(
          date: Value(DateTime.now()),
          total: Value("100.00"),
          category: Value(jsonEncode(_category)),
          shop: Value("DEBUG EVENT"))));
  bloc.add(ReceiptAllFetch());

  Scaffold.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text("Add debug entry in database."),
      backgroundColor: Colors.green,
    ));
}

nuke(BuildContext context) {
  bloc.add(DeleteAllEvent());
  bloc.add(ReceiptAllFetch());

  Scaffold.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text("Erase all entries in database."),
      backgroundColor: Colors.red,
    ));
}

todo(BuildContext context) {
  Scaffold.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text("Feature is not implemented."),
      backgroundColor: Colors.orange,
    ));
}
