import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/models/user_model.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserLoading()) {
    on<LoadUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await repository.fetchUsers();
        emit(UserLoaded(users: users, likedUsers: {}));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<ToggleLike>((event, emit) {
      if (state is UserLoaded) {
        final current = (state as UserLoaded);
        final liked = Set<int>.from(current.likedUsers);
        liked.contains(event.index)
            ? liked.remove(event.index)
            : liked.add(event.index);
        emit(UserLoaded(users: current.users, likedUsers: liked));
      }
    });
  }
}
