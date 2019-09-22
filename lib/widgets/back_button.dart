import 'package:flutter/material.dart';
import 'package:nutrition_questionnaire/logic/main_bloc.dart';

class ArrowBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
	return Positioned(
                left: 10,
                width: 50,
                top: 25,
                height: 50,
                child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: MainBloc.of(context).previousQuestion,
                ),
            );
  }
}