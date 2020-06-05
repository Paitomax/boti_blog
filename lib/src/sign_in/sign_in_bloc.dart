import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:botiblog/src/shared/auth/auth_bloc.dart';
import 'package:botiblog/src/shared/auth/auth_event.dart';
import 'package:botiblog/src/sign_in/sign_in_repository_interface.dart';

import './bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInRepositoryInterface signInRepository;
  final AuthBloc authBloc;

  SignInBloc(this.signInRepository, this.authBloc);

  @override
  SignInState get initialState => SignInInitial();

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is SignInRequested) {
      yield* _mapSignInRequestedToState(event);
    }
  }

  Stream<SignInState> _mapSignInRequestedToState(SignInRequested event) async* {
    yield SignInLoadInProgress();
    try {
      final user =
          await signInRepository.requestLogin(event.email, event.password);
      if (user == null) {
        yield SignInLoadFailureWrongUserOrPass();
      } else {
        authBloc.add(AuthLoggedIn(user, event.remember));
        yield SignInInitial();
      }
    } catch (e) {
      yield SignInLoadFailure();
    }
  }
}
