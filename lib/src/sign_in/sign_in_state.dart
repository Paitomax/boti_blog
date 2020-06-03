import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class InitialSignInState extends SignInState {
  @override
  List<Object> get props => [];
}
