part of 'timer_bloc.dart';

@immutable
abstract class TimerEvent {}
class Start extends TimerEvent {}

class Tick extends TimerEvent {
  final int duration;
  Tick(this.duration);
}
class FirstPage extends TimerEvent{}
class Stop extends TimerEvent{}
class NextPage extends TimerEvent {}
class BackPage extends TimerEvent {}