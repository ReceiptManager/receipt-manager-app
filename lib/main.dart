import 'package:bloc/bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipt_parser/bloc/delegate/simple_delegate.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';
import 'package:receipt_parser/converter/color_converter.dart';
import 'package:receipt_parser/repository/repository.dart';
import 'package:receipt_parser/ui/history_widget.dart';
import 'package:receipt_parser/ui/home_widget.dart';
import 'package:receipt_parser/ui/settings_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database/receipt_database.dart';

SharedPreferences sharedPrefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  BlocSupervisor.delegate = SimpleDelegate();

  DbBloc _bloc;
  Repository _repository = Repository();
  _bloc = DbBloc(repository: _repository);
  BlocSupervisor.delegate = SimpleDelegate();

  runApp(MaterialApp(
    home: BlocProvider(
      builder: (_) => _bloc,
      child: HomeScreen(null, false),
    ),
    title: "Receipt parser",
    theme: ThemeData(primaryColor: HexColor.fromHex("#F9AA33")),
  ));
}

class HomeScreen extends StatefulWidget {
  Receipt receipt;
  bool sendImage;

  HomeScreen(this.receipt,this.sendImage);

  @override
  HomeScreenState createState() => HomeScreenState(receipt, sendImage);
}

class HomeScreenState extends State<HomeScreen> {
  Receipt receipt;
  bool sendImage;

  HomeScreenState(this.receipt, this.sendImage);

  int currentIndex = 0;
  Repository repository = Repository();
  DbBloc bloc;

  @override
  void initState() {
    bloc = DbBloc(repository: repository);
    bloc.dispatch(ReceiptAllFetch());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      HomeWidget(this.receipt, sendImage),
      HistoryWidget(),
      SettingsWidget(sharedPrefs)
    ];

    return Scaffold(
        appBar: AppBar(title: Text('Receipt parser app')),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: HexColor.fromHex("#232F34"),
          items: <Widget>[
            Icon(Icons.home, size: 30, color: HexColor.fromHex("#F9AA33")),
            Icon(Icons.history, size: 30, color: HexColor.fromHex("#F9AA33")),
            Icon(Icons.settings, size: 30, color: HexColor.fromHex("#F9AA33")),
          ],
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              this.currentIndex = index;
            });
          },
        ),
        body: _children[currentIndex]);
  }
}
