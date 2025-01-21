part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();
}

final class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}
class UserLoading extends UserState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class UserLoggedIn extends UserState {
  final UserModel user;

  const UserLoggedIn(this.user);

  @override
  List<Object> get props => [user];
}

class UserLoginFailed extends UserState {
  final String error;

  const UserLoginFailed(this.error);

  @override
  List<Object> get props => [error];
}