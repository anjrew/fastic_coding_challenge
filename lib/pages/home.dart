import 'package:flutter/material.dart';
import 'package:nutrition_questionnaire/classes/question_data.dart';
import 'package:nutrition_questionnaire/classes/response.dart';
import 'package:nutrition_questionnaire/logic/main_bloc.dart';
import 'package:nutrition_questionnaire/pages/question_page.dart';
import 'package:nutrition_questionnaire/pages/start_page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
	  MainBloc bloc = MainBloc.of(context);
	return FutureBuilder<List<QuestionData>>(
        future: bloc.getRemoteConfigData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          
		  return snapshot.hasData
              ? Scaffold(
				body: PageView(
					controller: bloc.pageController,
					children: <Widget>[

						StartPage(showStartButton: snapshot.hasData,),

						...bloc.questionData.map((QuestionData data) =>
							QuestionPage(
								headerImg: "assets/graphics/headers/question_1_header/question_1_header.png",
								data: data,
							)
						).toList(),

						LastPage()

					],
				),
			) : Container();
        },
      );
	}
}