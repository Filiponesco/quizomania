import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizomania/model/category.dart';
import 'package:quizomania/model/enums_difficulty_answer.dart';
import 'package:quizomania/model/test/test_bloc.dart';
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
  Answer _selectedAnswer;
  TestBloc _testBloc;
  int _randomIdAnswer;

  void _onTapFieldCheck(answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }
  int _shuffleCorrectAnswer(){
    var rnd = Random();
    return rnd.nextInt(4);
  }
@override
  void initState() {
    _testBloc = TestBloc(widget.currentCategory.id);
    _randomIdAnswer = _shuffleCorrectAnswer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestBloc, TestState>(
      bloc: _testBloc,
      builder: (context, TestState state){
        if(state is FirstQuestion){
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 37, 44, 73),
            body: Padding(
              padding:
              const EdgeInsets.only(left: 25, right: 25, top: 40, bottom: 15),
              child: Stack(
                children:<Widget>[ Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Question ${state.questionNumber + 1}',
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
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        '${state.question.question}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Balsamiq',
                            color: Colors.white,
                            height: 1.2)),
                    SizedBox(
                      height: 35,
                    ),
                    AnswerFieldCheck(
                      numberOfAnswer: Answer.first,
                      textAnswer: '${state.question.correctAnswer}',
                      onTap: () => _onTapFieldCheck(Answer.first),
                      selectedAnswer: _selectedAnswer,
                    ),
                    SizedBox(height: 15,),
                    AnswerFieldCheck(
                      numberOfAnswer: Answer.second,
                      textAnswer: '${state.question.incorrectAnswers[0]}',
                      onTap: () => _onTapFieldCheck(Answer.second),
                      selectedAnswer: _selectedAnswer,
                    ),
                    SizedBox(height: 15,),
                    AnswerFieldCheck(
                      numberOfAnswer: Answer.third,
                      textAnswer: '${state.question.incorrectAnswers[1]}',
                      onTap: () => _onTapFieldCheck(Answer.third),
                      selectedAnswer: _selectedAnswer,
                    ),
                    SizedBox(height: 15,),
                    AnswerFieldCheck(
                      numberOfAnswer: Answer.fourth,
                      textAnswer: '${state.question.incorrectAnswers[2]}',
                      onTap: () => _onTapFieldCheck(Answer.fourth),
                      selectedAnswer: _selectedAnswer,
                    ),
                  ],
                ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyBackButton(
                          onPressed: ()=> Navigator.pop(context),
                        ),
                        BigButton(
                          color: Colors.blue,
                          text: 'Next',
                          onPressed: () {
                            _testBloc.add(NextQuestion());
                          },
                        ),
                      ],
                    ),
                  ),
              ]
              ),
            ),
          );
        }
        else if(state is MiddleQuestion){
         return  Scaffold(
            backgroundColor: Color.fromARGB(255, 37, 44, 73),
            body: Padding(
              padding:
              const EdgeInsets.only(left: 25, right: 25, top: 40, bottom: 15),
              child: Stack(
                children:<Widget>[ Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Question ${state.questionNumber + 1}',
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
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        '${state.question.question}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Balsamiq',
                            color: Colors.white,
                            height: 1.2)),
                    SizedBox(
                      height: 35,
                    ),
                    AnswerFieldCheck(
                      numberOfAnswer: Answer.first,
                      textAnswer: '${state.question.correctAnswer}',
                      onTap: () => _onTapFieldCheck(Answer.first),
                      selectedAnswer: _selectedAnswer,
                    ),
                    SizedBox(height: 15,),
                    AnswerFieldCheck(
                      numberOfAnswer: Answer.second,
                      textAnswer: '${state.question.incorrectAnswers[0]}',
                      onTap: () => _onTapFieldCheck(Answer.second),
                      selectedAnswer: _selectedAnswer,
                    ),
                    SizedBox(height: 15,),
                    AnswerFieldCheck(
                      numberOfAnswer: Answer.third,
                      textAnswer: '${state.question.incorrectAnswers[1]}',
                      onTap: () => _onTapFieldCheck(Answer.third),
                      selectedAnswer: _selectedAnswer,
                    ),
                    SizedBox(height: 15,),
                    AnswerFieldCheck(
                      numberOfAnswer: Answer.fourth,
                      textAnswer: '${state.question.incorrectAnswers[2]}',
                      onTap: () => _onTapFieldCheck(Answer.fourth),
                      selectedAnswer: _selectedAnswer,
                    ),
                  ],
                ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyBackButton(
                          onPressed: ()=>_testBloc.add(PreviousQuestion()),
                        ),
                        BigButton(
                          color: Colors.blue,
                          text: 'Next',
                          onPressed: () {
                            _testBloc.add(NextQuestion());
                          },
                        ),
                      ],
                    ),
                  ),
              ],
              ),
            ),
          );
        }
        else if(state is LastQuestion){
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 37, 44, 73),
            body: Padding(
              padding:
              const EdgeInsets.only(left: 25, right: 25, top: 40, bottom: 15),
              child: Stack(
                children:<Widget>[ Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Question ${state.questionNumber + 1}',
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
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        '${state.question.question}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Balsamiq',
                            color: Colors.white,
                            height: 1.2)),
                    SizedBox(
                      height: 35,
                    ),
                    AnswerFieldCheck(
                      numberOfAnswer: Answer.first,
                      textAnswer: '${state.question.correctAnswer}',
                      onTap: () => _onTapFieldCheck(Answer.first),
                      selectedAnswer: _selectedAnswer,
                    ),
                    SizedBox(height: 15,),
                    AnswerFieldCheck(
                      numberOfAnswer: Answer.second,
                      textAnswer: '${state.question.incorrectAnswers[0]}',
                      onTap: () => _onTapFieldCheck(Answer.second),
                      selectedAnswer: _selectedAnswer,
                    ),
                    SizedBox(height: 15,),
                    AnswerFieldCheck(
                      numberOfAnswer: Answer.third,
                      textAnswer: '${state.question.incorrectAnswers[1]}',
                      onTap: () => _onTapFieldCheck(Answer.third),
                      selectedAnswer: _selectedAnswer,
                    ),
                    SizedBox(height: 15,),
                    AnswerFieldCheck(
                      numberOfAnswer: Answer.fourth,
                      textAnswer: '${state.question.incorrectAnswers[2]}',
                      onTap: () => _onTapFieldCheck(Answer.fourth),
                      selectedAnswer: _selectedAnswer,
                    ),
                  ],
                ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyBackButton(
                          onPressed: ()=>_testBloc.add(PreviousQuestion()),
                        ),
                        BigButton(
                          color: Colors.green,
                          text: 'Finish',
                          onPressed: () {
                            _testBloc.add(EndTest());
                          },
                        ),
                      ],
                    ),
                  )
              ],
              ),
            ),
          );
        }
        else if(state is ScoreTable) {
          return ResultPage();
        }
        else{
          return Center(child: CircularProgressIndicator());}
      },
    );
  }
  @override
  void dispose() {
    _testBloc.close();
    super.dispose();
  }
}
