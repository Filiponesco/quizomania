import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:quizomania/models/enums_difficulty_answer.dart';

part 'setup_question_event.dart';

part 'setup_question_state.dart';

class SetupQuestionBloc extends Bloc<SetupQuestionEvent, SetupQuestionState> {
  DifficultyLevel _difficultyLevel;
  int _numberOfQuestion;

  SetupQuestionBloc(this._difficultyLevel, this._numberOfQuestion)
      : super(SetupQuestionInitial(_difficultyLevel, _numberOfQuestion));

  @override
  Stream<SetupQuestionState> mapEventToState(
    SetupQuestionEvent event,
  ) async* {
    if (event is PickNumberOfQuestion) {
      _numberOfQuestion = event.numberOfQuestion;
      yield (SetupQuestionInitial(_difficultyLevel, _numberOfQuestion));
    } else if (event is SelectDifficulty) {
      _difficultyLevel = event.difficultyLevel;
      yield (SetupQuestionInitial(_difficultyLevel, _numberOfQuestion));
    } else if (event is CloseDialog) {
      yield ClosedDialog();
    } else if (event is GoToQuiz) {
      //if(_category)
      yield StartedQuiz(_difficultyLevel, _numberOfQuestion);
    }
  }
  @override
  void onTransition(Transition<SetupQuestionEvent, SetupQuestionState> transition) {
    debugPrint('$runtimeType: $transition');
    super.onTransition(transition);
  }
}
