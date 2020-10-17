import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';
import 'package:receipt_parser/converter/color_converter.dart';
import 'package:receipt_parser/database/receipt_database.dart';
import 'package:receipt_parser/repository/repository.dart';
import 'package:receipt_parser/theme/theme_manager.dart';
import 'package:receipt_parser/ui/history_widget.dart';
import 'package:receipt_parser/ui/home_widget.dart';
import 'package:receipt_parser/ui/settings_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPrefs;
final Repository _repository = Repository();
DbBloc _bloc;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  _bloc = DbBloc(repository: _repository);
  _bloc.add(ReceiptAllFetch());

  runApp(MaterialApp(
      home: HomeScreen(null, false),
      color: Colors.white,
      title: Text('Saved Suggestions', style: TextStyle(color: Colors.white))
          .toStringShort(),
      theme: ThemeManager.getTheme()));
}

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  ReceiptsCompanion receipt;
  bool sendImage;

  HomeScreen(this.receipt, this.sendImage);

  @override
  HomeScreenState createState() => HomeScreenState(receipt, sendImage);
}

class HomeScreenState extends State<HomeScreen> {
  final ReceiptsCompanion receipt;
  final bool sendImage;

  HomeScreenState(this.receipt, this.sendImage);

  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      HomeWidget(this.receipt, sendImage, sharedPrefs, _bloc),
      HistoryWidget(_bloc),
      SettingsWidget(sharedPrefs)
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Receipt manager')),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: HexColor.fromHex("#232F34"),
        items: <Widget>[
          Icon(Icons.home, size: 30, color: HexColor.fromHex("#F9AA33")),
          Icon(Icons.history, size: 30, color: HexColor.fromHex("#F9AA33")),
          Icon(Icons.settings, size: 30, color: HexColor.fromHex("#F9AA33")),
        ],
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 200),
        onTap: (index) {
          setState(() {
            this.currentIndex = index;
          });
        },
      ),
      //  body: _children[currentIndex]);
      body: _children[currentIndex],
    );
  }
}
