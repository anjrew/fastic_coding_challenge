import 'package:flutter/material.dart';
import 'package:nutrition_questionnaire/classes/answer.dart';
import 'package:nutrition_questionnaire/classes/question_data.dart';
import 'package:nutrition_questionnaire/logic/main_bloc.dart';
import 'package:nutrition_questionnaire/widgets/back_button.dart';
import 'package:nutrition_questionnaire/widgets/weiter_button.dart';

class QuestionPage extends StatelessWidget {
    final QuestionData data;
    final String headerImg;

    QuestionPage({@required this.data, @required this.headerImg})
            : super(key: Key(data.id));

    @override
    Widget build(BuildContext context) {
        return Stack(children: [
            MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
					padding: null,
					shrinkWrap: true,
                    children: <Widget>[

                        Image.asset(
                            headerImg,
                            fit: BoxFit.cover,
                            width: double.infinity,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              data.text,
                              style: Theme.of(context).textTheme.display1,
							softWrap: true,
                              textAlign: TextAlign.center,
                          ),
                        ),

                        Column(
							mainAxisAlignment: MainAxisAlignment.center,
							crossAxisAlignment: CrossAxisAlignment.center,
							children: data.answers.map((Answer answer) => AnswerTile(
												key: Key(answer.hashCode.toString()),
												index: 2,
												answer: answer,
											))
									.toList()),

                        WeiterButton()

                    ],
                ),
            ),

            ArrowBackButton()

        ]);
    }
}

class AnswerTile extends StatelessWidget {
    final Answer answer;
    final int index;

    const AnswerTile({
        @required Key key,
        @required this.answer,
        @required this.index,
    }) : super(key: key);

	@override
    Widget build(BuildContext context) {
        return InkWell(
			onTap: () => MainBloc.of(context).setAnswer(answer),
			child:Container(
				padding: EdgeInsets.all(15),
				margin: EdgeInsets.all(10),
				decoration: BoxDecoration(
						borderRadius: BorderRadius.all(Radius.circular(25)),
						color: Color.fromRGBO(251, 248, 241, 1.0),),
                    child: Row(
						children: <Widget>[
							
							Container(
								decoration: BoxDecoration(
									borderRadius: BorderRadius.all(Radius.circular(25)),
									border: Border.all(color: Color.fromRGBO(234, 231, 224, 1.0), width: 2)),
									child: AnimatedOpacity(
										child: Icon(Icons.done),
										opacity: answer.isSelected ? 1.0 : 0.0,
										duration: Duration(milliseconds: 300),
									),),

							Padding(
								padding: EdgeInsets.symmetric(horizontal: 10),
								child:Text(answer.text),),
							
						],
					)
                ),);         
    }
}
