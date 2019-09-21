import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_questionnaire/logic/main_bloc.dart';

class StartPage extends StatelessWidget {
	
    @override
    Widget build(BuildContext context) {
        return Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                        Text("Welcome to the Nutrition questionnaire"),

                        MaterialButton(
                            child: Text("Start"),
                            onPressed: MainBloc.of(context).startQuestions,
                        )

                    ],
                ),
            ),
        );
    }
}
