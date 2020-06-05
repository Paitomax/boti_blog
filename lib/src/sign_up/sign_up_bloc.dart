import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';
import 'package:botiblog/src/sign_up/sign_up_repository_interface.dart';

import './bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepositoryInterface signUpRepository;
  final UserRepositoryInterface userRepository;

  SignUpBloc(this.signUpRepository, this.userRepository);

  @override
  SignUpState get initialState => SignUpInitial();

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignUpRequested) {
      yield* _mapSignUpRequestedToState(event);
    }
  }

  Stream<SignUpState> _mapSignUpRequestedToState(SignUpRequested event) async* {
    yield SignUpLoadInProgress();
    try {
      final user = await signUpRepository.requestSignUp(event.account);
      if (user == null) {
        yield SignUpLoadFailureEmailAlreadyRegistered();
      } else {
        await userRepository.save(user);
        yield SignUpLoadSuccess(user);
      }
    } catch (error) {
      yield SignUpLoadFailure();
    }
  }
}
