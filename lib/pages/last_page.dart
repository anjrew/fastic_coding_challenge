import 'package:flutter/material.dart';
import 'package:nutrition_questionnaire/logic/main_bloc.dart';
import 'package:nutrition_questionnaire/widgets/back_button.dart';

class LastPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {

        return Stack(children: [
			
			Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                        Padding(
							padding: EdgeInsets.symmetric(horizontal:10),
							child:Text("Submit Your results",
                            style: Theme.of(context).textTheme.display2,
                            textAlign: TextAlign.center,
                        ),),

                         Padding(
							padding: EdgeInsets.all(10),
							child:Icon(Icons.done_all, size: 200,),),

                        FlatButton(
                            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                            shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0)),
                            color: Theme.of(context).primaryColor,
                            child: Text("Submit"),
                            onPressed: () => submitAction(context),
                        )
                    ],
                ),
            ),
        ),

		ArrowBackButton()
		]);
    }

	void submitAction(BuildContext context){
		if(!MainBloc.of(context).trySubmitAnswers()){
			Scaffold.of(context).showSnackBar(SnackBar(
				content: Text("Please answer all the questions."),
			));
		} else {
			Scaffold.of(context).showSnackBar(SnackBar(
				content: Text("Submitted successfully."),
			));
		}
	}
}
