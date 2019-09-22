
import 'dart:convert';
import 'package:nutrition_questionnaire/classes/answer.dart';
import 'package:nutrition_questionnaire/classes/question_data.dart';

List<QuestionData> parseStringyToQuestion(String stingifiedData){
	
	Map<String ,dynamic> data = jsonDecode(stingifiedData) as Map<String ,dynamic>;	

	return data.keys.map((String number) {
		dynamic multiplechoice = data[number][QuestionData.multiplechoiceKey];

		if (multiplechoice is String){
			if (multiplechoice == "yes") {
				multiplechoice = true;
			} else {
				multiplechoice = false;
			}
		}

		return QuestionData(	
			id: data[number][QuestionData.questionIdKey],
			multiplechoice: multiplechoice,
			text: data[number][QuestionData.questionTextKey],
			questionAnswers: parseDataToAnswer(data[number][QuestionData.answersKey]),
			number: int.parse(number.toString())
	);}).toList();
}

List<Answer> parseDataToAnswer(Map<String, dynamic> data){

	List<Answer> answers = new List<Answer>();

	data.keys.forEach((String number) {
		(data[number] as Map<String, dynamic>).forEach((String id, dynamic text){
			answers.add(
				Answer(id,
					number: int.parse(number),
			 		text: text.toString(),
					isSelected: false
				)
			);
		});
	}); 

	return answers;
}

