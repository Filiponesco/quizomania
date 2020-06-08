part of 'test_bloc.dart';

@immutable
abstract class TestEvent {}

class NextQuestion extends TestEvent{}

class PreviousQuestion extends TestEvent{}

class EndTest extends TestEvent{}

class AnswerQuestion extends TestEvent{
  final int questionNumber;
  final int answerId;

  AnswerQuestion(this.questionNumber, this.answerId);
}