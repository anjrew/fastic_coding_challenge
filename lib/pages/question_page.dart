import 'package:dots_indicator/dots_indicator.dart';
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: Text(
                data.text,
                style: Theme.of(context).textTheme.title,
                softWrap: true,
                textAlign: TextAlign.left,
              ),
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
            Center(
              child: DotsIndicator(
                dotsCount: MainBloc.of(context).amountOfQuestions,
                position: data.number,
                decorator: DotsDecorator(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  activeColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
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
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Color.fromRGBO(251, 248, 210, 1.0),
      ),
      child: InkWell(
        onTap: () => MainBloc.of(context).setAnswer(answer),
        child: Row(
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  color: answer.isSelected
                      ? Theme.of(context).primaryColor
                      : Color.fromRGBO(0, 0, 0, 0),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(
                      color: Color.fromRGBO(234, 231, 224, 1.0), width: 2)),
              child: AnimatedOpacity(
                  opacity: answer.isSelected ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                  )),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  child: Text(
                    answer.text,
                    maxLines: 10,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
