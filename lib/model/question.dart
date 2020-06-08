import 'package:quizomania/model/category.dart';

class Question{
  final Category category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  bool answered = false;
  int answerId;

  Question(this.category, this.type, this.difficulty, this.question, this.correctAnswer, this.incorrectAnswers);
}