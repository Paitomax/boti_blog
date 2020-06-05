import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';
import 'package:botiblog/src/sign_in/sign_in_repository_interface.dart';

import './bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInRepositoryInterface signInRepository;
  final UserRepositoryInterface userRepository;

  SignInBloc(this.signInRepository, this.userRepository);

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
        await userRepository.save(user);
        await userRepository.rememberUser(event.remember ? user.email : null);

        yield SignInLoadSuccess();
      }
    } catch (e) {
      yield SignInLoadFailure();
    }
  }
}
