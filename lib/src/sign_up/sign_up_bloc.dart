import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
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
      final user = null;
      if (user == null) {
        yield SignUpLoadFailureEmailAlreadyRegistered();
      } else {
        yield SignUpLoadSuccess();
      }
    } catch (error) {
      yield SignUpLoadFailure();
    }
  }
}
