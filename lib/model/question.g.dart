// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    json['category'] as String,
    json['type'] as String,
    json['difficulty'] as String,
    json['question'] as String,
    json['correct_answer'] as String,
    (json['incorrect_answers'] as List)?.map((e) => e as String)?.toList(),
  )
    ..answered = json['answered'] as bool
    ..answerId = json['answerId'] as int;
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'category': instance.category,
      'type': instance.type,
      'difficulty': instance.difficulty,
      'question': instance.question,
      'correct_answer': instance.correctAnswer,
      'incorrect_answers': instance.incorrectAnswers,
      'answered': instance.answered,
      'answerId': instance.answerId,
    };
