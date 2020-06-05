import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:botiblog/src/shared/consts/app_limits.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepositoryInterface userRepository;

  AuthBloc(this.userRepository);

  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthAppInitiated) {
      yield* _mapAuthAppInitiatedToState();
    } else if (event is AuthLoggedIn) {
      yield* _mapAuthLoggedInToState(event);
    } else if (event is AuthLoggedOut) {
      yield* _mapAuthLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAuthAppInitiatedToState() async* {
    String user = await userRepository.getLastUser();
    await Future.delayed(
        Duration(milliseconds: AppLimits.splashTimeLimitInMilliseconds));

    yield AuthUnauthenticated(user);
  }

  Stream<AuthState> _mapAuthLoggedInToState(AuthLoggedIn event) async* {
    await userRepository.save(event.user);
    userRepository.rememberUser(event.rememberUser ? event.user.email : null);
    yield AuthAuthenticated();
  }

  Stream<AuthState> _mapAuthLoggedOutToState() async* {
    userRepository.logout();
    String user = await userRepository.getLastUser();
    yield AuthUnauthenticated(user);
  }
}
