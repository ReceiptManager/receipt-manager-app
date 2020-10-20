import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';
import 'package:receipt_parser/database/receipt_database.dart';
import 'package:receipt_parser/generated/l10n.dart';
import 'package:receipt_parser/repository/repository.dart';
import 'package:receipt_parser/theme/color/color.dart';
import 'package:receipt_parser/theme/theme_manager.dart';
import 'package:receipt_parser/ui/history_widget.dart';
import 'package:receipt_parser/ui/home_widget.dart';
import 'package:receipt_parser/ui/settings_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

// -----------------------------------------------------------------------------

// Initialise shared preferences which handle all basic
// settings
SharedPreferences sharedPrefs;

// Database repository to access the database
final Repository _repository = Repository();
DbBloc _bloc;

// -----------------------------------------------------------------------------

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  _bloc = DbBloc(repository: _repository);
  _bloc.add(ReceiptAllFetch());

  runApp(MaterialApp(
      localizationsDelegates: [
        // 1
        S.delegate,
        // 2
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: HomeScreen(null, false),
      theme: AppTheme.lightTheme));
}

class HomeScreen extends StatefulWidget {
  final ReceiptsCompanion receipt;
  final bool sendImage;

  HomeScreen(this.receipt, this.sendImage);

  @override
  HomeScreenState createState() => HomeScreenState(receipt, sendImage);
}

// -----------------------------------------------------------------------------

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey _bottomNavigationKey = GlobalKey();

  // current receipt
  final ReceiptsCompanion receipt;
  final bool sendImage;

  // set current body index
  int currentIndex = 0;

  HomeScreenState(this.receipt, this.sendImage);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      HomeWidget(this.receipt, sendImage, sharedPrefs, _bloc),
      HistoryWidget(_bloc),
      SettingsWidget(sharedPrefs, _bloc)
    ];

    return Scaffold(
        appBar: AppBar(title: Text(S.of(context).appBarTitle)),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.add, color: Colors.white, size: 30),
            Icon(Icons.history, color: Colors.white, size: 30),
            Icon(Icons.settings, color: Colors.white, size: 30),
          ],
          color: LightColor.brighter,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        body: _children[currentIndex]);
  }
}

// -----------------------------------------------------------------------------