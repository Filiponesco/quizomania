part of 'question_bloc.dart';
@immutable
abstract class QuestionState {
}

class LoadingQuestions extends QuestionState {}

class QuestionInitial extends QuestionState {
  final Question question;

  QuestionInitial(this.question);
}

class FirstQuestion extends QuestionInitial {
  FirstQuestion(Question question)
      : super(question);
}

class MiddleQuestion extends QuestionInitial {
  MiddleQuestion(Question question)
      : super(question);
}

class LastQuestion extends QuestionInitial {
  LastQuestion(Question question)
      : super(question);
}

class QuestionError extends QuestionState {}

class ScoreTable extends QuestionState {
  final int score;
  final int totalScore;
  final double percentage;

  ScoreTable(this.score, this.totalScore, this.percentage);
}
