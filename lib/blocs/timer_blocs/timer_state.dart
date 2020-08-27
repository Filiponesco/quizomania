part of 'timer_bloc.dart';

@immutable
abstract class TimerState {}

class TimerInitial extends TimerState {
  final int duration;
  final int maxDuration;

  TimerInitial(this.duration, this.maxDuration);
}

class IsRunning extends TimerInitial {
  IsRunning(duration, maxDuration) : super(duration, maxDuration);
}

class TimeStop extends TimerState {
  final String message;

  TimeStop(this.message);
}
