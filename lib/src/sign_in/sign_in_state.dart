import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInLoadInProgress extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInLoadFailure extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInLoadFailureWrongUserOrPass extends SignInState {
  @override
  List<Object> get props => [];
}
