import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizomania/model/category.dart';
import 'package:quizomania/model/enums_difficulty_answer.dart';
import 'package:quizomania/model/question.dart';
import 'package:quizomania/model/test/test_bloc.dart';
import 'package:quizomania/screens/confirm_dialog.dart';
import 'package:quizomania/screens/result_page.dart';
import 'package:quizomania/widgets/answer_field_check.dart';
import 'package:quizomania/widgets/big_button.dart';
import 'package:quizomania/widgets/my_back_button.dart';

class QuestionPage extends StatefulWidget {
  final Category currentCategory;

  QuestionPage({@required this.currentCategory});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  TestBloc _testBloc;

  @override
  void initState() {
    _testBloc = TestBloc(widget.currentCategory.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return ConfirmDialog(content: 'Are you sure you want to exit this quiz?\nYou can not return to this place and you will not see the results.',);
            });
        return value == true;
      },
      child: BlocListener<TestBloc, TestState>(
        bloc: _testBloc,
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
        child: BlocBuilder<TestBloc, TestState>(
          bloc: _testBloc,
          builder: (context, TestState state) {
            if (state is FirstQuestion) {
              return Scaffold(
                  floatingActionButton: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MyBackButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icons.close,
                      ),
                      BigButton(
                        text: 'Next',
                        onPressed: () => _testBloc.add(NextQuestion()),
                      ),
                    ],
                  ),
                  backgroundColor: Color.fromARGB(255, 37, 44, 73),
                  body: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 40, bottom: 15),
                      child: QuestionPageContent(
                        questionNumber: state.questionNumber,
                        question: state.question,
                      )));
            } else if (state is MiddleQuestion) {
              return Scaffold(
                  floatingActionButton: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MyBackButton(
                        onPressed: () => _testBloc.add(PreviousQuestion()),
                      ),
                      BigButton(
                        text: 'Next',
                        onPressed: () => _testBloc.add(NextQuestion()),
                      ),
                    ],
                  ),
                  backgroundColor: Color.fromARGB(255, 37, 44, 73),
                  body: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 40, bottom: 15),
                      child: QuestionPageContent(
                        questionNumber: state.questionNumber,
                        question: state.question,
                      )));
            } else if (state is LastQuestion) {
              return Scaffold(
                  floatingActionButton: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MyBackButton(
                        onPressed: () => _testBloc.add(PreviousQuestion()),
                      ),
                      BigButton(
                        color: Colors.green,
                        text: 'Finish',
                        onPressed: () => _testBloc.add(EndTest()),
                      ),
                    ],
                  ),
                  backgroundColor: Color.fromARGB(255, 37, 44, 73),
                  body: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 40, bottom: 15),
                      child: QuestionPageContent(
                        questionNumber: state.questionNumber,
                        question: state.question,
                      )));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _testBloc.close();
    super.dispose();
  }
}

class QuestionPageContent extends StatefulWidget {
  final Question question;
  final int questionNumber;

  QuestionPageContent({this.questionNumber = 0, this.question});

  @override
  _QuestionPageContentState createState() => _QuestionPageContentState();
}

class _QuestionPageContentState extends State<QuestionPageContent> {
  Answer _selectedAnswer;

  void _onTapFieldCheck(answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TitleQuestionPage(
          questionNumber: widget.questionNumber + 1,
        ),
        Divider(
          color: Colors.grey,
        ),
        AutoSizeText('${widget.question.question}',
            maxLines: 5,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Balsamiq',
                color: Colors.white,
                height: 1.2)),
        AnswerFieldCheck(
          numberOfAnswer: Answer.first,
          textAnswer: '${widget.question.correctAnswer}',
          onTap: () => _onTapFieldCheck(Answer.first),
          selectedAnswer: _selectedAnswer,
        ),
        AnswerFieldCheck(
          numberOfAnswer: Answer.second,
          textAnswer: '${widget.question.incorrectAnswers[0]}',
          onTap: () => _onTapFieldCheck(Answer.second),
          selectedAnswer: _selectedAnswer,
        ),
        AnswerFieldCheck(
          numberOfAnswer: Answer.third,
          textAnswer: '${widget.question.incorrectAnswers[1]}',
          onTap: () => _onTapFieldCheck(Answer.third),
          selectedAnswer: _selectedAnswer,
        ),
        AnswerFieldCheck(
          numberOfAnswer: Answer.fourth,
          textAnswer: '${widget.question.incorrectAnswers[2]}',
          onTap: () => _onTapFieldCheck(Answer.fourth),
          selectedAnswer: _selectedAnswer,
        ),
        SizedBox(
          height: 70,
        ) //space for floating button
      ],
    );
  }
}

class TitleQuestionPage extends StatelessWidget {
  final int questionNumber;

  const TitleQuestionPage({Key key, this.questionNumber = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: 'Question $questionNumber',
          style: TextStyle(
              fontFamily: 'Balsamiq',
              fontWeight: FontWeight.bold,
              fontSize: 33,
              color: Colors.grey),
        ),
        TextSpan(
          text: '/10',
          style: TextStyle(
              fontFamily: 'Balsamiq', fontSize: 20, color: Colors.grey),
        )
      ]),
    );
  }
}
