part of 'user_bloc.dart';

abstract class UserEvent {}

class LoadUsers extends UserEvent {}

class ToggleLike extends UserEvent {
  final int index;
  ToggleLike(this.index);
}
