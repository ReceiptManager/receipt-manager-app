import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
  const _DeveloperOperationTile(Colors.green, Icons.add, add),
  const _DeveloperOperationTile(Colors.red, Icons.delete, nuke),
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
  Scaffold.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text("Add debug entry in database."),
      backgroundColor: Colors.green,
    ));
}

nuke(BuildContext context) {
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
