import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:quizomania/services/ticker.dart';

part 'timer_event.dart';

part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  StreamSubscription<int> _tickerSubscription;
  final int _duration = 30;
  final String _message = 'Time over!';
  final int quantityQuestion;
  List<bool> _isQuestionVisited;
  int currentQuestion;

  get duration => _duration;

  TimerBloc({@required Ticker ticker, @required this.quantityQuestion})
      : assert(ticker != null),
        _ticker = ticker {
    _isQuestionVisited = List<bool>.filled(quantityQuestion, false);
  }

  @override
  TimerState get initialState => TimerInitial(_duration);

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is Start) {
        yield initialState;
        _tickerSubscription?.cancel();
        _tickerSubscription = _ticker.tick(ticks: _duration).listen(
              (duration) {
            add(Tick(duration));
          },
        );
    } else if (event is Tick) {
      yield event.duration > 0 ? IsRunning(event.duration) : TimeStop(_message);
    } else if (event is Stop) {
      _tickerSubscription?.cancel();
      yield TimeStop('You can\'t answer');
    } else if (event is NextPage) {
      currentQuestion++;
      if(_isQuestionVisited[currentQuestion] == false)
        add(Start());
      else add(Stop());

      _isQuestionVisited[currentQuestion] = true;
    } else if (event is BackPage) {
      currentQuestion--;
      add(Stop());
    } else if(event is FirstPage){
      currentQuestion = 0;
      if(_isQuestionVisited[currentQuestion] == false)
        add(Start());
      else add(Stop());
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription.cancel();
    return super.close();
  }

  @override
  void onTransition(Transition<TimerEvent, TimerState> transition) {
    debugPrint('$runtimeType:${transition.toString()}');
    super.onTransition(transition);
  }
}
