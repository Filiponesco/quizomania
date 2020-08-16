part of 'question_bloc.dart';

@immutable
abstract class QuestionEvent {}

class LoadTest extends QuestionEvent{}

class NextQuestion extends QuestionEvent{}

class PreviousQuestion extends QuestionEvent{}

class EndTest extends QuestionEvent{}

class AnswerQuestion extends QuestionEvent{
  final int index;

  AnswerQuestion(this.index);
}