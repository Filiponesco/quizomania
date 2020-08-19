import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizomania/blocs/question_blocs/question_bloc.dart';
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
            } else if (state is AnswerQuestion) {
              print('answer: ${state.toString()}');
            }
          },
          child: Scaffold(
              backgroundColor: Color.fromARGB(255, 37, 44, 73),
              body: Container(
                padding: EdgeInsets.fromLTRB(25, 40, 25, 15),
                child: QuestionPageContent(),
              ))),
    );
  }
}

class QuestionPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBloc, QuestionState>(
      builder: (context, state) {
        debugPrint('$runtimeType: rebuild');
        if (state is QuestionInitial) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TitleQuestionPage(
                //TODO it is good with bloc?
                quantity: context.bloc<QuestionBloc>().quantity,
              ),
              Divider(
                color: Colors.grey,
              ),
              BlocBuilder<QuestionBloc, QuestionState>(
                  builder: (context, state) {
                debugPrint('$runtimeType: rebuild');
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
        } else if (state is LoadingQuestions) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is QuestionError) {
          return ErrorDialog();
        } else
          return Container();
      },
    );
  }
}

class TitleQuestionPage extends StatelessWidget {
  final int quantity;

  const TitleQuestionPage({Key key, this.quantity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('$runtimeType: rebuild');
    return BlocBuilder<QuestionBloc, QuestionState>(builder: (context, state) {
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
        return Container();
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
                builder: (context, state) {
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
                return Container();
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
        print(
            '${previous.question.numberOfQuestion} != ${current.question.numberOfQuestion}');
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
    });
  }
}
