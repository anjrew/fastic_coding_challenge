import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_questionnaire/logic/main_bloc.dart';

class StartPage extends StatelessWidget {
	
	final bool showStartButton;

	StartPage({@required this.showStartButton});

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

                        AnimatedOpacity(
							opacity: showStartButton ? 1.0 : 0.0,
							duration: Duration(milliseconds: 300),
							curve: Curves.easeInOut,
							child: MaterialButton(
                            	child: Text("Start"),
                            	onPressed: MainBloc.of(context).startQuestions,
                        	)
						)
                    ],
                ),
            ),
        );
    }
}
