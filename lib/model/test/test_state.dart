part of 'test_bloc.dart';

@immutable
abstract class TestState {}

class LoadingQuestions extends TestState {}

class QuestionState extends TestState {
  final Question question;
  final int questionNumber;

  QuestionState(this.question, this.questionNumber);
}

class FirstQuestion extends QuestionState {
  FirstQuestion(Question question, int questionNumber)
      : super(question, questionNumber);
}

class MiddleQuestion extends QuestionState {
  MiddleQuestion(Question question, int questionNumber)
      : super(question, questionNumber);
}

class LastQuestion extends QuestionState {
  LastQuestion(Question question, int questionNumber)
      : super(question, questionNumber);
}

class QuestionError extends TestState {}

class ScoreTable extends TestState {
  final int score;
  final int totalScore;
  final double percentage;

  ScoreTable(this.score, this.totalScore, this.percentage);
}
