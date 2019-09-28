import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_questionnaire/pages/home.dart';
import 'package:nutrition_questionnaire/utlis/theme.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';
import 'logic/main_bloc.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  MainBloc _mainBloc;

  @override
  void initState() {
    super.initState();
    _mainBloc = MainBloc();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ScopedModel(
      model: _mainBloc,
      child: MaterialApp(
        title: 'Nutrition Questionnaire',
        theme: mainTheme,
        home: Home(),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: _mainBloc.analytics)
        ],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
