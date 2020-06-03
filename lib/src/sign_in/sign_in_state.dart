import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInLoadInProgress extends SignInState {
  final String email;
  final String password;

  SignInLoadInProgress(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignInLoadSuccess extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInLoadFailure extends SignInState {
  @override
  List<Object> get props => [];
}
