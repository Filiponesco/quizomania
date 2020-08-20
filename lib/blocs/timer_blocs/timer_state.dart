part of 'timer_bloc.dart';

@immutable
abstract class TimerState {}

class TimerInitial extends TimerState {
  final int duration;

  TimerInitial(this.duration);
}

class IsRunning extends TimerInitial {
  IsRunning(duration) : super(duration);
}

class TimeStop extends TimerState {
  final String message;

  TimeStop(this.message);
}
