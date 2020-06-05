import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'AuthInitial{}';
  }
}

class AuthAuthenticated extends AuthState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'AuthAuthenticated{}';
  }
}

class AuthUnauthenticated extends AuthState {
  final String email;

  AuthUnauthenticated(this.email);

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'AuthUnauthenticated{email: $email}';
  }
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'AuthLoading{}';
  }
}
