import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  @JsonKey(name: 'correct_answer')
  final String correctAnswer;
  @JsonKey(name: 'incorrect_answers')
  final List<String> incorrectAnswers;
  bool answered = false;
  int answerId;

  Question(this.category, this.type, this.difficulty, this.question,
      this.correctAnswer, this.incorrectAnswers);

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  static List<Question> listFromJson(List<dynamic> list) =>
      list == null
          ? List<Question>()
          : list.map<Question>((dynamic value) => Question.fromJson(value)).toList();
}
