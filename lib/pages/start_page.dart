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

                        Text("Welcome to the Nutrition Questionnaire",
							style: Theme.of(context).textTheme.display2,
							textAlign: TextAlign.center,),

						Image.asset("assets/graphics/launcher_icon.png"),

                        AnimatedOpacity(
							opacity: showStartButton ? 1.0 : 0.0,
							duration: Duration(milliseconds: 300),
							curve: Curves.easeInOut,
							child: FlatButton(
								padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                                shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(30.0)),
                                color: Theme.of(context).primaryColor,
                            	child: Text("Start", style: TextStyle(fontSize: 20), ),
                            	onPressed: MainBloc.of(context).startQuestions,
                        	)
						)
                    ],
                ),
            ),
        );
    }
}
