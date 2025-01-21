import 'package:das_app/data/db/objectbox.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/user.dart';

// Events
abstract class MyReportsEvent {}

class FetchUserDetails extends MyReportsEvent {}

// States
abstract class MyReportsState {}

class UserDetailsLoading extends MyReportsState {}

class UserDetailsLoaded extends MyReportsState {
  final User user;

  UserDetailsLoaded(this.user);
}

class UserDetailsError extends MyReportsState {
  final String error;

  UserDetailsError(this.error);
}

class MyReportsBloc extends Bloc<MyReportsEvent, MyReportsState> {
  MyReportsBloc() : super(UserDetailsLoading()) {
    on<FetchUserDetails>((event, emit) async {
      emit(UserDetailsLoading());
      try {
        final user = await _fetchUserDetails(); // Replace with your logic to fetch user details
        emit(UserDetailsLoaded(user));
      } catch (e) {
        emit(UserDetailsError(e.toString()));
      }
    });
  }

  Future<User> _fetchUserDetails() async {
    // Replace with your logic to fetch user details
    // ...
    ObjectBox db  = await ObjectBox.create();
    final box = db.store.box<User>();
    User user = box.getAll().first;
    db.store.close();
    return user;
  }
}