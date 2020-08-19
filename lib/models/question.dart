import 'dart:convert';

import 'package:quizomania/models/question_model.dart';

class Question {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;
  int chosenAnswerIndex;
  final int numberOfQuestion;

  get isCorrect {
    if (chosenAnswerIndex == null) return false;
    if (correctAnswerIndex == chosenAnswerIndex)
      return true;
    else
      return false;
  }

  Question(
      {this.question,
      this.answers,
      this.correctAnswerIndex,
      this.numberOfQuestion});

  factory Question.fromQuestionModelBase64(QuestionModel modelBase64, numberOfQuestion) {
    final List<String> answersBase64 = []
      ..add(modelBase64.correctAnswer)
      ..addAll(modelBase64.incorrectAnswers)
      ..shuffle();

    final index = answersBase64.indexOf(modelBase64.correctAnswer);

    Codec<String, String> base64ToString = utf8.fuse(base64);
    var question = base64ToString.decode(modelBase64.question);

    List<String> answers = List<String>();
    for(var a in answersBase64)
      answers.add(base64ToString.decode(a));

    return Question(
        question: question,
        answers: answers,
        correctAnswerIndex: index,
        numberOfQuestion: numberOfQuestion);
  }
}
