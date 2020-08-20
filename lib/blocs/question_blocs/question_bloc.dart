import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:quizomania/models/category.dart';
import 'package:quizomania/models/enums_difficulty_answer.dart';
import 'package:quizomania/models/question.dart';
import 'package:quizomania/models/question_model.dart';
import 'package:quizomania/services/repository.dart';
import 'package:quizomania/services/ticker.dart';

part 'question_event.dart';

part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  int currentQuestion = 0;
  List<Question> questions;
  Repository repo = Repository();
  List<int> points;
  final Category currentCategory;
  final DifficultyLevel difficulty;
  final int quantity;

  QuestionBloc({this.currentCategory, this.quantity, this.difficulty});

  @override
  QuestionState get initialState => LoadingQuestions();

  @override
  Stream<QuestionState> mapEventToState(QuestionEvent event) async* {
    if (event is LoadTest) {
      debugPrint('$runtimeType: yield: LoadingQuestions()');
      yield LoadingQuestions();

      String level = '';
      switch (difficulty) {
        case DifficultyLevel.easy:
          level = 'easy';
          break;
        case DifficultyLevel.medium:
          level = 'medium';
          break;
        case DifficultyLevel.hard:
          level = 'hard';
          break;
      }
      try {
        List<QuestionModel> questionsModel =
            await repo.getQuestions(quantity, level, currentCategory.id);
        points = List.filled(questionsModel.length, 0);
        questions = List<Question>();
        for (var i = 0; i < questionsModel.length; i++)
          questions.add(Question.fromQuestionModelBase64(
              questionsModel[i], i));
        debugPrint('$runtimeType: yield: FirstQuestions()');
        yield FirstQuestion(questions[0]);

      } catch (e) {
        yield QuestionError();
        debugPrint('$runtimeType: Error: ' + e.toString());
      }
    } else if (event is NextQuestion) {
      if (currentQuestion + 1 < questions.length - 1) {
        currentQuestion++;
        debugPrint('$runtimeType: yield: MiddleQuestions()');
        yield MiddleQuestion(questions[currentQuestion]);
      } else if (currentQuestion + 1 == questions.length - 1) {
        currentQuestion++;
        debugPrint('$runtimeType: yield: LastQuestions()');
        yield LastQuestion(questions[currentQuestion]);
      }
    } else if (event is PreviousQuestion) {
      if (currentQuestion - 1 > 0) {
        currentQuestion--;
        debugPrint('$runtimeType: yield: MiddleQuestion()');
        yield MiddleQuestion(questions[currentQuestion]);
      } else if (currentQuestion - 1 == 0) {
        currentQuestion--;
        debugPrint('$runtimeType: yield: FirstQuestion()');
        yield FirstQuestion(questions[currentQuestion]);
      }
    } else if (event is AnswerQuestion) {
      Question q = questions[currentQuestion];
      q.chosenAnswerIndex = event.index;
      if (q.isCorrect) {
        points[q.numberOfQuestion] = 1;
      } else {
        points[q.numberOfQuestion] = 0;
      }
      if (q.numberOfQuestion == 0) {
        debugPrint('$runtimeType: yield: FirstQuestion()');
        yield FirstQuestion(questions[currentQuestion]);
      } else if (q.numberOfQuestion == questions.length - 1) {
        debugPrint('$runtimeType: yield: LastQuestion()');
        yield LastQuestion(questions[currentQuestion]);
      } else {
        debugPrint('$runtimeType: yield: MiddleQuestion()');
        yield MiddleQuestion(questions[currentQuestion]);
      }
    } else if (event is EndTest) {
      int sum =
          points.fold(0, (previousValue, element) => previousValue + element);
      debugPrint('$runtimeType: yield: ScoreTable()');
      yield ScoreTable(sum, questions.length, sum / questions.length);
    }
  }
}
