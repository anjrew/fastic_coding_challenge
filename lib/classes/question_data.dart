import 'package:flutter/material.dart';

import 'answer.dart';

class QuestionData {
  int number;
  String id;
  String text;
  bool multiplechoice;
  List<Answer> answers;

  QuestionData(
      {@required this.text,
      @required this.id,
      @required List<Answer> questionAnswers,
      @required this.number,
      @required this.multiplechoice}) {
    this.answers = [];

    questionAnswers.forEach((Answer ans) => answers.add(Answer(
          ans.id,
          text: ans.text,
          number: ans.number,
          isSelected: ans.isSelected,
          question: this,
        )));
  }

  static String questionIdKey = "question_id";
  static String questionTextKey = "question_text";
  static String multiplechoiceKey = "multiplechoice";
  static String answersKey = "answers";
}
