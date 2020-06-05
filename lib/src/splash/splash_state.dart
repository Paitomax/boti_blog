import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashLoadInProgress extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashLoadSuccess extends SplashState {
  final String user;

  SplashLoadSuccess(this.user);

  @override
  List<Object> get props => [user];
}
