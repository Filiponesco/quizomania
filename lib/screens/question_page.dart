import 'package:auto_size_text/auto_size_text.dart';
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
    BlocProvider.of<QuestionBloc>(context).add(LoadTest());
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
                        //rebuild only after loading
                        condition: (previous, current) {
                      if (previous is LoadingQuestions)
                        return true;
                      else
                        return false;
                    },
                        builder: (context, state) {
                      debugPrint('$runtimeType: rebuild: all question page');
                      if (state is QuestionInitial) {
                        context.bloc<TimerBloc>().add(FirstPage());
                        return QuestionPageContent();
                      }
                      else if (state is LoadingQuestions) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else
                        return ErrorDialog();
                    }),
                  ),
                ],
              ))),
    );
  }
}

class QuestionPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Timer(),
        TitleQuestionPage(
          //TODO it is good with bloc?
          quantity: context.bloc<QuestionBloc>().quantity,
        ),
        Divider(
          color: Colors.grey,
        ),
        BlocBuilder<QuestionBloc, QuestionState>(
            condition: (previous, current) {
          //rebuild only if question change
          if (previous is QuestionInitial && current is QuestionInitial) {
            if (previous.question == current.question)
              return false;
            else
              return true;
          } else if (current is ScoreTable) {
            return false;
          } else
            return true;
        }, builder: (context, state) {
          debugPrint('$runtimeType: rebuild question');
          if (state is QuestionInitial) {
            return AutoSizeText('${state.question.question}',
                maxLines: 5,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Balsamiq',
                    color: Colors.white,
                    height: 1.2));
          } else
            return Container();
        }),
        //it will rebuild when tap
        AnswerFieldCheck(index: 0),
        AnswerFieldCheck(index: 1),
        AnswerFieldCheck(index: 2),
        AnswerFieldCheck(index: 3),
        ActionsButtons(),
      ],
    );
  }
}

class Timer extends StatelessWidget {
  const Timer({
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
            percent: state.duration / context.bloc<TimerBloc>().duration,
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
        } else if(state is TimeStop){
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
        }
        else
          return Container();
      }),
    );
  }
}

class TitleQuestionPage extends StatelessWidget {
  final int quantity;

  const TitleQuestionPage({Key key, this.quantity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBloc, QuestionState>(
        condition: (previous, current) {
      //rebuild only if question change
      if (previous is QuestionInitial && current is QuestionInitial) {
        if (previous.question == current.question)
          return false;
        else
          return true;
      } else if (current is ScoreTable) {
        return false;
      } else
        return true;
    }, builder: (context, state) {
      debugPrint('$runtimeType: rebuild');
      if (state is QuestionInitial) {
        return RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Question ${state.question.numberOfQuestion + 1}',
              style: TextStyle(
                  fontFamily: 'Balsamiq',
                  fontWeight: FontWeight.bold,
                  fontSize: 33,
                  color: Colors.grey),
            ),
            TextSpan(
              text: '/$quantity',
              style: TextStyle(
                  fontFamily: 'Balsamiq', fontSize: 20, color: Colors.grey),
            )
          ]),
        );
      } else
        return Container(height: 100);
    });
  }
}

class AnswerFieldCheck extends StatelessWidget {
  final int index;
  final Question question;

  AnswerFieldCheck({this.index, this.question});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO tap two time on this same field
        context.bloc<QuestionBloc>().add(AnswerQuestion(index));
      },
      child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              border:
                  Border.all(color: Color.fromARGB(255, 33, 72, 106), width: 4),
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 21, right: 13, top: 3, bottom: 3),
            child: BlocBuilder<QuestionBloc, QuestionState>(
                condition: (previous, current) {
              if (current is ScoreTable) {
                return false;
              } else
                return true;
            }, builder: (context, state) {
              debugPrint('$runtimeType: rebuild');
              if (state is QuestionInitial) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        '${state.question.answers[index]}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Balsamiq'),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Checkbox(
                        checkColor: Colors.blue,
                        value: index == state.question.chosenAnswerIndex),
                  ],
                );
              } else
                return Container(
                  height: 45,
                );
            }),
          )),
    );
  }
}

class ActionsButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBloc, QuestionState>(
        condition: (previous, current) {
      if (previous is QuestionInitial && current is QuestionInitial) {
        if (previous.question.numberOfQuestion !=
            current.question.numberOfQuestion)
          return true;
        else
          return false;
      } else
        return false;
    }, builder: (context, state) {
      debugPrint('$runtimeType: rebuild');
      if (state is FirstQuestion) {
        return Align(
          alignment: Alignment.bottomRight,
          child: BigButton(
            text: 'Next',
            onPressed: () {
              context.bloc<QuestionBloc>().add(NextQuestion());
              context.bloc<TimerBloc>().add(NextPage());
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
                context.bloc<TimerBloc>().add(BackPage());
              },
            ),
            BigButton(
              text: 'Next',
              onPressed: () {
                context.bloc<QuestionBloc>().add(NextQuestion());
                context.bloc<TimerBloc>().add(NextPage());
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
                context.bloc<TimerBloc>().add(BackPage());
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
    });
  }
}
