import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
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

  QuestionModel(this.category, this.type, this.difficulty, this.question,
      this.correctAnswer, this.incorrectAnswers);

  factory QuestionModel.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  static List<QuestionModel> listFromJson(List<dynamic> list) =>
      list == null
          ? List<QuestionModel>()
          : list.map<QuestionModel>((dynamic value) => QuestionModel.fromJson(value)).toList();
}
