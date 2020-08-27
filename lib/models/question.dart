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
  bool isTimeOver = false;
  final int maxTime;

  Question(
      {this.question,
      this.answers,
      this.correctAnswerIndex,
      this.numberOfQuestion,
      this.maxTime = 30}) {
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
        timeLeft -= 1;
        await Future.delayed(Duration(seconds: 1));
      }
      isTimeOver = true;
    }
  }

  //only run when i listen it
  Stream<int> startTick() {
    return Stream.periodic(Duration(seconds: 1), (x) {
      debugPrint('$runtimeType: timeLeft: $timeLeft');
      return timeLeft;
    }).take(timeLeft);
  }
}
