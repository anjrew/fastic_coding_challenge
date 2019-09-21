import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/widgets.dart';
import 'package:nutrition_questionnaire/classes/answer.dart';
import 'package:nutrition_questionnaire/classes/question_data.dart';
import 'package:nutrition_questionnaire/utlis/globals.dart';
import 'package:nutrition_questionnaire/utlis/images.dart';
import 'package:nutrition_questionnaire/utlis/tools.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class MainBloc extends Model {
    FirebaseAnalytics analytics = FirebaseAnalytics();
    FirebaseAnalyticsObserver observer;

    RemoteConfig remoteConfig;

	DeviceSize devicesize = DeviceSize.large;

    static const Duration pageAnimationDuration = Duration(milliseconds: 300);
    static const Curve pageAnimationCurve = Curves.easeInOut;
    PageController pageController;

    List<QuestionData> _questionData;

	StreamController<List<QuestionData>> _streamController = new StreamController<List<QuestionData>>();
	Stream<List<QuestionData>> questionsStream() => _streamController.stream;

    MainBloc() {
        pageController = new PageController();
        observer = FirebaseAnalyticsObserver(analytics: analytics);
        getRemoteConfigData();
    }

    void startQuestions() {
        pageController.animateToPage(1,
                duration: pageAnimationDuration, curve: pageAnimationCurve);
		analytics.logEvent(name: KIndicatorEvents.started);
    }

    void nextQuestion() {
        pageController.nextPage(
                duration: pageAnimationDuration, curve: pageAnimationCurve);
    }

    void previousQuestion() {
        pageController.previousPage(
                duration: pageAnimationDuration, curve: pageAnimationCurve);
    }

    void setAnswer(Answer selectedAnswer) {
		QuestionData data = _questionData[selectedAnswer.question.number];

		analytics.logEvent(
			name: KIndicatorEvents.answer, 
			parameters: { 
				"question": selectedAnswer.id
			});
        
		data.answers.forEach((Answer answer) {
			if (answer.number == selectedAnswer.number) {
				if (answer.isSelected){
					answer.isSelected = false;
				} else {
					answer.isSelected = true;
				}
			} else {
				answer.isSelected = false;
			}
		});
		_streamController.add(_questionData);
    }

	void resetAnswers(){
		_questionData.forEach((QuestionData question){
			question.answers.forEach((Answer answer){
				answer.isSelected = false;
			});
		});
	}

	bool trySubmitAnswers(){
		if(allQuestionsAnswered()){
			pageController.animateToPage(0, duration: pageAnimationDuration, curve: pageAnimationCurve);
			analytics.logEvent(name: KIndicatorEvents.completed);
			resetAnswers();
			return true;
		} else {
			analytics.logEvent(name: KIndicatorEvents.completed);
			return false;
		}
	}

	bool allQuestionsAnswered(){
		bool isValid = true;

		for (QuestionData question in _questionData) {
			bool hasAnswer = false;
			for (Answer answer in question.answers) {
				if (answer.isSelected){
					hasAnswer = true;
				}
			}
			if(!hasAnswer){
				isValid = false;
			}
		}
		return isValid;
	}

    Future<void> getRemoteConfigData() async {
        remoteConfig = await RemoteConfig.instance;
        remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
        await remoteConfig.fetch(expiration: const Duration(seconds: 1));
        await remoteConfig.activateFetched();

        String stingified = remoteConfig.getString("app_questions");
        _questionData = parseStringyToQuestion(stingified);
		_streamController.add(_questionData);
        return ;
    }

    DeviceSize setDeviceSize(double screenWidth) {
        if (screenWidth < 375.0) {
            return DeviceSize.small;
        } else if (screenWidth > 375.0 && screenWidth < 750) {
            return DeviceSize.meduim;
        } else {
			return DeviceSize.large;
		}
    }

	String getHeaderImage(String pageId){
		try {
			return images[pageId][devicesize];
		} catch (e) {
			print(e);
			return images["1"][devicesize];
		}
	}

    static MainBloc of(BuildContext context) => ScopedModel.of<MainBloc>(context);
}

enum DeviceSize { small, meduim, large }
