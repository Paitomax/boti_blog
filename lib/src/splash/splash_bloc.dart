import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:botiblog/src/shared/current_datetime/current_date.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';
import './bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final UserRepositoryInterface userRepository;
  final CurrentDateTime currentDateTime;

  SplashBloc(this.userRepository, this.currentDateTime);

  @override
  SplashState get initialState => SplashInitial();

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is SplashLoaded) {
      yield* _mapSplashLoadedToState();
    }
  }

  Stream<SplashState> _mapSplashLoadedToState() async* {
    final initTime = currentDateTime.now();
    yield SplashLoadInProgress();
    String user = await userRepository.getLastUser();
    final finalTime = currentDateTime.now();

    final diff = finalTime.difference(initTime);
    if (diff.inMilliseconds < 4000) {
      await Future.delayed(Duration(milliseconds: 4000 - diff.inMilliseconds));
    }
    yield SplashLoadSuccess(user);
  }
}
