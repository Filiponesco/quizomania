import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quizomania/model/category.dart';
import 'package:quizomania/model/question.dart';

part 'test_event.dart';

part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final int categoryId;
  int currentQuestion = 0;

  List<Question> questions = [
    Question(
        Category(1, "Filmy"),
        "typ",
        "łatwe",
        "Which movie released in 2016 features Superman and Batman fighting?",
        "Batman v Superman: Dawn of Justice", [
      "Batman v Superman: Superapocalypse",
      "Batman v Superman: Black of Knight",
      "Batman v Superman: Knightfall"
    ]),
    Question(
        Category(1, "Filmy"),
        "typ",
        "łatwe",
        "Daniel Radcliffe became a global star in the film industry due to his performance in which film franchise?",
        "Harry Potter",
        ["Ted", "Spy Kids", "Pirates of the Caribbean"]),
    Question(
        Category(1, "Filmy"),
        "typ",
        "łatwe",
        "Who starred as Bruce Wayne and Batman in Tim Burton's 1989 movie 'Batman'?",
        "Michael Keaton",
        ["George Clooney", "Val Kilmer", "Adam West"]),
  ];

  TestBloc(this.categoryId);

  @override
  TestState get initialState =>
      FirstQuestion(questions[currentQuestion], currentQuestion);

  @override
  Stream<TestState> mapEventToState(TestEvent event) async* {
    if (event is NextQuestion) {
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
      questions[event.questionNumber].answerId = event.answerId;
      if (event.questionNumber == 0)
        yield MiddleQuestion(questions[currentQuestion], currentQuestion);
      else if (event.questionNumber == questions.length - 1)
        yield LastQuestion(questions[currentQuestion], currentQuestion);
      else
        yield MiddleQuestion(questions[currentQuestion], currentQuestion);
    } else if (event is EndTest) {
      yield ScoreTable(1, questions.length, 1 / 3);
    }
  }
}
