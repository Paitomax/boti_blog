import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'SignUpInitial{}';
  }
}

class SignUpLoadInProgress extends SignUpState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'SignUpLoadInProgress{}';
  }
}

class SignUpLoadSuccess extends SignUpState {
  final UserModel user;

  SignUpLoadSuccess(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() {
    return 'SignUpLoadSuccess{user: $user}';
  }
}

class SignUpLoadFailure extends SignUpState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'SignUpLoadFailure{}';
  }
}

class SignUpLoadFailureEmailAlreadyRegistered extends SignUpState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'SignUpLoadFailureEmailAlreadyRegistered{}';
  }
}
