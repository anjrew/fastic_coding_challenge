import 'package:flutter/foundation.dart';
import 'package:nutrition_questionnaire/classes/question_data.dart';

class Answer {
    final String id;
    final String text;
    int number;
    bool isSelected;
    QuestionData question;
    Answer(this.id,
            {@required this.text,
            @required this.number,
            this.isSelected,
            this.question});
}
