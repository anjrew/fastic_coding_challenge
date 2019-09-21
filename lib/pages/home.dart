import 'package:flutter/material.dart';
import 'package:nutrition_questionnaire/classes/question_data.dart';
import 'package:nutrition_questionnaire/logic/main_bloc.dart';
import 'package:nutrition_questionnaire/pages/last_page.dart';
import 'package:nutrition_questionnaire/pages/question_page.dart';
import 'package:nutrition_questionnaire/pages/start_page.dart';

class Home extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        MainBloc bloc = MainBloc.of(context);
        bloc.setDeviceSize(MediaQuery.of(context).size.width);

        return StreamBuilder<List<QuestionData>>(
            stream: bloc.questionsStream(),
            builder: (BuildContext context, AsyncSnapshot<List<QuestionData>> snapshot) {
                return Scaffold(
                                body: snapshot.hasData
                        ? PageView(
                                    controller: bloc.pageController,
                                    children: <Widget>[

                                        StartPage(showStartButton: snapshot.hasData, ),

                                        ...snapshot.data
                                                .map((QuestionData data) => QuestionPage(
                                                            headerImg: bloc.getHeaderImage(data.id),
                                                            data: data,
                                                        ))
                                                .toList(),

                                        LastPage()
                                    ],
                                ) : StartPage(showStartButton: snapshot.hasData,)
                            );
            },
        );
    }
}
