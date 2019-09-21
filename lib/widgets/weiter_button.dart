import 'package:flutter/material.dart';
import 'package:nutrition_questionnaire/logic/main_bloc.dart';

class WeiterButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,20),
          child: Center(
              child: SizedBox(
                      width: 150,
                      child: FlatButton(
                          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0)),
                          color: Theme.of(context).primaryColor,
                          child: Text(
                              "Weiter",
                              style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          onPressed: MainBloc.of(context).nextQuestion,
                      )),
          ),
        );
    }
}
