import 'package:flutter/material.dart';
import 'package:nutrition_questionnaire/classes/answer.dart';
import 'package:nutrition_questionnaire/classes/question_data.dart';
import 'package:nutrition_questionnaire/logic/main_bloc.dart';

class QuestionPage extends StatelessWidget {
    final QuestionData data;
	final String headerImg;

    QuestionPage({@required this.data, @required this.headerImg}): super(key: Key(data.id));

    @override
    Widget build(BuildContext context) {
        return Stack(children: [
			
            ListView(
                padding: null,
                children: <Widget>[
                    Image.asset(
                        headerImg,
                        fit: BoxFit.cover,
                        width: double.infinity,
                    ),
                    Text(
                        data.text,
                        style: Theme.of(context).textTheme.display2,
                        textAlign: TextAlign.center,
                    ),
                    Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: data.answers
                                    .map((Answer answer) => AnswerTile(
                                            key: Key(answer.hashCode.toString()),
                                            index: 2,
                                            answer: answer,
											))
                                    .toList()),

                    MaterialButton(
                        child: Text("Weiter"),
                        onPressed: MainBloc.of(context).nextQuestion,
                    )
                ],
            ),

			Positioned(
				left: 10,
				width: 50,
				top: 50,
				height: 50,
				child: IconButton(icon: Icon(Icons.arrow_back_ios),
				onPressed: MainBloc.of(context).previousQuestion,),
			),
        ]);
    }
}

class AnswerTile extends StatelessWidget {
    final Answer answer;
    final int index;

    const AnswerTile({@required Key key, @required this.answer, @required this.index,}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return ListTile(
            leading: Container(
                decoration:
                        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25))),
                child: AnimatedOpacity(
                    child: Icon(Icons.done),
                    opacity: answer.isSelected ? 1.0 : 1.0,
                    duration: Duration(milliseconds: 300),
                ),
            ),
            title: Text(answer.text),
            onTap: () => MainBloc.of(context).setAnswer(answer)
        );
    }
}
