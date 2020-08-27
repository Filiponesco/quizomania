import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:quizomania/blocs/setup_question_blocs/setup_question_bloc.dart';
import 'package:quizomania/blocs/timer_blocs/timer_bloc.dart';
import 'package:quizomania/models/category.dart';
import 'package:quizomania/models/enums_difficulty_answer.dart';
import 'package:quizomania/blocs/question_blocs/question_bloc.dart';
import 'package:quizomania/screens/question_page.dart';
import 'package:quizomania/widgets/my_back_button.dart';
import 'package:quizomania/widgets/big_button.dart';
import 'package:quizomania/widgets/difficulty_button.dart';

class SpecificationQuestionsDialog extends StatelessWidget {
  final Category category;

  SpecificationQuestionsDialog({this.category});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetupQuestionBloc, SetupQuestionState>(
      listener: (context, state) {
        if (state is ClosedDialog) {
          Navigator.of(context).pop();
        } else if (state is StartedQuiz) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BlocProvider(
              create: (context) => TimerBloc(),
              child: BlocProvider(
                    create: (context) => QuestionBloc(
                      currentCategory: category,
                      quantity: state.numberOfQuestions,
                      difficulty: state.difficultyLevel,
                      timerBloc: context.bloc<TimerBloc>()
                    )..add(LoadTest()),
                  child: QuestionPage(),
                ),
            );
          })).then((_) => Navigator.of(context).pop());
        }
      },
      child: Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 25, right: 25, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AutoSizeText(
                      '${category.category}',
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Balsamiq'),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(fontSize: 21, fontFamily: 'Balsamiq'),
                        children: [
                          TextSpan(
                              text: "\nSelect the ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                            text: "difficulty",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                              text: " \nof questions ",
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    DifficultyChoose(),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(fontSize: 21, fontFamily: 'Balsamiq'),
                  children: [
                    TextSpan(
                        text: "Pick the ",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                      text: "number",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                        text: " \nof questions ",
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              BlocBuilder<SetupQuestionBloc, SetupQuestionState>(
                  condition: (previous, current) {
                if (previous is SetupQuestionInitial &&
                    current is SetupQuestionInitial) {
                  if (previous.numberOfQuestions != current.numberOfQuestions)
                    return true;
                  else
                    return false;
                } else
                  return false;
              }, builder: (context, state) {
                if (state is SetupQuestionInitial) {
                  debugPrint('$runtimeType: rebuild: numberPicker');
                  return NumberPicker.horizontal(
                      initialValue: state.numberOfQuestions,
                      minValue: 1,
                      maxValue: 10,
                      onChanged: (num) {
                        context
                            .bloc<SetupQuestionBloc>()
                            .add(PickNumberOfQuestion(numberOfQuestion: num));
                      });
                } else {
                  return Container();
                }
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MyBackButton(
                    radius: 30.0,
                    onPressed: () {
                      context.bloc<SetupQuestionBloc>().add(CloseDialog());
                    },
                  ),
                  BigButton(
                    radius: 30.0,
                    text: 'Start',
                    color: Colors.blue,
                    onPressed: () {
                      context.bloc<SetupQuestionBloc>().add(GoToQuiz());
                    },
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class DifficultyChoose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupQuestionBloc, SetupQuestionState>(
        condition: (previous, current) {
      if (previous is SetupQuestionInitial && current is SetupQuestionInitial) {
        if (previous.difficultyLevel != current.difficultyLevel)
          return true;
        else
          return false;
      } else
        return false;
    }, builder: (context, state) {
      if (state is SetupQuestionInitial) {
        debugPrint('$runtimeType: rebuild: difficulty buttons');
        return Container(
          child: Column(
            children: [
              DifficultyButton(
                text: 'Easy',
                color: Colors.blue,
                onPressed: state.difficultyLevel == DifficultyLevel.easy
                    ? null
                    : () {
                        context.bloc<SetupQuestionBloc>().add(SelectDifficulty(
                            difficultyLevel: DifficultyLevel.easy));
                      },
              ),
              SizedBox(
                height: 3,
              ),
              DifficultyButton(
                text: 'Medium',
                color: Colors.orange,
                onPressed: state.difficultyLevel == DifficultyLevel.medium
                    ? null
                    : () {
                        context.bloc<SetupQuestionBloc>().add(SelectDifficulty(
                            difficultyLevel: DifficultyLevel.medium));
                      },
              ),
              SizedBox(
                height: 3,
              ),
              DifficultyButton(
                text: 'Hard',
                color: Colors.red,
                onPressed: state.difficultyLevel == DifficultyLevel.hard
                    ? null
                    : () {
                        context.bloc<SetupQuestionBloc>().add(SelectDifficulty(
                            difficultyLevel: DifficultyLevel.hard));
                      },
              )
            ],
          ),
        );
      } else
        return Container();
    });
  }
}
