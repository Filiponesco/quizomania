import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quizomania/models/question_model.dart';

class Question {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;
  int chosenAnswerIndex;
  final int numberOfQuestion;
  int timeLeft;
  bool isTimeRunning = false;
  final int maxTime;
  bool stopTime = false; //true when user quit quiz
  bool canAnswer = true;

  Question(
      {this.question,
      this.answers,
      this.correctAnswerIndex,
      this.numberOfQuestion,
      this.maxTime = 15}) {
    timeLeft = maxTime;
  }

  factory Question.fromQuestionModelBase64(
      QuestionModel modelBase64, numberOfQuestion) {
    final List<String> answersBase64 = []
      ..add(modelBase64.correctAnswer)
      ..addAll(modelBase64.incorrectAnswers)
      ..shuffle();

    final index = answersBase64.indexOf(modelBase64.correctAnswer);

    Codec<String, String> base64ToString = utf8.fuse(base64);
    var question = base64ToString.decode(modelBase64.question);

    List<String> answers = List<String>();
    for (var a in answersBase64) answers.add(base64ToString.decode(a));

    return Question(
      question: question,
      answers: answers,
      correctAnswerIndex: index,
      numberOfQuestion: numberOfQuestion,
    );
  }

  get isCorrect {
    if (chosenAnswerIndex == null) return false;
    if (correctAnswerIndex == chosenAnswerIndex)
      return true;
    else
      return false;
  }

  //i don't have listen this
  void startTime() async {
    if (isTimeRunning == false) {
      isTimeRunning = true;
      for (var i = timeLeft; i > 0; i--) {
        if(stopTime == false){
          debugPrint('$runtimeType: time go');
          timeLeft -= 1;
          await Future.delayed(Duration(seconds: 1));
        }
        else break;
      }
    }
  }

  //only run when i listen it
  Stream<int> startTick() {
    return Stream.periodic(Duration(seconds: 1), (x) {
      return timeLeft;
    }).take(timeLeft);
  }
}
