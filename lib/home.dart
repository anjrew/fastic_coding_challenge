import 'package:flutter/material.dart';
import 'package:nutrition_questionnaire/classes/answer.dart';
import 'package:nutrition_questionnaire/classes/question_page_data.dart';
import 'package:nutrition_questionnaire/logic/main_bloc.dart';
import 'package:nutrition_questionnaire/pages/question_page.dart';
import 'package:nutrition_questionnaire/pages/start_page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

	return Scaffold(
		body: PageView(
			controller: MainBloc.of(context).pageController,
			children: <Widget>[

				StartPage(),

				QuestionPage(
					data: QuestionsPageData(
						// headerImg: Images.getImage(image: ,sceenSize: ),
						headerImg: 'assets/graphics/headers/question_1_header/question_1_header.png',
						question: "Do you like cheese?",
						answers: [ 
							Answer("Yes", isSelected: false) 
						]
						),
				)
			],
		),
	);
	}
}