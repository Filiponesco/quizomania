import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quizomania/blocs/question_blocs/question_bloc.dart';
import 'package:quizomania/blocs/timer_blocs/timer_bloc.dart';
import 'package:quizomania/models/question.dart';
import 'package:quizomania/screens/confirm_dialog.dart';
import 'package:quizomania/screens/error_dialog.dart';
import 'package:quizomania/screens/result_page.dart';
import 'package:quizomania/widgets/big_button.dart';
import 'package:quizomania/widgets/my_back_button.dart';

class QuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('$runtimeType: rebuil all');
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return ConfirmDialog(
                content: 'Are you sure you want to exit this quiz?'
                    '\nYou can not return to this place and you will not see the results.',
              );
            });
        return value == true;
      },
      child: BlocListener<QuestionBloc, QuestionState>(
          listener: (context, state) {
            if (state is ScoreTable) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultPage(
                            score: state.score,
                            totalScore: state.totalScore,
                            percentage: state.percentage,
                          )),
                  (route) => false);
            }
          },
          child: Scaffold(
              backgroundColor: Color.fromARGB(255, 37, 44, 73),
              body: Stack(
                children: [
                  Image(
                    image: AssetImage('assets/images/bg_circle.png'),
                    width: size.width,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(25, 40, 25, 15),
                    child: BlocBuilder<QuestionBloc, QuestionState>(
                        builder: (context, state) {
                      debugPrint('$runtimeType: rebuild: all question page');
                      if (state is QuestionInitial) {
                        return QuestionPageContent(question: state.question);
                      } else if (state is LoadingQuestions) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is QuestionError) {
                        return ErrorDialog();
                      } else
                        return Container();
                    }),
                  ),
                ],
              ))),
    );
  }
}

class QuestionPageContent extends StatelessWidget {
  final Question question;

  QuestionPageContent({this.question});

  @override
  Widget build(BuildContext context) {
    var quantity = context.bloc<QuestionBloc>().quantity;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Timer(question: question),
        Container(
          padding: EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TitleQuestionPage(quantity: quantity, question: question),
              Divider(
                color: Colors.grey,
              ),
              AutoSizeText('${question.question}',
                  maxLines: 5,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Balsamiq',
                      color: Colors.white,
                      height: 1.2)),
            ],
          ),
        ),
        //it will rebuild when tap
        Expanded(
          child: Container(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnswerFieldCheck(index: 0, question: question),
                SizedBox(
                  height: 10,
                ),
                AnswerFieldCheck(index: 1, question: question),
                SizedBox(
                  height: 10,
                ),
                AnswerFieldCheck(index: 2, question: question),
                SizedBox(
                  height: 10,
                ),
                AnswerFieldCheck(
                  index: 3,
                  question: question,
                ),
              ],
            ),
          ),
        ),
        ActionsButtons(
          state: context.bloc<QuestionBloc>().state,
        ),
      ],
    );
  }
}

class TitleQuestionPage extends StatelessWidget {
  final int quantity;
  final Question question;

  const TitleQuestionPage({Key key, this.quantity, @required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: 'Question ${question.numberOfQuestion + 1}',
            style: TextStyle(
                fontFamily: 'Balsamiq',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.grey),
          ),
          TextSpan(
            text: '/$quantity',
            style: TextStyle(
                fontFamily: 'Balsamiq', fontSize: 15, color: Colors.grey),
          )
        ]),
      ),
    );
  }
}

class AnswerFieldCheck extends StatelessWidget {
  final int index;
  final Question question;

  AnswerFieldCheck({@required this.index, @required this.question});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(buildWhen: (previous, current) {
      if (current is TimeStop || previous is TimeStop)
        return true;
      else
        return false;
    }, builder: (context, state) {
      debugPrint('$runtimeType: rebuild');
      if (state is TimerInitial) {
        return GestureDetector(
          onTap: () {
            context.bloc<QuestionBloc>().add(AnswerQuestion(index));
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Color.fromARGB(255, 33, 72, 106), width: 4),
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 21, right: 13, top: 3, bottom: 3),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: AutoSizeText(
                        '${question.answers[index]}',
                        maxLines: 3,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Balsamiq'),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    CircularCheckBox(
                        value: index == question.chosenAnswerIndex,
                        //checkColor: Colors.white,
                        disabledColor: Color.fromARGB(255, 33, 72, 106),
                        onChanged: (_) {}),
                  ],
                ),
              )),
        );
      } else {
        return Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                    color: Color.fromARGB(255, 33, 72, 106), width: 4),
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 21, right: 13, top: 3, bottom: 3),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: AutoSizeText(
                      '${question.answers[index]}',
                      maxLines: 3,
                      style: TextStyle(
                          color: index == question.correctAnswerIndex
                              ? Colors.green
                              : Colors.red,
                          fontSize: 18,
                          fontFamily: 'Balsamiq'),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  CircularCheckBox(
                      value: index == question.chosenAnswerIndex,
                      //checkColor: Colors.white,
                      disabledColor: Color.fromARGB(255, 33, 72, 106),
                      onChanged: (_) {}),
                ],
              ),
            ));
      }
    });
  }
}

class ActionsButtons extends StatelessWidget {
  final QuestionState state;

  ActionsButtons({@required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is FirstQuestion) {
      return Align(
        alignment: Alignment.bottomRight,
        child: BigButton(
          text: 'Next',
          onPressed: () {
            context.bloc<QuestionBloc>().add(NextQuestion());
          },
        ),
      );
    } else if (state is MiddleQuestion) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyBackButton(
            onPressed: () {
              context.bloc<QuestionBloc>().add(PreviousQuestion());
            },
          ),
          BigButton(
            text: 'Next',
            onPressed: () {
              context.bloc<QuestionBloc>().add(NextQuestion());
            },
          )
        ],
      );
    } else if (state is LastQuestion) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyBackButton(
            onPressed: () {
              context.bloc<QuestionBloc>().add(PreviousQuestion());
            },
          ),
          BigButton(
            color: Colors.green,
            text: 'Finish',
            onPressed: () {
              context.bloc<QuestionBloc>().add(EndTest());
            },
          )
        ],
      );
    } else
      return Container();
  }
}

class Timer extends StatelessWidget {
  final Question question;

  const Timer({
    this.question,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Color.fromARGB(255, 55, 63, 96), width: 3.0),
      ),
      child: BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
        debugPrint('$runtimeType: rebuild');
        if (state is TimerInitial) {
          return LinearPercentIndicator(
            linearGradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 254, 79, 104),
                Color.fromARGB(255, 186, 118, 255)
              ],
            ),
            backgroundColor: Colors.transparent,
            lineHeight: 35,
            percent: state.duration / state.maxDuration,
            linearStrokeCap: LinearStrokeCap.roundAll,
            animation: true,
            animationDuration: 1000,
            alignment: MainAxisAlignment.end,
            clipLinearGradient: true,
            padding: EdgeInsets.symmetric(horizontal: 18),
            animateFromLastPercent: true,
            center: Text(
              state.duration.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Balsamiq'),
              textAlign: TextAlign.center,
            ),
          );
        } else if (state is TimeStop) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Balsamiq'),
              textAlign: TextAlign.center,
            ),
          );
        } else
          return Container();
      }),
    );
  }
}
