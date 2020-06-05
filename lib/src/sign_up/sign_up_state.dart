import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoadInProgress extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoadSuccess extends SignUpState {
  final UserModel user;

  SignUpLoadSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class SignUpLoadFailure extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoadFailureEmailAlreadyRegistered extends SignUpState {
  @override
  List<Object> get props => [];
}
