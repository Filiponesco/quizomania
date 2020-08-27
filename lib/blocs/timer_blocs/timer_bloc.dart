import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:quizomania/models/question.dart';

part 'timer_event.dart';

part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  StreamSubscription<int> _tickerSubscription;
  final String _message = 'Time over!';

  @override
  TimerState get initialState => TimerInitial(30, 30);

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is Start) {
      //cancel only subscribers but.. time for questions is ticking
      _tickerSubscription?.cancel();
      if (event.question.isTimeOver) yield TimeStop(_message);
      yield event.question.timeLeft > 0
          ? IsRunning(event.question.timeLeft, event.question.maxTime)
          : TimeStop(_message);
      _tickerSubscription = (event.question.startTick().listen(
        (duration) {
          add(Tick(duration, event.question.maxTime));
        },
      ));
      event.question.startTime();
    } else if (event is Tick) {
      yield event.duration > 0 ? IsRunning(event.duration, event.maxDuration) : TimeStop(_message);
      //yield IsRunning(event.question.timeLeft);
    } else if (event is Stop) {
      _tickerSubscription?.cancel();
      yield TimeStop('You can\'t answer');
    }
  }

  @override
  Future<void> close() {
    debugPrint('$runtimeType: tickers close');
    _tickerSubscription?.cancel();
    return super.close();
  }

  @override
  void onTransition(Transition<TimerEvent, TimerState> transition) {
    //debugPrint('$runtimeType:${transition.toString()}');
    super.onTransition(transition);
  }
}
