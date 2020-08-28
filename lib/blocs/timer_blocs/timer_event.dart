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
class StopAll extends TimerEvent{
}
class AnswerStop extends TimerEvent{
  final Question question;
  AnswerStop(this.question);
}