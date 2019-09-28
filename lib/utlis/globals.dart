import 'package:flutter/animation.dart';

const Duration pageAnimationDuration = Duration(milliseconds: 300);
const Curve pageAnimationCurve = Curves.easeInOut;

class KIndicatorEvents {
  static const started = "STARTED";
  static const completed = "COMPLETED";
  static const answer = "ANSWER";
  static const appOpened = "APP_OPENED";
}
