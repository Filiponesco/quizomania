import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizomania/blocs/setup_question_blocs/setup_question_bloc.dart';
import 'package:quizomania/models/enums_difficulty_answer.dart';
import 'package:quizomania/services/repository.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements Repository{}

void main() {
  const DifficultyLevel initLevel = DifficultyLevel.medium;
  const int initQuantity = 5;
  const DifficultyLevel pickedLevel = DifficultyLevel.hard;
  const int pickedQuantity = 3;

    group('SetupQuestionBloc', () {
      blocTest(
        'Initialize',
        build: () => SetupQuestionBloc(initLevel, initQuantity),
        expect: [],
      );

      blocTest(
          'Change difficulty to hard',
          build: () => SetupQuestionBloc(initLevel, initQuantity),
          act: (bloc) => bloc.add(SelectDifficulty(difficultyLevel: pickedLevel)),
          expect: [SetupQuestionInitial(pickedLevel, initQuantity)],
      );
      blocTest(
        'Change quantity of questions',
        build: () => SetupQuestionBloc(initLevel, initQuantity),
        act: (bloc) => bloc.add(PickNumberOfQuestion(numberOfQuestion: pickedQuantity)),
        expect: [SetupQuestionInitial(initLevel, pickedQuantity)],
      );
      blocTest(
        'Start quiz',
        build: () => SetupQuestionBloc(initLevel, initQuantity),
        act: (bloc) => bloc.add(GoToQuiz()),
        expect: [StartedQuiz(initLevel, initQuantity)],
      );
      blocTest(
        'Go back',
        build: () => SetupQuestionBloc(initLevel, initQuantity),
        act: (bloc) => bloc.add(CloseDialog()),
        expect: [ClosedDialog()],
      );
    });
}