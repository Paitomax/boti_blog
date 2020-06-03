import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:botiblog/src/sign_in/sign_in_repository_interface.dart';
import './bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInRepositoryInterface signInRepository;

  SignInBloc(this.signInRepository);

  @override
  SignInState get initialState => SignInInitial();

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
