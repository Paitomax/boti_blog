import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthAuthenticated extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthUnauthenticated extends AuthState {
  final String email;

  AuthUnauthenticated(this.email);

  @override
  List<Object> get props => [email];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}
