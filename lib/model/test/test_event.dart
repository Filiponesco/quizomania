part of 'test_bloc.dart';

@immutable
abstract class TestEvent {}

class LoadTest extends TestEvent{
  final int categoryId;
  final DifficultyLevel difficulty;
  final int quantity;

  LoadTest(this.categoryId, this.difficulty, this.quantity);
}

class NextQuestion extends TestEvent{}

class PreviousQuestion extends TestEvent{}

class EndTest extends TestEvent{}

class AnswerQuestion extends TestEvent{
  final int questionNumber;
  final String answer;
  final int id;

  AnswerQuestion(this.questionNumber, this.answer, this.id);
}