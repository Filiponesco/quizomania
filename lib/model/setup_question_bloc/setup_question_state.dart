part of 'setup_question_bloc.dart';

@immutable
abstract class SetupQuestionState extends Equatable {
  @override
  List<Object> get props => [];
}

class SetupQuestionInitial extends SetupQuestionState {
  final DifficultyLevel difficultyLevel;
  final int numberOfQuestions;

  SetupQuestionInitial(this.difficultyLevel, this.numberOfQuestions);

  @override
  List<Object> get props => [difficultyLevel, numberOfQuestions];
}

class ClosedDialog extends SetupQuestionState {}

class StartedQuiz extends SetupQuestionInitial {
  StartedQuiz(DifficultyLevel difficultyLevel, int numberOfQuestions)
      : super(difficultyLevel, numberOfQuestions);
}
