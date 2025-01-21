import 'package:das_app/ui/user/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/UserRepository.dart';
import 'event.dart';

final userRepository = UserRepository();

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(UserLoading());
      try {
        // Simulate a login process (replace with your actual login logic)
        await Future.delayed(const Duration(seconds: 2));

        if (event.username == 'test' && event.password == 'test') {
          emit(const UserSuccess(message: 'Login successful'));
        } else {
          emit(const UserFailure(error: 'Invalid credentials'));
        }
      } catch (e) {
        emit(UserFailure(error: e.toString()));
      }
    });
  }
}