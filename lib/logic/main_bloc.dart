
import 'package:flutter/widgets.dart';
import 'package:nutrition_questionnaire/classes/question_page_data.dart';
import 'package:scoped_model/scoped_model.dart';

class MainBloc extends Model{

	static const Duration pageAnimationDuration = Duration(milliseconds: 300);
	static const Curve pageAnimationCurve = Curves.easeInOut;
	PageController pageController;

	List<QuestionsPageData> _questionData;
	List<QuestionsPageData> get questionData => _questionData;


	MainBloc(){
		pageController = new PageController();
		
	}

	void startQuestions(){
		pageController.animateToPage(1, duration: pageAnimationDuration, curve: pageAnimationCurve);
	}

	void nextQuestion(){
		pageController.nextPage(duration: pageAnimationDuration, curve: pageAnimationCurve);
	}

	void previousQuestion(){
		pageController.previousPage(duration: pageAnimationDuration, curve: pageAnimationCurve);
	}

	void finishQuestions(){
		pageController.previousPage(duration: pageAnimationDuration, curve: pageAnimationCurve);
	}


	static MainBloc of(BuildContext context) => ScopedModel.of<MainBloc>(context);
}