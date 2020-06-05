import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'SignInInitial{}';
  }
}

class SignInLoadInProgress extends SignInState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'SignInLoadInProgress{}';
  }
}

class SignInLoadFailure extends SignInState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'SignInLoadFailure{}';
  }
}

class SignInLoadFailureWrongUserOrPass extends SignInState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'SignInLoadFailureWrongUserOrPass{}';
  }
}
