import 'package:quizomania/models/question_model.dart';

class Question {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;
  int chosenAnswerIndex;
  final int numberOfQuestion;

  get isCorrect {
    if (chosenAnswerIndex == null) return false;
    if (correctAnswerIndex == chosenAnswerIndex)
      return true;
    else
      return false;
  }

  Question(
      {this.question,
      this.answers,
      this.correctAnswerIndex,
      this.numberOfQuestion});

  factory Question.fromQuestionModel(QuestionModel model, numberOfQuestion) {
    final List<String> answers = []
      ..add(model.correctAnswer)
      ..addAll(model.incorrectAnswers)
      ..shuffle();

    final index = answers.indexOf(model.correctAnswer);

    return Question(
        question: model.question,
        answers: answers,
        correctAnswerIndex: index,
        numberOfQuestion: numberOfQuestion);
  }
}
