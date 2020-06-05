import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthLoggedIn extends AuthEvent {
  final UserModel user;
  final bool rememberUser;

  AuthLoggedIn(this.user, this.rememberUser);

  @override
  List<Object> get props => [user];
}

class AuthLoggedOut extends AuthEvent {
  @override
  List<Object> get props => [];
}

class AuthAppInitiated extends AuthEvent {
  @override
  List<Object> get props => [];
}
