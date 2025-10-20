part of 'user_bloc.dart';

abstract class UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List users;
  final Set<int> likedUsers;

  UserLoaded({required this.users, required this.likedUsers});
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}
