import 'package:bloc/bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipt_parser/bloc/delegate/simple_delegate.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';
import 'package:receipt_parser/repository/repository.dart';
import 'package:receipt_parser/ui/history_widget.dart';
import 'package:receipt_parser/ui/home_widget.dart';
import 'package:receipt_parser/ui/settings_widget.dart';
import 'package:receipt_parser/ui/stats_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      child: HomeScreen(),
    ),
    title: "Receipt parser",
    theme: ThemeData(primaryColor: Colors.indigoAccent),
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final List<Widget> _children = [
    HomeWidget(sharedPrefs),
    HistoryWidget(),
    StatsWidget(),
    SettingsWidget(sharedPrefs)
  ];

  int _curent_index = 0;
  Repository _repository = Repository();
  DbBloc _bloc;

  @override
  void initState() {
    _bloc = DbBloc(repository: _repository);
    _bloc.dispatch(ReceiptAllFetch());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Scan receipt')),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.blueAccent,
          color: Colors.white,

          items: <Widget>[
            Icon(Icons.home, size: 30, color: Colors.black),
            Icon(Icons.history, size: 30, color: Colors.black),
            Icon(Icons.pie_chart, size: 30, color: Colors.black),
            Icon(Icons.settings, size: 30, color: Colors.black),
          ],
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              this._curent_index = index;
            });
          },
        ),
        body: _children[_curent_index]);
  }
}
