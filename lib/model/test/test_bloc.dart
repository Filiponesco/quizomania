import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quizomania/model/enums_difficulty_answer.dart';
import 'package:quizomania/model/question.dart';
import 'package:quizomania/model/repository.dart';

part 'test_event.dart';

part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  int currentQuestion = 0;
  List<Question> questions;
  Repository repo = Repository();
  List<int> points;

  TestBloc();

  @override
  TestState get initialState => LoadingQuestions();

  @override
  Stream<TestState> mapEventToState(TestEvent event) async* {
    if (event is LoadTest) {
      yield LoadingQuestions();

      String difficulty = '';
      switch (event.difficulty) {
        case DifficultyLevel.easy:
          difficulty = 'easy';
          break;
        case DifficultyLevel.medium:
          difficulty = 'medium';
          break;
        case DifficultyLevel.hard:
          difficulty = 'hard';
          break;
      }
      try {
        questions = await repo.getQuestions(
            event.quantity, difficulty, event.categoryId);
        points = List.filled(questions.length, 0);
        yield FirstQuestion(questions[0], currentQuestion);
      } catch (e) {
        yield QuestionError();
        print("Error: " + e.toString());
      }
    } else if (event is NextQuestion) {
      if (currentQuestion + 1 < questions.length - 1) {
        currentQuestion++;
        yield MiddleQuestion(questions[currentQuestion], currentQuestion);
      } else if (currentQuestion + 1 == questions.length - 1) {
        currentQuestion++;
        yield LastQuestion(questions[currentQuestion], currentQuestion);
      }
    } else if (event is PreviousQuestion) {
      if (currentQuestion - 1 > 0) {
        currentQuestion--;
        yield MiddleQuestion(questions[currentQuestion], currentQuestion);
      } else if (currentQuestion - 1 == 0) {
        currentQuestion--;
        yield FirstQuestion(questions[currentQuestion], currentQuestion);
      }
    } else if (event is AnswerQuestion) {
      questions[event.questionNumber].answered = true;
      questions[event.questionNumber].answerId = event.id;
      if (questions[event.questionNumber].correctAnswer == event.answer) {
        points[event.questionNumber] = 1;
      } else {
        points[event.questionNumber] = 0;
      }
      if (event.questionNumber == 0)
        yield MiddleQuestion(questions[currentQuestion], currentQuestion);
      else if (event.questionNumber == questions.length - 1)
        yield LastQuestion(questions[currentQuestion], currentQuestion);
      else
        yield MiddleQuestion(questions[currentQuestion], currentQuestion);
    } else if (event is EndTest) {
      int sum =
          points.fold(0, (previousValue, element) => previousValue + element);
      yield ScoreTable(sum, questions.length, sum / questions.length);
    }
  }
}
