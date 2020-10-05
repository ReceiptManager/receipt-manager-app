import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWidget extends StatelessWidget {
  final _textController = TextEditingController();
  ScrollController scrollController;
  bool scrollVisible = true;
  var appBarTitleText = new Text("3");

  HomeWidget(SharedPreferences sharedPrefs);

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    scrollVisible = value;
  }

  @override
  void dispose() {
    _textController.dispose();
  }

  BoomMenu buildBoomMenu() {
    return BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        //child: Icon(Icons.add),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        scrollVisible: scrollVisible,
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        children: [
          MenuItem(
            child: Icon(
              Icons.camera_alt,
              color: Colors.black,
              size: 40,
            ),
            title: "Camera",
            titleColor: Colors.blueAccent,
            subtitle: "Use your camera to scan your receipt.",
            subTitleColor: Colors.black,
            backgroundColor: Colors.white,
            // TODO: implement clicker
          ),
          MenuItem(
            child: Icon(
              Icons.edit,
              color: Colors.black,
              size: 40,
            ),
            title: "Manual",
            titleColor: Colors.blueAccent,
            subtitle: "Track your receipt manually.",
            subTitleColor: Colors.black,
            backgroundColor: Colors.white,
            // TODO: implement clicker
          ),
        ]);
  }

  Widget buildBody() {
    return Container(
      color: Colors.blueAccent,
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.white)),
                child:
                    const Text('New receipt', style: TextStyle(fontSize: 20)),
                color: Colors.white,
                textColor: Colors.blueAccent,
                elevation: 5,
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      floatingActionButton: buildBoomMenu(),
    );
  }
}
