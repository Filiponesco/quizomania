part of 'timer_bloc.dart';

@immutable
abstract class TimerEvent {}
class Start extends TimerEvent {
  final Question question;
  Start(this.question);
}

class Tick extends TimerEvent {
  final int duration;
  final int maxDuration;
  Tick(this.duration, this.maxDuration);
}
class Stop extends TimerEvent{
  final int indexOfTime;
  Stop(this.indexOfTime);
}