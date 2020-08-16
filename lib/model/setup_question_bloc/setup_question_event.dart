part of 'setup_question_bloc.dart';

@immutable
abstract class SetupQuestionEvent {}

class SelectDifficulty extends SetupQuestionEvent{
  final DifficultyLevel difficultyLevel;
  SelectDifficulty({this.difficultyLevel});
}
class PickNumberOfQuestion extends SetupQuestionEvent{
  final int numberOfQuestion;
  PickNumberOfQuestion({this.numberOfQuestion});
}
class GoToQuiz extends SetupQuestionEvent{
}
class CloseDialog extends SetupQuestionEvent{}