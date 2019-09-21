import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/widgets.dart';
import 'package:nutrition_questionnaire/classes/answer.dart';
import 'package:nutrition_questionnaire/classes/question_data.dart';
import 'package:nutrition_questionnaire/classes/response.dart';
import 'package:nutrition_questionnaire/utlis/tools.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class MainBloc extends Model {
    FirebaseAnalytics analytics = FirebaseAnalytics();
    FirebaseAnalyticsObserver observer;

    RemoteConfig remoteConfig;

    static const Duration pageAnimationDuration = Duration(milliseconds: 300);
    static const Curve pageAnimationCurve = Curves.easeInOut;
    PageController pageController;

    List<QuestionData> _questionData;
    List<QuestionData> get questionData => _questionData;

    MainBloc(double screenWidth) {
        pageController = new PageController();
        observer = FirebaseAnalyticsObserver(analytics: analytics);
        getRemoteConfigData();
    }

    void startQuestions() {
        pageController.animateToPage(1,
                duration: pageAnimationDuration, curve: pageAnimationCurve);
    }

    void nextQuestion() {
        pageController.nextPage(
                duration: pageAnimationDuration, curve: pageAnimationCurve);
    }

    void previousQuestion() {
        pageController.previousPage(
                duration: pageAnimationDuration, curve: pageAnimationCurve);
    }

    void finishQuestions() {
        pageController.previousPage(
                duration: pageAnimationDuration, curve: pageAnimationCurve);
    }

    void setAnswer(Answer selectedAnswer) {
        questionData[selectedAnswer.question.number]
                .answers
                .forEach((Answer answer) {
            if (answer.number == selectedAnswer.number) {
                answer.isSelected = true;
            } else {
                answer.isSelected = false;
            }
        });
    }

    Future<List<QuestionData>> getRemoteConfigData() async {
        remoteConfig = await RemoteConfig.instance;
        remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
        await remoteConfig.fetch(expiration: const Duration(seconds: 1));
        await remoteConfig.activateFetched();
        String stingified = remoteConfig.getString("app_questions");
        _questionData = parseStringyToQuestion(stingified);

        return _questionData;
    }

    DeviceSize setDeviceSize(double screenWidth) {
        if (screenWidth < 375.0) {
            return DeviceSize.small;
        } else if (screenWidth > 375.0 && screenWidth < 750) {
            return DeviceSize.meduim;
        } else {}
    }

    static MainBloc of(BuildContext context) => ScopedModel.of<MainBloc>(context);
}

enum DeviceSize { small, meduim, large }
