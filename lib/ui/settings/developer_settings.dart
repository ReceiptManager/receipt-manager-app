import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:receipt_parser/bloc/moor/db_bloc.dart';
import 'package:receipt_parser/bloc/moor/db_event.dart';
import 'package:receipt_parser/database//receipt_database.dart';

class DeveloperSettings extends StatefulWidget {
  @override
  _DeveloperSettingsState createState() => _DeveloperSettingsState();
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

List<Widget> _tiles = const <Widget>[
  const _DeveloperOperationTile(Colors.black, Icons.add, add),
  const _DeveloperOperationTile(Colors.black, Icons.clear, nuke),
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

class _DeveloperSettingsState extends State<DeveloperSettings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Developer settings')),
      body: Container(
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
    );
  }
}

add(BuildContext context) {
  final _bloc = BlocProvider.of<DbBloc>(context);
  _bloc.add(InsertEvent(
      receipt: Receipt(
          receiptDate: DateTime.now(),
          receiptTotal: "14.21",
          category: "Grocery",
          shopName: "Rewe Karlsruhe",
          id: 0)));
  _bloc.add(ReceiptAllFetch());
  _bloc.close();
}

nuke() {}
