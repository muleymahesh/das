import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLoginEvent extends UserEvent {
  final String username;
  final String password;

  const UserLoginEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class UserLogoutEvent extends UserEvent {
  @override
  List<Object> get props => [];
}