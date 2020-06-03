import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  @override
  SignInState get initialState => InitialSignInState();

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
