import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home.dart';
import 'logic/main_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    static FirebaseAnalytics analytics = FirebaseAnalytics();
    static FirebaseAnalyticsObserver observer =
            FirebaseAnalyticsObserver(analytics: analytics);
    final MainBloc _mainBloc = MainBloc();

    @override
    Widget build(BuildContext context) {
        return ScopedModel(
            model: _mainBloc,
            child: MaterialApp(
                title: 'Nutrition Questionnaire',
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                ),
                home: Home(),
                navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
				debugShowCheckedModeBanner: false,
            ),
        );
    }
}
